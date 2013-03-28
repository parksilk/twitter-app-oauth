get '/' do
  erb :index
end

get "/request" do
  redirect request_token.authorize_url
end

get '/auth' do
  get_access_token

  erb :tweet
end

get '/tweet' do
  user = get_user
  @tweets = user.tweets.reverse
  erb :tweet
end

post '/tweet' do
  text = params[:text]
  # gets the current user that made the post
  user = get_user
  # stores the user's tweet in our database
  tweet = user.store_tweet(text, user.id)
  # queue up the tweet to be posted
  job_id = TweetWorker.perform_in(10.seconds, user.id, tweet.id)
  tweet.update_attributes(:job_id => job_id.to_s)
end

get '/status/:job_id' do
  @status = job_is_complete(params[:job_id])
  erb :status
end
