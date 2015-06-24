class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics
  has_many :favorites
  has_many :favorite_topics ,:through => :favorites ,:source =>:topic

  def short_name
  	self.email.split("@").first
  end
end
