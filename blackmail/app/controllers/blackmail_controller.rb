require 'digest'

class BlackmailController < ApplicationController
  def index
  end
  def login
    unless @logged_user.nil?
      redirect_to dashboard_view_url
    end
  end
  def newlogin
    account = params[:account]
    user = User.find_by(username: account[:username])

    unless user.nil? || account[:password].empty? || account[:password].nil?
      passhash = Digest::SHA256.base64digest(account.require(:password))
      if user.passhash == passhash
        uid = user.uid;
        # Nuke possible old session
        @session = Session.find_by(uid: uid)
        unless @session.nil?
          @session.destroy()
        end
        # Create login session in database
        @session = Session.new(uid: uid, token: SecureRandom.uuid)
        @session.save()
        # Set session cookie on client
        cookies[:sessionid] = @session.token
        redirect_to dashboard_view_url
      end
    else
      #return 'invalid credentails'
      render 'login'
    end
  end
  def create_account

    # puts params[:account]
    account = params[:account]
    unless account[:password].nil? || account[:password].empty? || account[:password_confirmation].empty? || account[:password_confirmation].nil?
      if account.require(:password) == account.require(:password_confirmation)
        passhash = Digest::SHA256.base64digest(account.require(:password))
      end
      uid = Digest::SHA256.hexdigest(account.require(:username))
    end

    unless account[:username].nil? || account[:username].empty?
      username = account.require(:username)
    end

    # TODO Assuming no malformed input here, and not checking any input fields
    # This will also allow duplicate entries for username, but it at least fucntional
    @user = User.new(uid: uid, username: username,
    passhash: passhash)
    if @user.save()
      # success
      render plain: params[:account]
    else
      # re-render sign up form
      render 'register'
    end
  end
end
