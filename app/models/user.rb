class User < ActiveRecord::Base
	has_many :tweets

	validates :username, :presence => true
  validates :token, :presence => true
  validates :secret, :presence => true
end
