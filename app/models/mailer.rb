require 'action_mailer'
require 'date'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.view_paths= File.dirname(__FILE__)

  class Mailer < ActionMailer::Base
  
    def send_invitation(name, email, text, team_member, closing_text)
      puts "mailer.send_invitation called #{name}, #{email}, #{team_member}"
      @name = name
      @email =  email
      @text = text
      @team_member = team_member
      @closing_text = closing_text
    
    puts "#{ENV['EMAIL_ADDRESS'] }"
    puts "#{ENV['EMAIL_PORT'] }"
    puts "#{ENV['EMAIL_DOMAIN'] }"
    puts "#{ENV['EMAIL_USER'] }"
    puts "#{ENV['EMAIL_PASS'] }"
    puts "From:  #{ENV['EMAIL_FROM_ADDRESS'] }"

      ActionMailer::Base.smtp_settings = {
        :address   => ENV['EMAIL_ADDRESS'],
        :port      => ENV['EMAIL_PORT'],
        :domain    => ENV['EMAIL_DOMAIN'],
        :authentication => :"login",
        :user_name      => ENV['EMAIL_USER'],
        :password       => ENV['EMAIL_PASS'],
        :enable_starttls_auto => true,
      }
      
      puts "sending invitation to:  #{@email} from: #{ENV['EMAIL_FROM_ADDRESS']}"
      mail( 
        :to      =>  @email,
        :from    => ENV['EMAIL_FROM_ADDRESS'],
        :subject => "Leadership and Power Blockers With Dr Bob Wright",
      ) do |format|
        format.html
        format.text
      end
    end
  end