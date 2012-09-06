class Word < ActiveRecord::Base
  validates :kanji, :uniqueness => true
  has_and_belongs_to_many :characters

  def as_json(options={})
    {'word' => kanji, 'reading' => reading, 'meaning' => meaning }
  end
end
