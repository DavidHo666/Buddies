require 'rails_helper'

describe UsersController do
  describe 'GET new' do
    it "can create a new user template" do
      User.new
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET index" do
    it "should get all users" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST create" do
    it "should create a new user" do
      post :create, params: { :user => { :email => "test@gmail.com", password: "testtesttest"} }
      expect(response).to redirect_to(user_path(User.last))
    end

    it "should not create a new user if email is not unique" do
      User.create!(email: "test@gmail.com", password: "testtesttest")
      post :create, params: { :user => { :email => "test@gmail.com", password: "testtesttest"} }
      expect(response).to render_template("new")
    end
  end

  describe "POST update" do
    it "should update a user" do
      curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      sign_in curr_user
      post :update, params: { :id => curr_user.id, :user => { :email => "test@gmail.com", password: "testtesttest"} }
      expect(response).to redirect_to(user_path(curr_user))
    end

    # it "should not update a user if not logged in" do
    #   curr_user = User.create!(email: "test@gmail.com", password: "testtesttest")
    #   post :update, params: { :id => curr_user.id, :user => { :email => "test@gmail.com", password: "testtesttest"} }
    #   expect(response).to redirect_to(new_user_session_path)
    # end
  end

  describe "POST destroy" do
  it "should destroy user" do
    user_test = User.create!(email: "test@gmail.com", password: "testtesttest")
    delete :destroy, params:{ :id => 1 }
    expect(User.find_by(email: user_test.email)).to be nil
  end
end

end
