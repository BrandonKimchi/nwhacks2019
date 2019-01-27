require 'digest'
require 'openssl'

class ContractController < ApplicationController

  def view
  end

  def create
  end

  def new
    render plain: params

    contract = params[:contract]
    # get owner uid from session
    condition = contract.require(:contract) # the task to be completed
    content = contract.require(:content) # the secret held as collateral
    password = contract.require(:password)
    receiverUID = contract.require(:receiverUID)
    deadline = contract.require(:deadline) # deadline in s since epoch

    key = Digest::SHA256.digest(password)
    cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    cipher.encrypt

    cipher.key = key
    iv = cipher.random_iv
    cipher.iv = iv

    ciphertext = cipher.update(content)
    ciphertext << cipher.final

    @contract = Contract.new(
        ownerUID: "a",
        receiverUID: receiverUID,
        content: ciphertext,
        pwhash: password,
        crypto_iv: iv,
        task: condition,
        expiration: deadline)
    @contract.save()

  end
end
