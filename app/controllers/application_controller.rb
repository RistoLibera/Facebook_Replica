class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    private
    
    def configure_permitted_parameters
        update_attrs = [:firstname, :lastname, :birthday, :gender]
        devise_parameter_sanitizer.permit(:sign_up, keys: update_attrs)
    end
  
end
