MODELS
  user
    has many listings
    has secure password
    is unique
      attr: name
      attr: username
      attr: password

  listing
    belongs to user
      attr: title
      attr: location
      attr: description
      foreign key: user_id

CONTROLLERS
  application_controller
    get '/'
      -shows index

  user_controller
    get '/signup'
      -shows user/signup
    get '/login'
      -shows user/login
    get 'logout'
      clear session
      redirect to '/'

  listing_controller
    get '/listings/:id'
      -shows listings/show
    get '/listings/:id/edit'
      -shows /listings/edit
    get '/listings/new'
      -shows '/listing/new'
    patch 'listings/:id'
      updates listing with id == :id
      redirect to 'listings/:id'
    post 'listings'
      creates a listing
      redirect to 'listings/:id'
    delete 'listings/:id/delete'
      deletes listing with id == :id
      redirect to 'listings/show'

VIEWS
  index
    shows all the listings
    shows valid/registration?
  user (folder)
    create new user
    action: show all listings
  listing (folder)
    show.erb > (shows one listing) shows user's listings // action: delete listing if owner > delete to /listings/:id/delete
             -link_to /listings/:id/edit / if owner
    edit.erb > (edit an exiting listing) action: update listing if owner // patch to /listings/:id
    new.erb > (make new listing page) action: create new listing // post to /listings
# BandmatesV2
