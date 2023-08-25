class ApplicationController < ActionController::Base

  #ユーザー側、アドミン側でログインを場合わけ
  def after_sign_in_path_for(resource)
    case resource
    when User
      user_path(current_user)
    when Admin
      admin_root_path
    end
  end


end
