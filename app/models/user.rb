class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likings, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :friends, through: :requests, class_name: "::User"
  has_many :notifications, dependent: :destroy
  has_many :searchings, dependent: :destroy
  # Using Amazon Server
  has_one_attached :avatar, dependent: :purge_later
  has_one_attached :cover_image, dependent: :purge_later

  validates :firstname, :lastname, :birthday, :gender, presence: true

  # after_create :send_welcome_email

  def fullname
    [firstname, lastname].join(' ')
  end
  
  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  # Facebook-Omniauth; email is not returned while being api creator.
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      space = auth.info.name.index(' ')
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.firstname = auth.info.name[0, space]
      user.lastname = auth.info.name[space+1..-1]
      # user.image = auth.info.image 
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.lastname = data["name"] if user.lastname.blank?
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # Auto remember-me
  class User
    def remember_me
      (super == nil) ? true : super
    end
  end 
end
