#!/usr/bin/env python

import pigpio

class decoder:

   def __init__(self, pi, gpio_0, gpio_1, LED, BEEP, DOOR, callback, bit_timeout=5):
      self.pi = pi
      self.gpio_0 = gpio_0
      self.gpio_1 = gpio_1
      self.LED = LED
      self.BEEP = BEEP
      self.DOOR = DOOR
      self.callback = callback
      self.bit_timeout = bit_timeout
      self.in_code = False

      self.pi.set_mode(gpio_0, pigpio.INPUT)
      self.pi.set_mode(gpio_1, pigpio.INPUT)

      self.pi.set_pull_up_down(gpio_0, pigpio.PUD_UP)
      self.pi.set_pull_up_down(gpio_1, pigpio.PUD_UP)

      self.cb_0 = self.pi.callback(gpio_0, pigpio.FALLING_EDGE, self._cb)
      self.cb_1 = self.pi.callback(gpio_1, pigpio.FALLING_EDGE, self._cb)

   def _cb(self, gpio, level, tick):
      if level < pigpio.TIMEOUT:
         if self.in_code == False:
            self.bits = 1
            self.num = 0
            self.in_code = True
            self.code_timeout = 0
            self.pi.set_watchdog(self.gpio_0, self.bit_timeout)
            self.pi.set_watchdog(self.gpio_1, self.bit_timeout)
         else:
            self.bits += 1
            self.num = self.num << 1
         if gpio == self.gpio_0:
            self.code_timeout = self.code_timeout & 2 # clear gpio 0 timeout
         else:
            self.code_timeout = self.code_timeout & 1 # clear gpio 1 timeout
            self.num = self.num | 1
      else:
         if self.in_code:
            if gpio == self.gpio_0:
               self.code_timeout = self.code_timeout | 1 # timeout gpio 0
            else:
               self.code_timeout = self.code_timeout | 2 # timeout gpio 1
            if self.code_timeout == 3: # both gpios timed out
               self.pi.set_watchdog(self.gpio_0, 0)
               self.pi.set_watchdog(self.gpio_1, 0)
               self.in_code = False
               self.callback(self.bits, self.num)

   def cancel(self):
      self.cb_0.cancel()
      self.cb_1.cancel()

if __name__ == "__main__":
   import time
   import pigpio
   import wiegand
   import psycopg2

   LED = 23
   BEEP = 24
   DOOR = 25
   pi = pigpio.pi()
   pi.set_mode(LED, pigpio.OUTPUT) #Green LED
   pi.set_mode(BEEP, pigpio.OUTPUT) #Beeper
   pi.set_mode(DOOR, pigpio.OUTPUT) #Door Relay

   def nonexist():
      pi.write(LED, 1)
      pi.write(BEEP, 1)
      time.sleep(1)
      pi.write(LED, 0)
      pi.write(BEEP, 0)
      time.sleep(1)
      pi.write(LED, 1)
      pi.write(BEEP, 1)
      time.sleep(1)
      pi.write(LED, 0)
      pi.write(BEEP, 0)
      time.sleep(1)
      pi.write(LED, 1)
      pi.write(BEEP, 1)
      time.sleep(1)
      pi.write(LED, 0)
      pi.write(BEEP, 0)

   def match():
      pi.write(BEEP, 1)
      time.sleep(.25)
      pi.write(BEEP, 0)
      time.sleep(.25)
      pi.write(BEEP, 1)
      time.sleep(.25)
      pi.write(BEEP, 0)
      time.sleep(.25)
      pi.write(BEEP, 1)
      time.sleep(.25)
      pi.write(BEEP, 0)
      pi.write(LED, 1)
      pi.write(DOOR, 1)
      time.sleep(5)
      pi.write(LED, 0)
      pi.write(DOOR, 0)

   def no_match():
      pi.write(LED, 1)
      pi.write(BEEP, 1)
      time.sleep(1)
      pi.write(LED, 0)
      pi.write(BEEP, 0)
      time.sleep(1)
      pi.write(LED, 1)
      pi.write(BEEP, 1)
      time.sleep(1)
      pi.write(LED, 0)
      pi.write(BEEP, 0)
      time.sleep(1)
      pi.write(LED, 1)
      pi.write(BEEP, 1)
      time.sleep(1)
      pi.write(LED, 0)
      pi.write(BEEP, 0)

   connection = psycopg2.connect(
      user="dusterg20",
      password="i@20dg2k",
      host="192.168.10.250",
      port="5432",
      database="dusterg20"
   )
   cursor = connection.cursor()

   def callback(bits, value):
      try:
         sql = "select key_code from access_controls where access_controls.key_code = %s"
         cursor.execute(sql, (value,))
         key_code = cursor.fetchall()
         for row in key_code:
            sec_id = row[0]
         try:
            sec_id
         except NameError:
            print("Key Code does not Exist")
            print("Unknown Input Key Code={}".format(value))
            nonexist()
         else:
            if sec_id == value:
               print("Key Code Match")
               print("Input Key Code={} Matched Code={}".format(value, sec_id))
               match()
            else:
               print("Key Code does not Match")
               print("Invalid Input Key Code={}".format(value))
               no_match()

      except (Exception, psycopg2.Error) as error :
         print("Error fetching data from PostgreSQL", error)
      #print("bits={} code={}".format(bits, value))
      print("Prox Card read Complete.")

   pi = pigpio.pi()
   w = wiegand.decoder(pi, 14, 15, callback)

   while True:
      raw_input()
   if(connection):
      cursor.close()
      connection.close()
      print("DB connection closed")
   w.cancel()
   pi.stop()
