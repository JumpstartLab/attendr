class RuntimesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    sql = "SELECT MIN(r.time) as runtime, r.attendee_id, a.ticket_email FROM runtimes r INNER JOIN attendees a ON a.id=r.attendee_id GROUP BY r.attendee_id, a.ticket_email ORDER BY runtime "
    @leaderboard = Runtime.connection.execute(sql).to_a
  end

  def create
    attendee = Attendee.find_by_ticket_email(params[:email_address])
    if attendee
      # TODO: If we ever run a second event, delete the heroku app
      # and recreate it.
      # Also, event is the name of the event, event_id is the id,
      # and we don't have access to the actual event object
      event = Event.find(attendee.event_id)
      Runtime.create(event: event, attendee: attendee, time: params[:runtime])
      render :text => "OK\n", :status => :created
    else
      render :text => "Attendee #{params[:email]} not registered.\n", :status => 418
    end
  end

end
