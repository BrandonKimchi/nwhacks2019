require 'digest'

class BlackmailController < ApplicationController
  def index
  end
  def login
    account = params[:account]
    user = User.find_by(username: account[:username])

    unless user.nil? || account[:password].empty? || account[:password].nil?
      phash = Digest::SHA256.base64digest(account.require(:password))
      if user.passhash == phash
        render plain: params[:account]
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
