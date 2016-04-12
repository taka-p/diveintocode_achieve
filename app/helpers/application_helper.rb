module ApplicationHelper
  def profile_img(user, opt)
    if user.image?
      img_url = user.image.thumb.url
    elsif user.provider == 'facebook'
      img_url = "https://graph.facebook.com/#{user.uid}/picture?width=320&height=320"
    elsif user.provider == 'twitter'
      img_url = "http://furyu.nazo.cc/twicon/#{user.uid}"
    else
      # TODO: gravatarは登録判定がとれるまでコメントアウト
      # gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      # img_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      img_url = image_url('noimage.png')
    end
    image_tag(img_url, opt)
  end
end
