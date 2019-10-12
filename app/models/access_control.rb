class AccessControl < ApplicationRecord
  validates :key_code, presence: true, uniqueness: { case_sensitive: false }
end
