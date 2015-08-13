class User < ActiveRecord::Base

  # Remember to create a migration!
  has_many :tweets

  def fetch_tweets!
    user = self.generate_client
    @fetched_tweets = user.user_timeline(self.username)
    self.tweets.destroy_all
    @fetched_tweets.each do |t|
      self.tweets.create(text: t.text)
    end
  end

  def post_tweet!(post_tweet)
    user = self.generate_client
    user.update(post_tweet)
  end

  def tweets_are_stale?
    if self.tweets.blank? || Time.now - tweets.last.created_at > 30
      true
    else
      false
    end
  end

  def generate_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = API_KEYS["twitter_consumer_key_id"]
      config.consumer_secret     = API_KEYS["twitter_consumer_secret_key_id"]
      config.access_token        = self.access_token
      config.access_token_secret = self.access_secret
    end
  end

end

