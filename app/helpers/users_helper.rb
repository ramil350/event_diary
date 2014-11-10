require 'digest/md5'

module UsersHelper
  def photo_url_for(user, size = nil)
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    photo_url = "http://www.gravatar.com/avatar/#{hash}"
    photo_url << "?s=#{size}" if size
    photo_url
  end
end