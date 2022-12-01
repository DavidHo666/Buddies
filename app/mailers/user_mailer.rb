class UserMailer < ApplicationMailer
    default from: 'buddies <elysiasworth@gmail.com>'

    def welcome_email
        @user = params[:user]
        @url  = 'localhost:3000'
        mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end

    def send_full_notification

    end
    
    def send_email
        mail to: "rikakoovo@gmail.com", subject: "email tests"
    end

end
