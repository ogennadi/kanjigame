class CreateCharactersWords < ActiveRecord::Migration
  def change
    create_table :characters_words do |t|
      t.integer :character_id
      t.integer :word_id
    end
  end
end
