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
    it "should create a new event" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => { :event_name => "TEST CREATE", :tag => "Food&Drink" } }
      expect(response).to redirect_to(events_path)
    end

    it "should not create a new event if not logged in" do
      post :create, params: { :event => { :event_name => "TEST CREATE", :tag => "Food&Drink" } }
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

  describe "edit event" do
    it "should edit the event" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE 1", user: curr_user, tag: "Food&Drink")

      get :edit, params: { :id => event_test1.id }
      after_created = Event.find_by_id(event_test1[:id])
      expect(assigns(:event)).to eq after_created
    end
  end

  describe "update Event" do
    it "should update the event" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE 1", user: curr_user, tag: "Food&Drink")
      sign_in curr_user
      put :update, params: { :id => 1, :event => { :event_name => "TEST CREATE 1", :tag => "Food&Drink" } }
      expect(flash[:notice]).to eq("Event TEST CREATE 1 was successfully updated.")
    end

    it "should not update the event if not logged in" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE 1", user: curr_user, tag: "Food&Drink")
      put :update, params: { :id => 1, :event => { :event_name => "TEST CREATE 1", :tag => "Food&Drink" } }
      expect(flash[:warning]).to eq("Event TEST CREATE 1 couldn't be edited by you.")
    end
  end

  describe "destroy Event" do
    it "should destroy the event" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE 1", user: curr_user, tag: "Food&Drink")
      sign_in curr_user
      delete :destroy, params:{ :id => 1 }
      expect(Event.find_by(event_name: event_test1.event_name)).to be nil
    end

    it "should not destroy the event if not logged in" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      event_test1 = Event.create!(event_name: "TEST CREATE 1", user: curr_user, tag: "Food&Drink")
      delete :destroy, params:{ :id => 1 }
      expect(flash[:warning]).to eq("Event TEST CREATE 1 couldn't be deleted by you.")
    end
  end
end