class RuntimesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    attendee = Attendee.find_by_ticket_email(params[:email])
    if attendee
      # I don't see how we can have only one event per attendee, but
      # I'm just going to roll with it for now.
      # Also, event is the name of the event, event_id is the id,
      # and we don't have access to the actual event object
      event = Event.find(attendee.event_id)
      Runtime.create(event: event, attendee: attendee, time: params[:time])
      render :text => "OK\n", :status => :created
    else
      render :text => "Attendee #{params[:email]} not registered.\n", :status => 500
    end
  end

end
