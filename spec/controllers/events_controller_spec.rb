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
  end
end
