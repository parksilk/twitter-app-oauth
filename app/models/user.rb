class User < ActiveRecord::Base
	has_many :tweets

  validates :token, :presence => true
  validates :secret, :presence => true

  # def tweet(text)
  #   TweetWorker.perform_async(self.id, text)
  # end

  def store_tweet(text, id)
  	Tweet.create(:text => text, :user_id => id)
  end
end
