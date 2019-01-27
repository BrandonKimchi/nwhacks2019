class BlackmailController < ApplicationController
  def index
  end
  def login
  end
  def create_account
    render plain: params[:username]
  end
end
