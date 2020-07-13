class AccessControlDoor < ApplicationRecord
  has_many :access_permissions
  has_many :access_controls, :through => :access_permissions
  validates :reader_serial, presence: true, uniqueness: true
end
