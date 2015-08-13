get '/' do
  erb :index
end

get '/:username' do
  @user = User.find_or_create_by(username: params[:username])

  if @user.tweets_are_stale?
    @user.fetch_tweets!
    @tweets = @user.tweets

    erb :index
  else
    @tweets = @user.tweets
    erb :index
  end
end


post '/tweets' do
  # find who is the current user
 @user = User.find_or_create_by(username: session[:user])
  @tweet = @user.post_tweet!(params[:tweet])

  @tweet.to_json
  # redirect "/:username"
end



get '/auth/twitter/callback' do
  halt(401,'Not Authorised') unless env['omniauth.auth']
  @user = User.find_or_create_by(username: env['omniauth.auth']['info']['nickname'])
  @token = env['omniauth.auth']['credentials']['token']
  @secret =env['omniauth.auth']['credentials']['secret']

  @user.access_token = @token
  @user.access_secret = @secret
  @user.save

  session[:user] = @user.username
  redirect to "/#{@user.username}"


  #find by uid/username
  #if the user is not yet created, save the token and access token secret
  #set the user session
  #redirect to tweet page
  #
end

