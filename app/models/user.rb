class User < ActiveRecord::Base
    validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
    has_many :news
    has_secure_password
end
