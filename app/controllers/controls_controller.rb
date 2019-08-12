class ControlsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  def home

    linley_br_led_status = Nokogiri::HTML(open("http://192.168.10.152/relaystatus.php?action=linley_status"))

    linley_br_led_status.search('p').each do |lbr|
      if lbr.content == "0"
        linley_br_led_status = "linley_br_led_off.png"
      else
        linley_br_led_status = "linley_br_led_on.png"
      end
    end

    @g_door_1 = "garage_door_1.png"
    @g_door_2 = "garage_door_2.png"
    @shop_door_1 = "shop_door_1.png"
    @g_light_1 = "garage_light_1.png"
    @g_light_2 = "garage_light_2.png"
    @s_light_1_on = "shop_light_1_on.png"
    @s_light_1_off = "shop_light_1_off.png"
    @kitchen_day_light = "kitchen_day_light_off.png"
    @mbr_led = "mbr_led_off.png"
    @linley_br_led = linley_br_led_status

  end
end
