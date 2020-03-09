class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: :user_present?

  validate :user_email_already_exists?, unless: :user_present?
  validates :user, uniqueness: { scope: :event_id }, if: :user_present?
  validates :user_email, uniqueness: { scope: :event_id }, unless: :user_present?

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def user_email_already_exists?
    errors.add(:user_email, I18n.t('activerecord.error.email')) if User.exists?(email: user_email)
  end

  def user_present?
    user.present?
  end
end
