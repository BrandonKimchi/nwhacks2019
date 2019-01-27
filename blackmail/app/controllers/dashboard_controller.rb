class DashboardController < ApplicationController
  def view
    if @logged_user.nil?
      redirect_to blackmail_login_url
    end
  end
end
