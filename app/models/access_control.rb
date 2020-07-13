class AccessControl < ApplicationRecord
  has_many :access_permissions, dependent: :destroy
  has_many :access_control_doors, :through => :access_permissions
  before_save :downcase_badge_holder_email
  validates :key_code, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :badge_holder_email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates_format_of :badge_holder_phone, :with => /\(?[0-9]{3}\)?\s[0-9]{3}-[0-9]{4}/,
  :message => "- Phone numbers must be in (xxx) xxx-xxxx format."

  private

    # Converts email to all lower-case.
    def downcase_badge_holder_email
      self.badge_holder_email = badge_holder_email.downcase
    end

end
