class AccessPermission < ApplicationRecord
  belongs_to :access_control
  belongs_to :access_control_door
end
