class TimeBookerMailer < ApplicationMailer
  default from: 'CV developer nettisivulta <vladimir.gavrilov@hotmail.com>'

  def appointment(recipient, ical)
    admin = 'vladimir.gavrilov@hotmail.com'
    #attachments['kutsu.ics'] = { content_type: 'application/ics', content: ical, Content-transfer-encoding: "8BIT"}
    #mail(to:  admin, cc: recipient,  subject: "Kutsu keskusteluun", content_type: "multipart/mixed", body: ical, content_type: "text/calendar", Content-transfer-encoding: "8BIT")
    attachments['kutsu.ics'] = { mime_type: 'text/calendar', content: ical }
    mail(to: recipient, cc: admin, subject: "Kutsu keskusteluun")

  end

  def confirmation(recipient, ical)
    admin = 'vladimir.gavrilov@hotmail.com'
    #attachments['kutsu.ics'] = { content_type: 'application/ics', content: ical, Content-transfer-encoding: "8BIT"}
    #mail(to:  admin, cc: recipient,  subject: "Kutsu keskusteluun", content_type: "multipart/mixed", body: ical, content_type: "text/calendar", Content-transfer-encoding: "8BIT")
    attachments['kutsu.ics'] = { mime_type: 'text/calendar', content: ical }
    mail(to: recipient, subject: "Invintation: Kutsu keskusteluun")

  end

end
