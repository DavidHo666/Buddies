# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

    # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_email
    def welcome_email
      user = User.first
      UserMailer.with(user: user).welcome_email
    end

    def full_notification
        event = Event.first
        UserMailer.with(event: event).full_notification
    end
  end
