# frozen_string_literal: true

class Rpi < ApplicationRecord
  has_many :devices, dependent: :destroy
  require 'resolv'
  validates :rpi_name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
  validates :rpi_ip, presence: true, :format => { :with => Resolv::IPv4::Regex }
end
