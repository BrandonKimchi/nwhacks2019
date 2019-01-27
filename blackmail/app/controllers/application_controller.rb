class ApplicationController < ActionController::Base

  before_action :check_login

  def check_login
    sessid  = cookies[:sessionid]
    unless sessid.nil? || sessid.empty?
      session = Session.find_by(token: sessid)
      unless session.nil?
        @logged_user = User.find_by(uid: session.uid)
      end
    end
  end
end
