class ApplicationController < ActionController::Base
    include Pagy::Backend
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    
    def authenticate_admin!
        redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user&.admin?
    end
    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
            devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :avatar])
        end
end