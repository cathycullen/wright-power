class TeamMember < ActiveRecord::Base
  # Remember to create a migration!
  #add validation

  has_many :attendees

end

def find_by_name(name)
  TeamMember.where(:name => name).first
end