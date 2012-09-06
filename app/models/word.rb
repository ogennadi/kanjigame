class Word < ActiveRecord::Base
  validates :kanji, :uniqueness => true
  has_and_belongs_to_many :characters
end
