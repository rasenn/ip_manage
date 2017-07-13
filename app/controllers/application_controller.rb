class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  protect_from_forgery with: :exception


  def after_sign_in_path_for(resource)
    case resource
    when AdminUser
      admin_user_root_path
    when User
      user_root_path
    end
  end


  def after_sign_out_path_for(resource)
    if resource == :admin_user
      new_admin_user_session_path
    elsif resource == :user
      new_user_session_path
    end
  end

end
