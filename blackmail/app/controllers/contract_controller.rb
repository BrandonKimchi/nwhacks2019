require 'digest'
require 'openssl'

class ContractController < ApplicationController

  def view
    if @logged_user.nil?
      redirect_to blackmail_login_url
    end
    password = params[:passphrase]
    contractid = params[:contractID]
    contract = Contract.find_by(id: contractid)
    unless contract.nil?
      key = Digest::SHA256.digest(password)

      # security checks
      # User must be receiver for this  bounty
      if @logged_user.username == contract.receiverUID &&
      # Password must be correct for the hash stored with this contract
        key == contract.passhash &&
      # Time must be past the deadline
        Time.now.to_i > contract.expiration


        iv = contract.crypto_iv
        ciphertext = contract.content

        cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
        cipher.decrypt
        cipher.key = key
        cipher.iv = iv

        plaintext = cipher.update(ciphertext)
        plaintext << cipher.final
        render plain: plaintext
      else
        # render plain: contract.passhash
        redirect_to '/dashboard/view'
      end
    end
  end

  def create
    if @logged_user.nil?
      redirect_to blackmail_login_url
    end
  end

  def complete
    if @logged_user.nil?
      redirect_to blackmail_login_url  # redirect to login if not logged in yet
    end
    # Destroy the record
    contractid = params[:contractID]
    contract = Contract.find_by(id: contractid)
    contract.destroy
    render 'dashboard/view'
  end

  def new
    if @logged_user.nil?
      redirect_to blackmail_login_url
    end

    contract = params[:contract]
    ownerUID = @logged_user.username
    unless contract[:contract].nil? || contract[:contract].empty?
      condition = contract.require(:contract) # the task to be completed
    end
    unless contract[:content].nil? || contract[:content].empty?
      content = contract.require(:content) # the secret held as collateral
    end
    unless contract[:password].nil? || contract[:password].empty?
      password = contract.require(:password)
    end
    unless contract[:receiverUID].nil? || contract[:receiverUID].empty?
      receiverUID = contract.require(:receiverUID)
    end
    unless contract[:deadline].nil? || contract[:deadline].empty?
      deadline = contract.require(:deadline) # deadline in s since epoch
    end


    unless contract[:content].nil? || contract[:content].empty? || contract[:password].nil? || contract[:password].empty?
      contractid = SecureRandom.uuid
      key = Digest::SHA256.digest(password)
      cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
      cipher.encrypt

      cipher.key = key
      iv = cipher.random_iv
      cipher.iv = iv

      ciphertext = cipher.update(content)
      ciphertext << cipher.final
    end

    @contract = Contract.new(
        contractid: contractid,
        ownerUID: ownerUID,
        receiverUID: receiverUID,
        content: ciphertext,
        passhash: key,
        crypto_iv: iv,
        task: condition,
        expiration: deadline)
    @contract.save()
    redirect_to '/dashboard/view'
  end
end
