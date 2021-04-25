class Searching < ApplicationRecord
  belongs_to :user
  
  validates :word, presence: true, uniqueness: { case_sensitive: false }
end
