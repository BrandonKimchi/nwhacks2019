class Contract < ApplicationRecord
  validates :contractid, uniqueness: true
  validates :ownerUID, presence: true
  validates :receiverUID, presence: true
  validates :content, presence: true
  validates :passhash, presence: true
  validates :crypto_iv, presence: true
  validates :task, presence: true
  validates :expiration, numericality: { only_integer: true }
end
