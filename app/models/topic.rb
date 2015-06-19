class Topic < ActiveRecord::Base
	has_many :topic_categoryships
	has_many :comments
	has_many :categories, :through => :topic_categoryships
end
