# app/controllers/admin/dashboard_controller.rb
module Admin
    class DashboardController < ApplicationController
      before_action :authenticate_admin!
  
      def index
        # Admin dashboard logic here
      end
  
      private
  
      def authenticate_admin!
        unless current_user&.admin?
          render file: "#{Rails.root}/public/403.html", layout: false, status: :forbidden
        end 
      end
    end
  end