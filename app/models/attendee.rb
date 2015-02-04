class Attendee < ActiveRecord::Base
  # Remember to create a migration!
  #add validation

  belongs_to :team_member


  def find_by_name(name)
    Attendee.where(:name => name).first
  end
  def find_by_email(email)
    Attendee.where(:email => email).first
  end

  def self.filter_attendees(team_member_id, attending_filter)
        Attendee.where(team_member_id: team_member_id, attending: attending_filter)
  end

  def self.total_attending()
    Attendee.where(attending: true).count
  end

  def self.total_invites()
    Attendee.count
  end

end