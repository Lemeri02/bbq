class SubscribersNotificationJob < ApplicationJob

  queue_as :default

  def perform(*args)
    @resource = args.first

    case @resource
    when Comment
      email_list(@resource).each do |mail|
        EventMailer.comment(@resource, mail).deliver_later
      end
    when Photo
      email_list(@resource).each do |mail|
        EventMailer.photo(@resource, mail).deliver_later
      end
    when Subscription
      EventMailer.subscription(@resource).deliver_later
    end
  end

  private

  def email_list(resource)
    event = resource.event

    (event.subscriptions.map(&:user_email) +
      [event.user.email] -
      [resource.user&.email]
    ).uniq
  end
end
