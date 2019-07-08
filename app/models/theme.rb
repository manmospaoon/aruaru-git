class Theme < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 20 }
  validates_uniqueness_of:content
  
end
