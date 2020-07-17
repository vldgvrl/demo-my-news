class New < ActiveRecord::Base
    
    validates :user_id, presence: true
    validates :title, presence: true, length: { minimum: 3, maximum: 120 }
    belongs_to :user
    has_one_attached :picture

end
