require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'welcome_email' do
    it 'should send welcome email' do
      user = User.create!(email: "test@gmail.com", password: "testtesttest")
      email = UserMailer.with(user: user).welcome_email.deliver_now
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(email.to).to eq([user.email])
      expect(email.from).to eq(['buddies.join.now@gmail.com'])
    end
  end
end
