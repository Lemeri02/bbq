class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook vkontakte]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def link_subscriptions
    Subscription.where(
      user_id: nil, user_email: self.email
    ).update_all(user_id: self.id)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def self.find_for_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first
    name = access_token.info.name

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    url = generate_url(provider, id)
    remote_avatar_url = access_token.info.image

    where(url: url, provider: provider).first_or_create! do |user|
      user.name = name
      user.email = email
      user.remote_avatar_url = remote_avatar_url
      user.password = Devise.friendly_token.first(16)
    end
  end

  def self.generate_url(provider, id)
    case provider
    when 'facebook' then "https://facebook.com/#{id}"
    when 'vkontakte' then "https://vk.com/id#{id}"
    end
  end
end
