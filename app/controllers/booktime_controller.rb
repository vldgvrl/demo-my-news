class BooktimeController < ApplicationController
    def index
    end
 
    def new
        #params[:date, :time, :email, :message]
        cal = Icalendar::Calendar.new
        filename = "kutsu keskusteluun"
          cal.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//EN'
          cal.version = '2.0'
          filename += '.ics'
        @meeting = appointment_params
        date = DateTime.parse(@meeting[:date])
        time = DateTime.parse(@meeting[:time])
        @admin_email = 'vladimir.gavrilov@hotmail.com'
        @email = @meeting[:email]
        event_start = DateTime.new(date.year, date.month, date.day, time.hour, time.min) 
        event_end = event_start + 1.hour
        puts event_start
        puts event_end
        #year, month, day = @meeting.to_s.split(',').map { |n| n.to_i }
        #hour, minute = @meeting.to_s.split(',').map { |n| n.to_i }
        #event_start = DateTime.new(year, month, day, hour, minute)
        #event_end = event_start + 1.hour

        if params[:format] == 'vcs'
          cal.prodid = '-//Microsoft Corporation//Outlook MIMEDIR//EN'
          cal.version = '1.0'
          filename += '.vcs'
        #else # ical
          cal.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//EN'
          cal.version = '2.0'
          filename += '.ics'
        end

        cal.event do |e|
          e.dtstart     = Icalendar::Values::DateTime.new(event_start)
          #e.dtstart     = Icalendar::Values::DateTime.new(foo.start_at, tzid: foo.time_zone)
          #e.dtstart     = Icalendar::Values::Date.new('20200728')
          e.dtend       = Icalendar::Values::DateTime.new(event_end)
          #e.dtend       = Icalendar::Values::DateTime.new(foo.end_at, tzid: foo.course.time_zone)
          #e.dtend       = Icalendar::Values::Date.new('20200728')
          e.summary     = "Keskustelu ohjelmistokehittäjä"
          e.organizer = "mailto:#@email"
          e.organizer = Icalendar::Values::CalAddress.new("mailto:#@email", cn: 'CV Developer invintation Form')
          e.attendee  = "mailto:#@email"
          e.append_attendee "mailto:vladimir.gavrilov@hotmail.com"
          e.description =  @meeting[:message]
          #e.url         = event_url(foo)
          #e.location    = foo.formatted_address
          e.ip_class = "PRIVATE"
        end

        
        cal.publish

        puts 'Send event to organizer'
        TimeBookerMailer.appointment(@email, cal.to_ical).deliver_now

        #send_data cal, type: 'text/calendar', disposition: 'attachment', filename: filename
        
        puts 'Making changes to event (method request)'
        #inv.append_custom_property("METHOD", "REQUEST")
        cal.ip_method = "REQUEST"
        attendee_params = { "CUTYPE"   => "INDIVIDUAL",
                "ROLE"     => "REQ-PARTICIPANT",
                "PARTSTAT" => "NEEDS-ACTION",
                "RSVP"     => "TRUE" }


        attendee_value = Icalendar::Values::Text.new("mailto:#@admin_email", attendee_params)
        cal.append_custom_property("ATTENDEE", attendee_value)    

        puts 'Send confirmation request to me'
        TimeBookerMailer.confirmation(@admin_email, cal.to_ical).deliver_now


        flash[:success] = "Viesti lähetetty onnistuneesti"
        #render 'index'
        redirect_to root_path
    end

    private
        def appointment_params
            params.permit(:date, :time, :email, :message, :commit)
        end
    
end
