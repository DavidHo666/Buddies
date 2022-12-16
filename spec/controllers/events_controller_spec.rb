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

    # it "should only show events from selected tags" do
    #   curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
    #   sign_in curr_user

    #   post :create, params: { :event => {
    #     :event_name => "TEST CREATE 1",
    #     :tag => "Food&Drink",
    #     "start_time(1i)" => "2023",
    #     "start_time(2i)" => "1",
    #     "start_time(3i)" => "1",
    #     "start_time(4i)" => "12",
    #     "start_time(5i)" => "30",
    #     "end_time(1i)" => "2023",
    #     "end_time(2i)" => "2",
    #     "end_time(3i)" => "1",
    #     "end_time(4i)" => "12",
    #     "end_time(5i)" => "30",
    #     :available_spots => 5,
    #     :occupied_spots => 2
    #   } }

    #   post :create, params: { :event => {
    #     :event_name => "TEST CREATE 2",
    #     :tag => "Music",
    #     "start_time(1i)" => "2023",
    #     "start_time(2i)" => "1",
    #     "start_time(3i)" => "1",
    #     "start_time(4i)" => "12",
    #     "start_time(5i)" => "30",
    #     "end_time(1i)" => "2023",
    #     "end_time(2i)" => "2",
    #     "end_time(3i)" => "1",
    #     "end_time(4i)" => "12",
    #     "end_time(5i)" => "30",
    #     :available_spots => 5,
    #     :occupied_spots => 2
    #   } }

    #   get :index, params:{ :tags => {"Music" => 1} }
    #   selected_events = assigns(:events)[0]
    #   expect(selected_events.event_name).to eq("TEST CREATE 2")
    # end

    # it "should show events in selected sort key" do
    #   curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
    #   sign_in curr_user

    #   post :create, params: { :event => {
    #     :event_name => "B TEST CREATE 1",
    #     :tag => "Food&Drink",
    #     "start_time(1i)" => "2023",
    #     "start_time(2i)" => "1",
    #     "start_time(3i)" => "1",
    #     "start_time(4i)" => "12",
    #     "start_time(5i)" => "30",
    #     "end_time(1i)" => "2023",
    #     "end_time(2i)" => "2",
    #     "end_time(3i)" => "1",
    #     "end_time(4i)" => "12",
    #     "end_time(5i)" => "30",
    #     :available_spots => 5,
    #     :occupied_spots => 2
    #   } }

    #   post :create, params: { :event => {
    #     :event_name => "B TEST CREATE 1",
    #     :tag => "Music",
    #     "start_time(1i)" => "2023",
    #     "start_time(2i)" => "1",
    #     "start_time(3i)" => "1",
    #     "start_time(4i)" => "12",
    #     "start_time(5i)" => "30",
    #     "end_time(1i)" => "2023",
    #     "end_time(2i)" => "2",
    #     "end_time(3i)" => "1",
    #     "end_time(4i)" => "12",
    #     "end_time(5i)" => "30",
    #     :available_spots => 5,
    #     :occupied_spots => 2
    #   } }


    #   get :index, params:{ :sort => "event_name" }
    #   selected_events = assigns(:events)[0]
    #   expect(selected_events.event_name).to eq("B TEST CREATE 1")
    # end

      it 'should return event if search name is not null' do
        curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
        sign_in curr_user
        post :create, params: { :event => {
          :event_name => "test",
          :tag => "Food&Drink",
          "start_time(1i)" => "2023",
          "start_time(2i)" => "1",
          "start_time(3i)" => "1",
          "start_time(4i)" => "12",
          "start_time(5i)" => "30",
          "end_time(1i)" => "2023",
          "end_time(2i)" => "2",
          "end_time(3i)" => "1",
          "end_time(4i)" => "12",
          "end_time(5i)" => "30",
          :available_spots => 5,
          :occupied_spots => 2
        } }
        get :index, params:{ :search_by_name => 'test' }
        expect(flash[:none]).to eq(nil)
        expect(Event.search_events("test").length).to eq(1)
      end

      it 'should return event if search name is null' do
        get :index, params:{ :search_by_name => nil }
        expect(flash[:warning]).to eq('Cannot search empty term')
        # expect(Event.search_events("test").length).to eq(1)
      end

      it 'should show warning if search by time is invalid' do
        get :index, params:{ :search_by_time => nil }
        expect(flash[:warning]).to eq('Time cannot be empty')
      end

      it 'should show warning if search by time is in wrong format' do
        get :index, params:{ :search_by_time => '123' }
        expect(flash[:warning]).to eq('Invalid date format')
      end

      it 'should return result if search time is valid' do
        curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
        sign_in curr_user
        post :create, params: { :event => {
          :event_name => "test",
          :tag => "Food&Drink",
          "start_time(1i)" => "2023",
          "start_time(2i)" => "1",
          "start_time(3i)" => "1",
          "start_time(4i)" => "12",
          "start_time(5i)" => "30",
          "end_time(1i)" => "2023",
          "end_time(2i)" => "2",
          "end_time(3i)" => "1",
          "end_time(4i)" => "12",
          "end_time(5i)" => "30",
          :available_spots => 5,
          :occupied_spots => 2
        } }
        get :index, params:{ :search_by_time => '2023-01-05' }
        expect(flash[:none]).to eq(nil)
        expect(Event.search_time('2023-01-05').length).to eq(1)
      end

  end

  describe "POST create" do
    it "should create a new event" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 2
      } }
      expect(flash[:notice]).to eq("TEST CREATE was successfully created.")
      expect(response).to redirect_to(events_path)
    end

    it "should not create a new event if not logged in" do
      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2021",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 2
      } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should not create a new event if End Time already passed" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2021",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 2
      } }
      expect(flash[:warning]).to eq("Time invalid!")
      expect(response).to redirect_to(events_path)
    end

    it "should not create a new event if Start Time is after End Time" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "2",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "1",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 2
      } }
      expect(flash[:warning]).to eq("Time invalid!")
      expect(response).to redirect_to(events_path)
    end

    it "should not create a new event if Available Spot is less than 1" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 0,
        :occupied_spots => 2
      } }
      expect(flash[:warning]).to eq("At least one available spot.")
      expect(response).to redirect_to(events_path)
    end

    it "should not create a new event if Occupied Spot is less than 1" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 0
      } }
      expect(flash[:warning]).to eq("At least one spot is occupied(by you).")
      expect(response).to redirect_to(events_path)
    end
  end

  describe "GET show" do
    it "should return the event with matched id" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE 1",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }

      post :create, params: { :event => {
        :event_name => "TEST CREATE 2",
        :tag => "Music",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }

      get :show, params:{ :id => 2}
      selected_event = assigns(:event)
      expect(selected_event.event_name).to eq("TEST CREATE 2")

      get :show, params:{ :id => 1}
      selected_event = assigns(:event)
      expect(selected_event.event_name).to eq("TEST CREATE 1")
    end
  end

  describe "edit event" do
    it "should edit the event" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      sign_in curr_user

      post :create, params: { :event => {
        :event_name => "TEST CREATE 1",
        :tag => "Music",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }

      get :edit, params: { :id => 1 }
      after_created = Event.find_by_id(1)
      expect(assigns(:event)).to eq after_created
    end
  end

  describe "update Event" do
    it "should update the event" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE 1",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }

      put :update, params: { :id => 1,
                             :event => {
                               :event_name => "TEST CREATE 2",
                               :tag => "Food&Drink",
                               "start_time(1i)" => "2023",
                               "start_time(2i)" => "1",
                               "start_time(3i)" => "1",
                               "start_time(4i)" => "12",
                               "start_time(5i)" => "30",
                               "end_time(1i)" => "2023",
                               "end_time(2i)" => "2",
                               "end_time(3i)" => "1",
                               "end_time(4i)" => "12",
                               "end_time(5i)" => "30",
                               :available_spots => 5,
                               :occupied_spots => 1
                             } }
      expect(flash[:notice]).to eq("Event TEST CREATE 2 was successfully updated.")
    end

    it "should not update the event if not logged in" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE 1",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }
      sign_out curr_user

      put :update, params: { :id => 1,
                             :event => {
                               :event_name => "TEST CREATE 2",
                               :tag => "Food&Drink",
                               "start_time(1i)" => "2023",
                               "start_time(2i)" => "1",
                               "start_time(3i)" => "1",
                               "start_time(4i)" => "12",
                               "start_time(5i)" => "30",
                               "end_time(1i)" => "2023",
                               "end_time(2i)" => "2",
                               "end_time(3i)" => "1",
                               "end_time(4i)" => "12",
                               "end_time(5i)" => "30",
                               :available_spots => 5,
                               :occupied_spots => 1
                             } }
      expect(flash[:warning]).to eq("Event TEST CREATE 1 couldn't be edited by you.")
    end

    it "should not update event if End Time before Start Time" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE 1",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }

      put :update, params: { :id => 1,
                             :event => {
                               :event_name => "TEST CREATE 2",
                               :tag => "Food&Drink",
                               "start_time(1i)" => "2023",
                               "start_time(2i)" => "2",
                               "start_time(3i)" => "1",
                               "start_time(4i)" => "12",
                               "start_time(5i)" => "30",
                               "end_time(1i)" => "2023",
                               "end_time(2i)" => "1",
                               "end_time(3i)" => "1",
                               "end_time(4i)" => "12",
                               "end_time(5i)" => "30",
                               :available_spots => 5,
                               :occupied_spots => 1
                             } }
      expect(flash[:warning]).to eq("Time invalid!")
      expect(response).to redirect_to(event_path)
    end

  end

  describe "destroy Event" do
    it "should destroy the event" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE 1",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }

      delete :destroy, params:{ :id => 1 }
      expect(Event.find_by(event_name: "TEST CREATE 1")).to be nil
    end

    it "should not destroy the event if not logged in" do
      curr_user = User.create!(email: "test1@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :create, params: { :event => {
        :event_name => "TEST CREATE 1",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }
      sign_out curr_user

      delete :destroy, params:{ :id => 1 }
      expect(flash[:warning]).to eq("Event TEST CREATE 1 couldn't be deleted by you.")
    end
  end

  describe "add_participation" do
    it "should let user to participate in an event" do
      organizer_user = User.create!(email: "organizer@gmail.com", password: "testtesttest")
      sign_in organizer_user

      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }
      sign_out organizer_user

      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      sign_in curr_user

      put :add_participation, params: { :id => 1 }
      expect(flash[:notice]).to eq("You have successfully joined event TEST CREATE.")
      expect(response).to redirect_to(events_path)
    end

    it "should not let user to participate if not log in" do
      put :add_participation, params: { :id => 1 }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should not let user join their own event" do
      organizer_user = User.create!(email: "organizer@gmail.com", password: "testtesttest")
      sign_in organizer_user

      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 5,
        :occupied_spots => 1
      } }

      put :add_participation, params: { :id => 1 }
      expect(flash[:warning]).to eq("You can't participate in your own event.")
    end

    it "should not participant if event is full" do
      organizer_user = User.create!(email: "organizer@gmail.com", password: "testtesttest")
      sign_in organizer_user

      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 1,
        :occupied_spots => 1
      } }
      sign_out organizer_user

      curr_user_1 = User.create!(email: "test1@gmail.com", password: "testtesttest")
      sign_in curr_user_1
      put :add_participation, params: { :id => 1 }
      sign_out curr_user_1

      curr_user_2 = User.create!(email: "test2@gmail.com", password: "testtesttest")
      sign_in curr_user_2
      put :add_participation, params: { :id => 1 }

      expect(flash[:warning]).to eq("Event TEST CREATE is full.")
      expect(response).to redirect_to(events_path)
    end

    it "should not join event if already joined" do
      organizer_user = User.create!(email: "organizer@gmail.com", password: "testtesttest")
      sign_in organizer_user

      post :create, params: { :event => {
        :event_name => "TEST CREATE",
        :tag => "Food&Drink",
        "start_time(1i)" => "2023",
        "start_time(2i)" => "1",
        "start_time(3i)" => "1",
        "start_time(4i)" => "12",
        "start_time(5i)" => "30",
        "end_time(1i)" => "2023",
        "end_time(2i)" => "2",
        "end_time(3i)" => "1",
        "end_time(4i)" => "12",
        "end_time(5i)" => "30",
        :available_spots => 1,
        :occupied_spots => 1
      } }
      sign_out organizer_user

      curr_user_1 = User.create!(email: "test1@gmail.com", password: "testtesttest")
      sign_in curr_user_1
      put :add_participation, params: { :id => 1 }
      put :add_participation, params: { :id => 1 }
      expect(flash[:warning]).to eq("You have already joined event TEST CREATE.")
    end

    describe "remove_participation" do
      it "should remove user from participants of an event" do
        organizer_user = User.create!(email: "organizer@gmail.com", password: "testtesttest")
        sign_in organizer_user

        post :create, params: { :event => {
          :event_name => "TEST CREATE",
          :tag => "Food&Drink",
          "start_time(1i)" => "2023",
          "start_time(2i)" => "1",
          "start_time(3i)" => "1",
          "start_time(4i)" => "12",
          "start_time(5i)" => "30",
          "end_time(1i)" => "2023",
          "end_time(2i)" => "2",
          "end_time(3i)" => "1",
          "end_time(4i)" => "12",
          "end_time(5i)" => "30",
          :available_spots => 1,
          :occupied_spots => 1
        } }
        sign_out organizer_user

        curr_user_1 = User.create!(email: "test1@gmail.com", password: "testtesttest")
        sign_in curr_user_1
        put :add_participation, params: { :id => 1 }
        put :remove_participation, params: { :id => 1 }
        expect(flash[:notice]).to eq("You have successfully left event TEST CREATE.")
        expect(response).to redirect_to(events_path)
      end

      it "should not remove user from participants if user not logged in" do
        put :remove_participation, params: { :id => 1 }
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not remove user from participants if user did not join this event" do
        organizer_user = User.create!(email: "organizer@gmail.com", password: "testtesttest")
        sign_in organizer_user

        post :create, params: { :event => {
          :event_name => "TEST CREATE",
          :tag => "Food&Drink",
          "start_time(1i)" => "2023",
          "start_time(2i)" => "1",
          "start_time(3i)" => "1",
          "start_time(4i)" => "12",
          "start_time(5i)" => "30",
          "end_time(1i)" => "2023",
          "end_time(2i)" => "2",
          "end_time(3i)" => "1",
          "end_time(4i)" => "12",
          "end_time(5i)" => "30",
          :available_spots => 1,
          :occupied_spots => 1
        } }
        sign_out organizer_user

        curr_user_1 = User.create!(email: "test1@gmail.com", password: "testtesttest")
        sign_in curr_user_1
        put :remove_participation, params: { :id => 1 }
        expect(flash[:warning]).to eq("You haven't joined event TEST CREATE.")
        expect(response).to redirect_to(events_path)
      end

      it "should not let organizer leave their own events" do
        organizer_user = User.create!(email: "organizer@gmail.com", password: "testtesttest")
        sign_in organizer_user

        post :create, params: { :event => {
          :event_name => "TEST CREATE",
          :tag => "Food&Drink",
          "start_time(1i)" => "2023",
          "start_time(2i)" => "1",
          "start_time(3i)" => "1",
          "start_time(4i)" => "12",
          "start_time(5i)" => "30",
          "end_time(1i)" => "2023",
          "end_time(2i)" => "2",
          "end_time(3i)" => "1",
          "end_time(4i)" => "12",
          "end_time(5i)" => "30",
          :available_spots => 1,
          :occupied_spots => 1
        } }

        put :remove_participation, params: { :id => 1 }
        expect(flash[:warning]).to eq("Can not leave the event created by you.")
        expect(response).to redirect_to(events_path)
      end
    end
  end
end