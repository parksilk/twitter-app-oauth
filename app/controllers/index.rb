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

post '/tweet' do
  text = params[:text]

  # gets the current user that made the post
  user = get_user

  # stores the user's tweet in our database
  tweet = user.store_tweet(text, user.id)

  # queue up the tweet to be posted
  TweetWorker.perform_async(user.id, tweet.id)

  erb :tweet
end
