class ApplicationMailer < ActionMailer::Base
  default from: 'dev9588504@gmail.com'

  layout 'mailer'

  helper_method :time_locale_to

  private

  def time_locale_to(event)
    if event.datetime.localtime > Time.now
      "#{t('event_mailer.due_datetime')}: #{l(@event.datetime.localtime, format: :short)}"
    else
      "#{t('event_mailer.exp_datetime')}: #{l(@event.datetime.localtime, format: :short)}"
    end
  end
end
