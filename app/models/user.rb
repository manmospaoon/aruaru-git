class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :themes
  has_many :comments
  has_many :favorites
  has_many :fav_comments, through: :favorites, source: :comment
  
  def like(comment)
    favorites.find_or_create_by(comment_id: comment.id)
  end
  
  def unlike(comment)
   favorite = self.favorites.find_by(comment_id: comment.id)
   favorite.destroy if favorite
  end
  
  def like?(comment)
    self.fav_comments.include?(comment)
  end
  
end
