class New < ActiveRecord::Base
    
    validates :user_id, presence: true
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    belongs_to :user

end
