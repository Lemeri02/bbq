class SubscribersNotificationJob < ApplicationJob
  include EmailFilter

  queue_as :default

  def perform(*args)
    @resource = args.first

    email_list = EmailFilter.email_list(@resource)

    case
    when @resource.is_a?(Comment)
      email_list.each do |mail|
        EventMailer.comment(@resource, mail).deliver_later
      end
    when @resource.is_a?(Photo)
      email_list.each do |mail|
        EventMailer.photo(@resource, mail).deliver_later
      end
    when @resource.is_a?(Subscription) && email_list
      EventMailer.subscription(@resource).deliver_later
    end
  end
end
