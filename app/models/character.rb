class Character < ActiveRecord::Base
  validates :glyph, :uniqueness => true
  has_and_belongs_to_many :words
end
