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
  client.update(params[:text])
  erb :tweet
end
