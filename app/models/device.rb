# frozen_string_literal: true

class Device < ApplicationRecord
  validates :dev_name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
  validates :dev_pin1, presence: true, length: { maximum: 2 }
end
