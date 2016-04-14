class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'アカウントを削除しました'
  end
end
