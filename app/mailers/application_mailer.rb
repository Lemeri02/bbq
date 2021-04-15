class ApplicationMailer < ActionMailer::Base
  default from: 'hi@bbqking.space'

  layout 'mailer'

  helper_method :due_time_to

  private

  def due_time_to(event)
    if event.datetime > Time.now
      "#{t('event_mailer.due_datetime')}: #{l(@event.datetime, format: :short)}"
    else
      "#{t('event_mailer.exp_datetime')}: #{l(@event.datetime, format: :short)}"
    end
  end
end
