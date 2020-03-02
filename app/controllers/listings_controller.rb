class ListingsController < ApplicationController

  # show all the listings
  get "/listings" do
    @listings = Listing.all
    erb :"/listings/index.html"
  end

  # shows the 'new listing' form
  get "/listings/new" do
    erb :"/listings/new.html"
  end

  # POST: /listings
  post "/listings" do
    @listing = Listing.create(:title => params[:title], :location => params[:location], :description => params[:description])
   redirect to '/listings/#{@listing.id}'
  end


  # shows listings that belong to user
  get "/listings/:id" do
    @listing = Listing.find_by_id(params[:id])
    erb :"/listings/show.html"
  end


  # allows user to edit THEIR listings
  get "/listings/:id/edit" do
    @listing = Listing.find_by_id(params[:id])
    erb :"/listings/edit.html"
  end



  # PATCH: /listings/5
  patch "/listings/:id" do
    redirect "/listings/:id"
  end













  # DELETE: /listings/5/delete
  delete "/listings/:id/delete" do
    redirect "/listings"
  end
end
