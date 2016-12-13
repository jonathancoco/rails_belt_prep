class EventsController < ApplicationController
  before_action :require_login

  def index
    @all_events_in_state = Event.where(state:current_user.state)
    @all_events_out_state = Event.where.not(state:current_user.state)
    #@event = Event.new

    if flash[:name] == nil
      flash[:name] = ""
      flash[:date] = Date.parse(Time.now.to_s)
      flash[:location] = ""
      flash[:state] = "TX"
    end
  end

  def create
    event  = Event.new(event_params)
    event.user = current_user

    if event.save()
      redirect_to events_path
    else
      flash[:errors] = event.errors.full_messages

      flash[:name] = event_params[:name]
      flash[:date] = Date.parse(event_params[:event_date])
      flash[:location] = event_params[:location]
      flash[:state] = event_params[:state]

      redirect_to events_path
    end
  end

  def new
  end

  def edit
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy()

    redirect_to events_path

  end

  private
  def event_params
    params.require(:event).permit(:name, :event_date, :location, :state)
  end

end
