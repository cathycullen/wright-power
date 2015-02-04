configure do
  @team_members = TeamMember.all
end

helpers do
  @team_members = TeamMember.all

   def team_members
    @team_members ||= TeamMember.all
  end
end

get '/' do
  team_members
  puts "team members #{@team_members}"
  @errors = []
    erb :show_client_invitation
end

post '/send_invitation_email' do

  puts " /send_invitation_email team members #{params}"
  @errors = []
  if !params[:name].nil?
    @name=params[:name]
  else 
    @errors << "Please provide a name."
  end
  if !params[:email].nil?
    @email=params[:email]
  else 
    @errors << "Please provide a valid email."
  end
  
  if !params[:text].nil?
    @text=params[:text]
  else 
    @errors << "No text has been entered."
  end
  
  if !params[:team_member].nil?
    member_name=params[:team_member]
    @team_member = TeamMember.find_by_name(member_name)
  else 
    @errors << "Please provide a team member from the dropdown list."
  end

 if @team_member.nil?
    @errors << "Team member name #{@team_member} was not found."
  end

  if @errors.size  > 0
    puts "errors #{@errors}"
    erb :show_client_invitation
  else
    puts "#{@name}, #{@email}, #{@team_member}"
    email = Mailer.send_invitation(
    @name,
    @email,
    @text,
    @team_member
    )
    email.deliver_now

    #create attendee
    attendee = Attendee.new
    attendee.name = @name
    attendee.email = @email
    attendee.team_member_id = @team_member.id
    attendee.attending = false
    attendee.save
  end

  #redirect 
  erb :invitation_sent
end

post '/preview_invitation' do

  team_members
  puts "in post /send_invitation_email params #{params}"
  @errors = []
  if !params[:name].nil?
    @name=params[:name]
  else 
    @errors << "Please provide a name."
  end
  if !params[:email].nil?
    @email=params[:email]
  else 
    @errors << "Please provide a valid email."
  end
  
  if !params[:text].nil?
    @text=params[:text]
  else 
    @errors << "No text has been entered."
  end
  if !params[:closing_text].nil?
    @closing_text=params[:closing_text]
  end
  
  puts "params team_member : #{params[:team_member]}  #{params[:team_member].size}   ??  #{!params[:team_member].nil? or params[:team_member].size == 0 }"

  if !params[:team_member].nil? and params[:team_member].size > 0
    @team_member=params[:team_member]
    @team_member_obj = TeamMember.find_by_name(@team_member)
  else 
    @errors << "Please select a team member from the dropdown list."
  end

  if @errors.size  > 0
    puts "errors #{@errors}"
    erb :show_client_invitation
  else
    erb :preview_invitation, :layout => :plain_layout
  end

  #redirect 
  #erb :preview_invitation, :layout => :plain_layout
end

def map_all(obj)
  obj.all.map { |c| c } 
end

get '/attendee_report'  do
  @team_member_filter = map_all(TeamMember)
  @sum_invitations_sent = Attendee.total_invites
  @sum_attending = Attendee.total_attending
  @team_member_selected = 'All'
  @attending_selected = 'All'
  @attendees = Attendee.all
  erb :attendee_report
end

post '/filter_attendees'  do
  @save_params = params
  @team_member_selected =  @save_params["team_member"].first
  @attending_selected =  @save_params["attending"].first
  puts "attending_selected = #{@attending_selected}"

  if params[:team_member].first == "All"
    @team_member_filter = map_all(TeamMember)
  else 
    @team_member_filter = params[:team_member]
  end

  if params[:attending].first == "All"
    @attending_filter = ["true", "false"]
  else
    @attending_filter = params[:attending]
  end


  puts "team_member_filter:  #{@team_member_filter }"
  puts "attending_filter:  #{@attending_filter }"
  @sum_invitations_sent = Attendee.total_invites
  @sum_attending = Attendee.total_attending
  puts "params:    #{params}"
  #@attendees = Attendee.all
  @attendees = Attendee.filter_attendees(@team_member_filter, @attending_filter)

  erb :attendee_report
end

get '/show_registration' do
  puts "params #{params}"
  @name = params[:name]
  @email = params[:email]
  @team_member = params[:team_member]
    erb :show_registration, :layout => :min_layout
end

post '/submit_registration' do
  puts "params  #{params}"
  erb :thank_you, :layout => :min_layout
  #get attendee and save info
end


