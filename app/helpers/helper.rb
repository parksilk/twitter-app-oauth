helpers do


  def client
  Twitter::Client.new(
          :consumer_key => session[:consumer_key],
          :consumer_secret => session[:consumer_secret],
          :oauth_token => session[:oauth_token],
          :oauth_token_secret => session[:oauth_token_secret])
  end
end
