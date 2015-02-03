class Attendee < ActiveRecord::Base
  # Remember to create a migration!
  #add validation

  belongs_to :team_member
end

def find_by_name(name)
  Attendee.where(:name => name).first
end
def find_by_email(email)
  Attendee.where(:email => email).first
end
