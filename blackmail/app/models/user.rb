class User < ApplicationRecord
  validates :uid, presence: true
  validates :username, presence: true
  validates :passhash, presence: { message: "must match confirmation field" }
  validates :username, uniqueness: true

end
