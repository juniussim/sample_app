module UsersHelper
	# Returns the Gravatar for the given user.
	# what kind of parameter is size: 80? Is it a hash? if it is, why do we access it with just size
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
