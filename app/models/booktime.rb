class Booktime < ApplicationRecord
    validates :date, presence: true 
    validates :time, presence: true
    validates :email, presence: true
end
