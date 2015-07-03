class Tag < ActiveRecord::Base
	has_many :topic_tagship
	has_many :topics , :through => :topic_tagship
end
