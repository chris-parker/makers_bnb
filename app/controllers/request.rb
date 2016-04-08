class MakersBNB < Sinatra::Base
  post '/request/make' do
  space = Space.get(params[:request])
    if current_user.spaces.include? space
      flash.now[:error] = ["You cannot request your own space!"]
      @spaces = Space.all
      erb :'spaces/spaces'
    else
      session[:space] = params[:request]
      redirect to('/request/new')
    end
  end

  get '/request/new' do
    @space = Space.get(session[:space])
    erb :'request/new'
  end

  post '/request/new' do
    @space = Space.get(session[:space])
    request = Request.new(start_date: params[:start_date], end_date: params[:end_date])
    if request.start_date >= request.end_date
      flash.now[:error] = ["End date must be after start date"]
      erb :'request/new'
    else
      @space.requests << request
      current_user.requests << request
      request.save
      session[:request] = request.id
      Email.new.send_mail(User.get(@space.user_id).email, 'Someone has requested your space!', erb(:'emails/requestee_email', layout: false))
      Email.new.send_mail(current_user.email, 'You have requested a space!', erb(:'emails/requester_email', layout: false))
      SMS.new.send_request_made
      redirect to('/request/confirmation')
    end
  end

  get '/request/confirmation' do
    @space = Space.get(session[:space])
    @rekwest = Request.get(session[:request])
    erb :'request/confirmation'
  end

  get '/requests_made' do
    @rekwests = current_user.requests
    erb :'request/view'
  end

  post '/request/delete' do
    rekwest = Request.get(params[:cancel_request])
    rekwest.destroy
    redirect to('/requests_made')
  end

end
