class TimeBookerMailer < ApplicationMailer
  default from: 'vladimir.gavrilov@hotmail.com'
  def appointment(recipient, ical)
    attachments['kutsu.ics'] = { mimi_type: 'text/calendar', content: ical}
    mail(to: recipient, subject: "Hello, its simple text send")
  end
end
