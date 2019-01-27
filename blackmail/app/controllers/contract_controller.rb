require 'digest'
require 'openssl'

class ContractController < ApplicationController

  def view
    password = params[:passphrase]
    contractid = params[:contractID]
    contract = Contract.find_by(id: contractid)
    iv = contract.crypto_iv
    key = Digest::SHA256.digest(password)
    ciphertext = contract.content

    cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    cipher.decrypt
    cipher.key = key
    cipher.iv = iv

    plaintext = cipher.update(ciphertext)
    plaintext << cipher.final
    render plain: plaintext
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
    render plain: params

    contract = params[:contract]
    # get owner uid from session
    condition = contract.require(:contract) # the task to be completed
    content = contract.require(:content) # the secret held as collateral
    password = contract.require(:password)
    receiverUID = contract.require(:receiverUID)
    deadline = contract.require(:deadline) # deadline in s since epoch

    contractid = Digest::SHA256.hexdigest(contract.to_s) # TODO add user ID when available

    key = Digest::SHA256.digest(password)
    cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    cipher.encrypt

    cipher.key = key
    iv = cipher.random_iv
    cipher.iv = iv

    ciphertext = cipher.update(content)
    ciphertext << cipher.final

    @contract = Contract.new(
        id: contractid,
        ownerUID: "a",
        receiverUID: receiverUID,
        content: ciphertext,
        pwhash: password,
        crypto_iv: iv,
        task: condition,
        expiration: deadline)
    @contract.save()
    redirect_to '/dashboard/view'
  end
end
