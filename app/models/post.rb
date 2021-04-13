class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likings, dependent: :destroy
    validates :body, presence: true
end
