class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend , :class_name => "User"

	def self.status?(me, friend)
		ff = find_friend(me,friend)

		if ff
			return ff.status
		else
			return nil
		end


	end


	


private

	def self.find_friend(me,friend)
		me.friendships.find_by(:friend_id => friend)
	end




	#current_user.friendships.each |fs|
	#	fs.friend
	#end

end
