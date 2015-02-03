configure do
  @team_members = TeamMember.all
  puts "configure called  "
end

helpers do
  @team_members = TeamMember.all
  puts "helpers called  #{@team_members.count}"

   def team_members
    puts "is nil categories? #{@categories.nil?}"
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

  puts "in post /send_invitation_email team members #{@team_members}"
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
    @team_member=params[:team_member]
  else 
    @errors << "Please provide a team member from the dropdown list."
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

  end

  #redirect 
  erb :invitation_sent
end

post '/preview_invitation' do

  puts "in post /send_invitation_email team members #{@team_members}"
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
    @team_member=params[:team_member]
  else 
    @errors << "Please provide a team member from the dropdown list."
  end

  if @errors.size  > 0
    puts "errors #{@errors}"
    erb :show_client_invitation
  else
    erb :preview_invitation, :layout => false
  end

  #redirect 
  erb :preview_invitation
end
