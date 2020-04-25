module EmailFilter
  EMAIL_REGEX = /^[a-zA-Z0-9_.+-]+@(facebook|vkontakte)/.freeze

  module_function

  def email_list(resource)
    case resource
    when Comment, Photo
      event = resource.event

      all_emails = (
        event.subscriptions.map(&:user_email) +
        [event.user.email] -
        [resource.user&.email]
      ).uniq

      all_emails.delete_if { |x| x =~ EMAIL_REGEX }
    when Subscription
      email = resource.event.user.email
      return email unless email =~ EMAIL_REGEX
    end
  end
end
