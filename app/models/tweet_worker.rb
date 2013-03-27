class TweetWorker
	include Sidekiq::Worker

  def perform(user_id, tweet_id)
	  user  = User.find(user_id)
	  tweet = user.tweets.find(tweet_id)

	  # set up Twitter OAuth client here
	  client = create_client(user)
		
		# set user's username
		user.update_attributes(:username => client.user.screen_name) unless user.username

	  # actually make API call
	  client.update(tweet.text)
  end

  def create_client(user)
  	Twitter::Client.new(
      :oauth_token => user.token,
      :oauth_token_secret => user.secret)
  end
end
