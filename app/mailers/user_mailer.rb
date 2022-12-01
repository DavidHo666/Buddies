class UserMailer < ApplicationMailer
    default from: 'buddies <elysiasworth@gmail.com>'

    def welcome_email
        @user = params[:user]
        @url  = 'localhost:3000'
        mail(to: @user.email, subject: 'Welcome to buddies')
    end

    def full_notification
        @event = params[:event]
        @url = 'localhost:3000'
        
        mail(to: [@event.users.map(&:email), @event.user.email], subject: "Event #{@event.event_name} is full")
    end


end
