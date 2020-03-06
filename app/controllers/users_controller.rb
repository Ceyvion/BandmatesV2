class UsersController < ApplicationController

  # signup page
  get "/signup" do
    if !logged_in?
      erb :"/users/new.html", layout: false
    else
      redirect to "/users/#{current_user.id}"
    end
  end

  # creates a new user
  post "/signup" do
    # if params[:username] == "" || params[:email] == "" || params[:password] == ""
    #   redirect to '/signup'
    # else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
       if @user.save
         session[:user_id] = @user.id
         redirect "/users/#{current_user.id}"
       else
         flash[:message] = @user.errors.full_messages.to_sentence #use on redirects
         redirect to '/signup'
       end
     # end
   end

  #logs user in
  get "/login" do
    erb :"/users/login.html", layout: false
  end

  #login post request in form to create session
  post "/login" do
    if params.values.any? &:empty?
      redirect to '/login'
    elsif
      @user = User.find_by(username: params[:username]) #find
      @user && @user.authenticate(password: params[:password]) #validates
        session[:user_id] = @user.id #signs in
        redirect to "/users/#{current_user.id}"
    else
      erb :"/users/error.html", layout: false
    end
  end

  post "/logout" do
    session.clear
    redirect '/'
  end

  # displays all listings by user
  get "/users/:id" do
    if logged_in?
     @listings = current_user.listings
     erb :"/users/home.html", layout: false
    else
      redirect to '/login'
    end
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
  # end
end
