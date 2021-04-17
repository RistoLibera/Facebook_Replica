class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likings, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :friends, through: :requests, class_name: "User"

  validates :firstname, :lastname, :birthday, :gender, presence: true

  def fullname
    [firstname, lastname].join(' ')
  end


end
