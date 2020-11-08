require './config/environment'

#In charge of routing of non models
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'band_man_jam_man'
    register Sinatra::Flash

  end

  get '/' do
    erb :layout
  end

  helpers do

  def logged_in?
    !!current_user
  end

  

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login(username, password)
    user = User.find_by(:username => username)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect to "/users/#{current_user.id}"
     else
      redirect "/login"
     end
   end

   def redirect_if_not_logged_in
     redirect '/' if !logged_in?
   end

 end
end
