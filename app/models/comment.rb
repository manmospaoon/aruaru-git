class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 50 }
  validates_uniqueness_of:content, :scope => :theme_id
  
  belongs_to :user
  belongs_to :theme
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
end
 