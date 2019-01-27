require 'digest'

class BlackmailController < ApplicationController
  def index
  end
  def login
  end
  def create_account

    # puts params[:account]
    account = params[:account]
    if account[:password] == account[:password_confirmation]
      passhash = Digest::SHA256.base64digest(account.require(:password))
    end
    uid = Digest::SHA256.hexdigest(account.require(:username))

    # TODO Assuming no malformed input here, and not checking any input fields
    # This will also allow duplicate entries for username, but it at least fucntional
    @user = User.new(uid: uid, username: account.require(:username),
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
