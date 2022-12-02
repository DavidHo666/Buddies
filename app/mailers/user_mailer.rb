class UserMailer < ApplicationMailer
    default from: 'Buddies <buddies.join.now@gmail.com>'

    def welcome_email
        @user = params[:user]
        @url  = 'https://buddies4152.herokuapp.com/'
        mail(to: @user.email, subject: 'Welcome to buddies')
    end

    def full_notification
        @event = params[:event]
        @url = 'https://buddies4152.herokuapp.com/'
        
        mail(to: [@event.users.map(&:email), @event.user.email], subject: "Event #{@event.event_name} is full")
    end


end
