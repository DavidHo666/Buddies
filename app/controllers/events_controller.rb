class EventsController < ApplicationController
  include EventsHelper
  # before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @all_tags = Event.all_tags

    if params[:commit] == "Refresh"
      reset_session
    end

    @tags_to_show = session[:tags_to_show] || @all_tags

    if (!params[:tags] && !params[:sort]) && (session[:sort_key] || session[:tags_to_show])
      redirect_to events_path(:sort => session[:sort_key],
                              :tags => Hash[@tags_to_show.map {|x| [x, 1]}])
    end

    if params[:tags]
      @tags_to_show = params[:tags].keys
    else
      @tags_to_show = Event.all_tags
    end
    session[:tags_to_show] = @tags_to_show

    @sort_key = params[:sort] || ''

    session[:sort_key] = @sort_key

    @events = Event.with_tags_sort(@tags_to_show, @sort_key)

  end

  # GET /events/1 or /events/1.json
  def show
    id = params[:id]
    @event = Event.find(id)
    @organizer = @event.user
    @participants = @event.users
  end

  # GET /events/new
  def new
    # @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  # POST /events or /events.json
  def create
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      start_time = Time.new *flatten_date_array(params[:event],"start")
      end_time = Time.new *flatten_date_array(params[:event], "end")
      if (end_time < start_time or end_time < Time.now)
        flash[:warning] = "Time invalid!"
        redirect_to events_path
      elsif Integer(params[:event][:available_spots]) < 1
        flash[:warning] = 'At least one available spot.'
        redirect_to events_path
      elsif Integer(params[:event][:occupied_spots]) < 1
        flash[:warning] = 'At least one spot is occupied(by you).'
        redirect_to events_path
      else
        @event = Event.new(event_params)
        @event.user = current_user
        @event.save!
        flash[:notice] = "#{@event.event_name} was successfully created."
        redirect_to events_path
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    @event = Event.find(params[:id])
    if @event.user == current_user
      start_time = Time.new *flatten_date_array(params[:event],"start")
      end_time = Time.new *flatten_date_array(params[:event], "end")
      if end_time < start_time
        flash[:warning] = "Time invalid!"
        redirect_to event_path() and return
      end
      @event.update(event_params)
      flash[:notice] = "Event #{@event.event_name} was successfully updated."
    else
      flash[:warning] = "Event #{@event.event_name} couldn't be edited by you."
    end
    redirect_to event_path()
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event.destroy
      flash[:notice] = "Event #{@event.event_name} was successfully deleted."
    else
      flash[:warning] = "Event #{@event.event_name} couldn't be deleted by you."
    end
    redirect_to events_path
  end

  def add_participation
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @event = Event.find(params[:id])
      if @event.user == current_user
        flash[:warning] = "You can't participate in your own event."
      elsif !@event.users.include?(current_user)
        # if @event.occupied_spots.nil?
        #   @event.occupied_spots = 1
        # end
        if @event.available_spots == 0 # @event.users.length >= @event.available_spots
          flash[:warning] = "Event #{@event.event_name} is full."
        else
          @event.users << current_user
          @event.available_spots = @event.available_spots - 1
          @event.occupied_spots = @event.occupied_spots + 1
          @event.save!
          flash[:notice] = "You have successfully joined event #{@event.event_name}."
          if @event.available_spots == 0
            UserMailer.with(event: @event).full_notification.deliver_now # send email when the event is full
          end
        end
      else
        flash[:warning] = "You have already joined event #{@event.event_name}."
      end
      redirect_to events_path
    end
  end

  def remove_participation
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @event = Event.find(params[:id])
      if @event.users.include?(current_user)
        @event.users.delete(current_user)
        @event.available_spots = @event.available_spots + 1
        @event.occupied_spots = @event.occupied_spots - 1
        @event.save!
        flash[:notice] = "You have successfully left event #{@event.event_name}."
      elsif @event.user == current_user
        flash[:warning] = "Can not leave the event created by you."
      else
        flash[:warning] = "You haven't joined event #{@event.event_name}."
      end
      redirect_to events_path
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_event
    #   @event = Event.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:event_name,:tag,:address,:description, :start_time, :end_time,
                                    :price, :available_spots, :occupied_spots, :price)
    end
end
