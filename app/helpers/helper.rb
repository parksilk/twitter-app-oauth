helpers do

	def create_consumer
    OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => "https://api.twitter.com")    
  end

  def request_token
    host = request.host
    host << ":9292" if request.host == "localhost"
    session[:request_token] ||= create_consumer.get_request_token(:oauth_callback => "http://#{host}/auth")
  end

  def get_access_token
  	access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  	session[:token] = access_token.token
  	session[:secret] = access_token.secret
  	session.delete(:request_token)
  end

  def client
  	Twitter::Client.new(
      :oauth_token => session[:token],
      :oauth_token_secret => session[:secret])
  end
end
