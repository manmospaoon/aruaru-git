class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 50 }
  validates_uniqueness_of:content
  
  belongs_to :user
  belongs_to :theme
end
 