class ListingsController < ApplicationController
require 'pry'
  # show all the listings
  get "/listings" do
    if logged_in?
      current_user
      @not_my_listings = Listing.all - current_user.listings
    erb :"/listings/all_listings.html", layout: false
  else
    redirect to '/login'
  end
end
  # shows the 'new listing' form
  get "/listings/new" do
    if logged_in?
      @listings = current_user.id
    erb :"/listings/new.html", layout: false
  else
    redirect to '/login'
  end
end

  # POST: /listings
  post "/listings/new" do #only place for symbols
    if logged_in?
     if params[:title] == "" || params[:location] == "" || params[:description] == "" || params[:vibe] == "" || params[:skill] == ""
       redirect to '/listings/new'
     else
      @listings = Listing.new(:title => params[:title], :location => params[:location], :description => params[:description], :vibe => params[:vibe], :skill => params[:skill], :user_id => current_user.id)
      if @listings.save
        redirect to "/users/#{current_user.id}"
      else
        redirect to '/listings/new'
      end
    end
    redirect to '/login'
  end
end


  # shows listings that belong to user
  get "/listings/:id" do
    @listings = current_user.listings
    erb :"/listings/show.html", layout: false
  end


  # allows user to edit THEIR listings
  get "/listings/:id/edit" do
    if logged_in?
      @listing = Listing.find_by_id(params[:id])
      if current_user == @listing.user
        erb :"/listings/edit.html", layout: false
      else
        redirect to '/'
      end
    else
      redirect to '/'
    end
  end



  # # PATCH: /listings/5     #edit form/
  patch "/listings/:id" do
    if logged_in?
        if params[:title] == "" || params[:location] == "" || params[:description] == "" || params[:vibe] == "" || params[:skill] == ""
          redirect to "/users/:id" #go to home page
        else
          @listing = Listing.find_by_id(params[:id])
            if current_user
              if @listing.update(title: params[:title], location: params[:location], description: params[:description], vibe: params[:vibe], skill: params[:skill])
                redirect to "/users/#{current_user.id}"
              else
                redirect to "/users/home#{params[:id]}/edit"
              end
            else
              redirect to "/users/#{current_user.id}"
            end
          end
        else
          redirect to '/login'
        end
    end



  # DELETE: /listings/5/delete
  delete "/listings/:id/delete" do
    @listing = Listing.find_by_id(params[:id])
   if logged_in?
     if @listing && @listing.user == current_user
        @listing.delete
       redirect to "/users/#{current_user.id}"
     else
       redirect to '/login'
     end
   end
 end

end
