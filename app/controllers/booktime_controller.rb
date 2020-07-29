class BooktimeController < ApplicationController


    def index
        cal = Icalendar::Calendar.new
        filename = "Foo at ... foo.name"

        if params[:format] == 'vcs'
          cal.prodid = '-//Microsoft Corporation//Outlook MIMEDIR//EN'
          cal.version = '1.0'
          filename += '.vcs'
        else # ical
          cal.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//EN'
          cal.version = '2.0'
          filename += '.ics'
        end

        cal.event do |e|
          #e.dtstart     = Icalendar::Values::DateTime.new(foo.start_at, tzid: foo.time_zone)
          e.dtstart     = Icalendar::Values::Date.new('20200728')
          #e.dtend       = Icalendar::Values::DateTime.new(foo.end_at, tzid: foo.course.time_zone)
          e.dtend       = Icalendar::Values::Date.new('20200728')
          #e.summary     = foo.summary
          e.summary     = "Meeting with Vladimir"
          #e.description = foo.description
          e.description = "Interview about the open job"
          #e.url         = event_url(foo)
          #e.location    = foo.formatted_address
          e.ip_class = "PRIVATE"
          flash[:notice] = "Nice, it was made"
        end

        #send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
        
        puts 'Before Time Booker Mailer function'
        TimeBookerMailer.appointment("volodya0503@gmail.com", cal.to_ical).deliver_now
        flash[:primary] = "The email was send"
        flash[:notice] = "the end of the create statement"
    end
    
 
    def create
          puts "index was send"
          flash[:notice] = "Nice, it was made"
          redirect_to booktime_path
        cal = Icalendar::Calendar.new
        filename = "Foo at ... foo.name"

        if params[:format] == 'vcs'
          cal.prodid = '-//Microsoft Corporation//Outlook MIMEDIR//EN'
          cal.version = '1.0'
          filename += '.vcs'
        else # ical
          cal.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//EN'
          cal.version = '2.0'
          filename += '.ics'
        end

        cal.event do |e|
          #e.dtstart     = Icalendar::Values::DateTime.new(foo.start_at, tzid: foo.time_zone)
          e.dtstart     = Icalendar::Values::DateTime.new('20050428')
          #e.dtend       = Icalendar::Values::DateTime.new(foo.end_at, tzid: foo.course.time_zone)
          e.dtend       = Icalendar::Values::DateTime.new('20050429')
          #e.summary     = foo.summary
          e.summary     = "Meeting with Vladimir"
          #e.description = foo.description
          e.description = "Interview about the open job"
          #e.url         = event_url(foo)
          #e.location    = foo.formatted_address
          e.ip_class = "PRIVATE"
          flash[:notice] = "Nice, it was made"
        end

        send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
        
        flash[:alert] = params[:title]
        flash[:notice] = "the end of the create statement"
        ApplicationMailer.appointment("vladimir.gavrilov@hotmail.com", "nelli.sukhanova@hotmail.com")
    end
    
end
