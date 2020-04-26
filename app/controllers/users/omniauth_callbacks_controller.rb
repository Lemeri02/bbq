class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :find_or_create_user, only: %i[facebook vkontakte]

  def facebook
    sign_in_user(@user)
  end

  def vkontakte
    sign_in_user(@user)
  end

  private

  def find_or_create_user
    @user = User.find_for_oauth(request.env['omniauth.auth'])
  end

  def sign_in_user(user)
    if user.persisted?
      flash[:notice] = I18n.t(
        'devise.omniauth_callbacks.success',
        kind: "#{user.provider&.capitalize}"
      )

      sign_in_and_redirect user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: "#{user.provider&.capitalize}",
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end
end
