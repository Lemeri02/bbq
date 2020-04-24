class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      redirect_and_notify(@user)
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Facebook',
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end

  def vkontakte
    @user = User.find_for_vkontakte_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      redirect_and_notify(@user)
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Vkontakte',
        reason: 'authentication error'
      )

      redirect_to root_path
    end
  end

  private

  def redirect_and_notify(user)
    if user.email.split('@').include?('vkontakte' || 'facebook')
      flash[:alert] = I18n.t('controllers.users.email_is_not_valid')

      sign_in(:user, user)
      redirect_to edit_user_path(user)
    else
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: "#{user.provider.capitalize}")

      sign_in_and_redirect @user, event: :authentication
    end
  end
end
