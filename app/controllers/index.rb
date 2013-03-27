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

  client.update(text)
  user = User.find_by_token(session[:token])

  Tweet.create(:text => text, :user_id => user.id)

  erb :tweet
end
