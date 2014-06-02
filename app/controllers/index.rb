get '/' do
  @recent_descriptions = Game.get_all_last_descriptions_of_inprogress
  @recent_drawings = Game.get_all_last_drawings_of_inprogress
  erb :index
end

post '/signup' do
  # CREATE NEW USER
  user = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password])
  if user.save  
    session[:user_id] = user.id
    session[:username] = user.username
    redirect '/'
  else
    # Error message should check to see if user exists
    @error = "There was a problem creating a new user. "
    @error += "The username was probably already taken. "
    @error += "More useful error messages in the works."
    erb :error 
  end
end

post '/login' do
  user = User.find_by_username(params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    session[:username] = user.username
    redirect '/'
  else
    @error = "There was a problem logging in. Please try again. "
    @error += "More useful error messages in the works."
    erb :error
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

