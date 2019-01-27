require 'digest'
require 'openssl'

class ContractController < ApplicationController

  def view
    password = params[:passphrase]

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

  end
end
