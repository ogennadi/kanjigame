class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string  :glyph, :null => false 

      t.timestamps
    end

    add_index :characters, :glyph, :unique => true
  end
end
