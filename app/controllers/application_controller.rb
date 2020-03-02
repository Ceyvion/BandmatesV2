require './config/environment'

#In charge of routing of non models
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'band_man_jam_man'
  end

  get '/' do
    erb :welcome
  end

  helpers do
  def is_logged_in?
    !!current_user
  end

  def current_user
    current_user = User.find_by(id: session[:user_id])
  end
  end 

end
