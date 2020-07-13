# frozen_string_literal: true

class ControlsController < ApplicationController
  before_action :auth_user, only: [:home, :edit, :update, :destroy,
                                   :index, :create, :action]

  require 'nokogiri'
  require 'open-uri'

  def home
    linley_br_led_status = Nokogiri::HTML(open(
      "http://192.168.10.152/relaystatus.php?action=linley_status"))

    linley_br_led_status.search('p').each do |lbr|
      @lbr_result = lbr.content
      if lbr.content.gsub("\n", "") == "0"
        linley_br_led_status = "linley_br_led_off.png"
      else
        linley_br_led_status = "linley_br_led_on.png"
      end
    end

    mbr_led_status = Nokogiri::HTML(open(
      "http://192.168.10.151/ha_api.php?action=status&pin=26"))

    mbr_led_status.search('p').each do |mbr|
      @mbr_result = mbr.content
      if mbr.content.gsub("\n", "") == "0"
        mbr_led_status = "mbr_led_off.png"
      else
        mbr_led_status = "mbr_led_on.png"
      end
    end

    kitchen_led_status = Nokogiri::HTML(open(
     "http://192.168.10.152/led_auto_pi3.php?action=k_led_status",
     :read_timeout => 2))

    kitchen_led_status.search('p').each do |k_led_status|
      @k_led_status = k_led_status.content.gsub("\n", "")
      if @k_led_status == "0"
        kitchen_led_status = "kitchen_day_light_off.png"
      else
        kitchen_led_status = "kitchen_day_light_on.png"
      end
    end

    tempurature = Nokogiri::HTML(open("http://192.168.10.152/temp/temp.txt"))

    tempurature.search('p').each do |temp_s_value|
      @temp_value = temp_s_value.content
    end

    humidity = Nokogiri::HTML(open("http://192.168.10.152/temp/humid.txt"))

    humidity.search('p').each do |humid_s_value|
      @humid_value = humid_s_value.content
    end

    ssrpage = Nokogiri::HTML(open("http://192.168.10.199/30000", :read_timeout => 2))

    ssr_search = ssrpage.xpath('//p[contains(text(), " Relay-05: ")]')

    if ssr_search.empty?
      ssr_page_1 = "http://192.168.10.199/30000"
      ssr_page_2 = "http://192.168.10.199/30000/43"
    else
      ssr_page_1 = "http://192.168.10.199/30000/43"
      ssr_page_2 = "http://192.168.10.199/30000"
    end

    ssr_r8_page = Nokogiri::HTML(open("#{ssr_page_2}", :read_timeout => 2))

    ssr_r8_search = ssr_r8_page.xpath('//p[contains(text(), " Relay-08: ")]')

    ssr_r8_search.search('p').each do |ssr_r8_status|
      @ssr_r8_result = ssr_r8_status.content.gsub(" Relay-08:  OFF&nbsp&nbsp ON/OFF-08", "OFF")
    end

    if @ssr_r8_result == "OFF"
      ssr_r8_status = "shop_light_1_off.png"
    else
      ssr_r8_status = "shop_light_1_on.png"
    end

    time = Time.now
    @time_format = time.strftime("%I:%M %p")
    @day = time.strftime("%A")
    @date_format = time.strftime("%B %d, %Y")

    @g_door_1 = "garage_door_1.png"
    @g_door_2 = "garage_door_2.png"
    @shop_door_1 = "shop_door_1.png"
    @g_light_1 = "garage_light_1.png"
    @g_light_2 = "garage_light_2.png"
    @s_light_1 = ssr_r8_status
    @kitchen_day_light = kitchen_led_status
    @mbr_led = mbr_led_status
    @linley_br_led = linley_br_led_status

  end

  def action
    @action = params[:action_id]

    if @action == "mbr_toggle"
      Nokogiri::HTML(open("http://192.168.10.151/ha_api.php?action=toggle&pin=26"))
      redirect_to controls_path
    end
  end

  private

  #confirms a logged in user.
  def auth_user
    if !current_user
      redirect_to root_url
    end
  end

  # Confirms an admin user.
  def auth_admin
    if !current_user.admin
      redirect_back
    end
  end
end
