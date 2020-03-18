class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }

  scope :newest_first, -> { order(created_at: :desc) }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end
end
