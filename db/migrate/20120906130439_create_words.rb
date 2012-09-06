class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string  :kanji,    :null => false
      t.string  :reading,  :null => false
      t.string  :meaning,  :null => false
      t.string  :pos,      :null => false
      t.integer :level

      t.timestamps
    end

    add_index :words, :kanji, :unique => true
  end
end
