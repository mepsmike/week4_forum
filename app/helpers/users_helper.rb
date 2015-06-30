module UsersHelper

	def user_logo(user)
		image_tag user.gravatar_url
	end

end
