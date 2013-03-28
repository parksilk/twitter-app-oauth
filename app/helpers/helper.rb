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

  def get_user
		User.find_or_create_by_token(
      :token => session[:token],
      :secret => session[:secret])
  end

	def job_is_complete(jid)
	  waiting = Sidekiq::Queue.new
	  p "%" * 50
	  p waiting.each { |thing| puts thing }
	  working = Sidekiq::Workers.new
	  p "%" * 50
	  p working.inspect
	  p working.first
	  return false if waiting.find { |job| job.jid == jid }
	  return false if working.find { |worker, info| info["payload"]["jid"] == jid }
	  true
	end

end
