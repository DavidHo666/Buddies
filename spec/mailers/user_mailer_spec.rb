require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'full_notification' do
    it 'should send welcome email' do
      user_organizer = User.create!(email: "test@gmail.com", password: "testtesttest")
      user_participant = User.create!(email: "test2@gmail.com", password: "testtest")
      event = Event.new(event_name: "test", occupied_spots:1, available_spots:1, percentage:0.5)
      event.user = user_organizer
      event.users << user_participant
      event.save!
      email = UserMailer.with(event: event).full_notification.deliver_now
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(email.to).to eq([user_participant.email, user_organizer.email])
      expect(email.from).to eq(['buddies.join.now@gmail.com'])
    end
  end
end
