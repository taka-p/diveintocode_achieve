module ApplicationHelper
  def profile_img(user, opt)
    if user.provider == 'facebook'
      img_url = "https://graph.facebook.com/#{user.uid}/picture?width=320&height=320"
    elsif user.provider == 'twitter'
      img_url = "http://furyu.nazo.cc/twicon/#{user.uid}"
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      img_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    end
    image_tag(img_url, opt)
  end
end
