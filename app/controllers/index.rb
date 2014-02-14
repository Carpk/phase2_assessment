get '/' do
  @all_events = Event.all
  erb :index
end

get '/sign_up' do
  erb :sign_up
end

get "/log_out" do
  session.clear
  redirect '/'
end

get '/my_dashboard' do
  @user = User.find_by_id(session[:id])
  erb :events
end

get '/user/:user_id' do
  User.find_by_id(params[:user_id])
end

get '/event/:name' do
  @event = Event.find_by_name(params[:name])
  erb :single_event
end

get "/log_in" do
  erb :log_in
end

get "/delete/:event_id" do
    chopping_block = Event.find_by_id(params[:event_id])
    if session[:id] == chopping_block.user_id
      chopping_block.destroy
    end
    redirect '/my_dashboard'
end

post '/create_event' do
  Event.create(user_id: params[:user_id],
               name: params[:name],
               location: params[:location],
               starts_at: params[:starts_at],
               ends_at: params[:ends_at])
  redirect 'my_dashboard'
end

post '/create_acct' do
  unless User.find_by_email(params[:email])
    if params[:password] == params[:pass_confirm]
      user = User.create(first_name: params[:first_name],
                          last_name: params[:last_name],
                          email: params[:email],
                          birthdate: params[:birthdate],
                          password: params[:password])
      user.save
      session[:id] = user.id
      redirect '/my_dashboard'
    else
      @error = "passwords did not match"
      puts @error
      redirect '/sign_up'
    end
  else
    @error = "email already exists"
    puts @error
    redirect '/sign_up'
  end
end

post '/sign_in' do
  @user = User.find_by_email(params[:email])
  if @user && @user.authenticate(params[:password])
    session[:id] = @user.id
    redirect '/my_dashboard'
  end
  redirect to '/log_in'
end
