before do

  session[:oauth] ||= {}            # we'll store the request and access tokens here
  host = request.host
  host << ":9292" if request.host == "localhost"
  consumer_key = 'TWanBFjz40N5VOBHt5NR6w'
  session[:consumer_key] = consumer_key      # what twitter.com/apps says   
  consumer_secret = '05emKIrlWHRgSRlvrN7IHQIdsfrPUGRrDPnmcCaGvq0'
  session[:consumer_secret] = consumer_secret# shhhh, its a secret   
  @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, :site => "http://api.twitter.com")

    # generate a request token for this user session if we haven't already
  request_token = session[:oauth][:request_token]   
  request_token_secret = session[:oauth][:request_token_secret]
  if request_token.nil? || request_token_secret.nil?
    # new user? create a request token and stick it in their session
    @request_token = @consumer.get_request_token(:oauth_callback => "http://127.0.0.1:9292/auth")
    session[:oauth][:request_token] = @request_token.token
    session[:oauth][:request_token_secret] = @request_token.secret
  else
    # we made this user's request token before, so recreate the object
    @request_token = OAuth::RequestToken.new(@consumer, request_token, request_token_secret)
  end

  # this is what we came here for...   
  access_token = session[:oauth][:access_token]   
  access_token_secret = session[:oauth][:access_token_secret]
  unless access_token.nil? || access_token_secret.nil?
    # the ultimate goal is to get here, where we can create our Twitter @client   
    # object
    @access_token = OAuth::AccessToken.new(@consumer, access_token, access_token_secret)    
    oauth = Twitter::OAuth.new(consumer_key, consumer_secret)
    oauth.authorize_from_access(@access_token.token, @access_token.secret)     
    @client = Twitter::Base.new(oauth)
  end 
end

#oauth related routes

get '/auth' do
  session[:oauth_token] = params[:oauth_token]
  session[:oauth_token_secret] = params[:oauth_verifier]
  p "$$$$$$$$$$$$$$"
  p params[:oauth_token]
  p params[:oauth_verifier]
  p "***************"
   client
  erb :tweet
end


get "/request" do
  redirect @request_token.authorize_url
end


#index and tweeting routes

get '/' do
  erb :index
end

post '/tweet' do
    @client = client
  p "^^^^^^^^^^^^^^^^^^^"
  p @client
  @error_message = nil
  begin
    @client.update(params[:text])
  rescue Twitter::Error => e
    @error_message = e.message
  end
  if @error_message
      @error_message
  else
    params[:text]
  end
end
