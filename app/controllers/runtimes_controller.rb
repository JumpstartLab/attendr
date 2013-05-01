class RuntimesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    attendee = Attendee.find_by_ticket_email(params[:email])
    if attendee
      # I don't see how we can have only one event per attendee, but
      # I'm just going to roll with it for now.
      Runtime.create(event: attendee.event, attendee: attendee, time: params[:time])
      render :text => "OK\n", :status => :created
    else
      render :text => "Attendee #{params[:email]} not registered.\n", :status => 500
    end
  end

end
