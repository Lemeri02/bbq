class SubscribersNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @resource = args.first

    if @resource.instance_of?(Comment)
      comment = @resource
      event = args.first.event

      all_emails = (
        event.subscriptions.map(&:user_email) +
        [event.user.email] -
        [comment.user&.email]
      ).uniq

      all_emails.each do |mail|
        EventMailer.comment(event, comment, mail).deliver_later
      end
    end

    if @resource.instance_of?(Photo)
      photo = @resource
      event = args.first.event

      all_emails = (
        event.subscriptions.map(&:user_email) +
        [event.user.email] -
        [photo.user.email]
      ).uniq

      all_emails.each do |mail|
        EventMailer.photo(event, photo, mail).deliver_later
      end
    end

    if @resource.instance_of?(Subscription)
      new_subscription = @resource
      event = args.first.event

      EventMailer.subscription(event, new_subscription).deliver_later
    end
  end
end
