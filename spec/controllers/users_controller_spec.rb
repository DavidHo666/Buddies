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
    it "can create a user" do
      before_create = User.find_by(email: "test@gmail.com")
      expect(before_create).to be nil

      user_test = User.create!(email: "test@gmail.com", password: "testtesttest")
      after_create = User.find_by(email: "test@gmail.com")
      expect(after_create).should_not be nil
    end
  end

  describe "POST update" do
    it 'should update user' do
      test_user = User.create!(email: "test@gmail.com", password: "testtesttest")
      updated_params = { id: 1, email: "test@gmail.com", password: "testtesttest", bio: "NEW BIO"}

      updated_user = User.update!(updated_params)[0]
      expect(updated_user.bio).to eq("NEW BIO")
    end
  end

  describe "POST destroy" do
  it "should destroy user" do
    user_test = User.create!(email: "test@gmail.com", password: "testtesttest")
    delete :destroy, params:{ :id => 1 }
    expect(User.find_by(email: user_test.email)).to be nil
  end
end

end
