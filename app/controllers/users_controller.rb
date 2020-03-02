class UsersController < ApplicationController

  # signup page
  get "/signup" do
    erb :"/users/new.html"
  end

  # creates a new user
  post "/signup" do
    @user = User.create(:username => params[:username], :email => params[:email], :password_digest => params[:password])
    if @user.save
      session[:user_id] = @user.id
    redirect "/login"
    else
      foo
    end
  end

  #logs user in
  get "/login" do
    erb :"/users/login.html"
  end

  #login post request in form to create session
  post "/login" do
    @user = User.find_by(username: params[user:][username:]) #find
    if @user && @user.authenticate(params[user:][password:]) #validates
      session[:user_id] = @user.id #signs in
      redirect to '/users/#{user.id}'
    else
      erb :'/users/error.html'
    end
  end

  post "/logout" do
    #session clear
    redirect '/'
  end

  # displays all listings by user
  get "/users/:id" do
    if is_logged_in?
    @user = User.find_by_id(params[:id])
    erb :"/users/show.html"
  else
    redirect to '/login'
  end



  # # GET: /users
  # get "/users" do
  #   erb :"/users/index.html"
  # end





  # # GET: /users/5/edit
  # get "/users/:id/edit" do
  #   erb :"/users/edit.html"
  # end
  #
  # # PATCH: /users/5
  # patch "/users/:id" do
  #   redirect "/users/:id"
  # end
  #
  # # DELETE: /users/5/delete
  # delete "/users/:id/delete" do
  #   redirect "/users"
  end
end
