class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :favourites, dependent: :nullify
  has_many :favourite_posts, through: :favourites, source: :post

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
