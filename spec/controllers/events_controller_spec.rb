require 'rails_helper'

RSpec.describe EventsController do
  describe "GET new" do
    it "can create a new event template" do
      Event.new
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET index" do
    it "should show home page with all events" do
      get :index
      expect(response).to render_template("index")
    end

    it "should only show events from selected tags" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE 1", user: curr_user, tag: "Food&Drink")
      event_test2 = Event.create!(event_name: "TEST CREATE 2", user: curr_user, tag: "Music")

      get :index, params:{ :tags => {"Music" => 1} }
      selected_events = assigns(:events)[0]
      # res = selected_events.find_by(event_name: "TEST CREATE 2").event_name
      expect(selected_events.event_name).to eq(event_test2.event_name)
    end

    it "should show events in selected sort key" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "B TEST CREATE 1", user: curr_user, tag: "Food&Drink")
      event_test2 = Event.create!(event_name: "A TEST CREATE 2", user: curr_user, tag: "Music")

      get :index, params:{ :sort => "event_name" }
      selected_events = assigns(:events)[0]
      # res = selected_events.find_by(event_name: "TEST CREATE 2").event_name
      expect(selected_events.event_name).to eq(event_test2.event_name)
    end
  end

  describe "POST create" do
    it "can create an event if created user" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      before_create = Event.find_by(event_name: "TEST CREATE")
      expect(before_create).to be nil

      event_test = Event.create!(event_name: "TEST CREATE", user: curr_user)
      after_create = Event.find_by(event_name: "TEST CREATE")
      expect(after_create).should_not be nil
    end

    it "should not create event when not log in" do
      allow_any_instance_of(Devise::Controllers::Helpers).to receive(:user_signed_in?).and_return(false)
      get :create
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET show" do
    it "should return the event with matched id" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE 1", user: curr_user, tag: "Food&Drink")
      event_test2 = Event.create!(event_name: "TEST CREATE 2", user: curr_user, tag: "Music")

      get :show, params:{ :id => 2}
      selected_event = assigns(:event)
      expect(selected_event.event_name).to eq(event_test2.event_name)

      get :show, params:{ :id => 1}
      selected_event = assigns(:event)
      expect(selected_event.event_name).to eq(event_test1.event_name)
    end
  end

  describe "update Event" do
    it "should not be able to edit event if not the organizer" do
      post_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE", user: post_user)

      curr_user = User.create!(email: "test2@gmail.com", password: "testtesttest")
      get :update, params:{ :id => 1 }
      event = assigns(:event)
      expect(flash[:warning]).to match("Event #{event.event_name} couldn't be edited by you.")
    end

    it "should edit event if current user is the event organizer" do
      post_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE", user: post_user)
      updated_params = { id: 1, event_name: "TEST CREATE NEW", user: post_user }

      updated_event = Event.update!(updated_params)[0]
      expect(updated_event.event_name).to eq("TEST CREATE NEW")
    end
  end

  describe "destroy Event" do
    it "should not be able to destroy event if not the organizer" do
      post_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE", user: post_user)

      curr_user = User.create!(email: "test2@gmail.com", password: "testtesttest")
      get :destroy, params:{ :id => 1 }
      event = assigns(:event)
      expect(flash[:warning]).to match("Event #{event.event_name} couldn't be deleted by you.")
    end

    it "should destroy event if current user is the event organizer" do
      post_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      event_test = Event.create!(event_name: "TEST CREATE", user: post_user)

      Event.destroy(event_test.id)
      expect(Event.find_by(id: event_test.id)).to be nil
    end
  end

end
