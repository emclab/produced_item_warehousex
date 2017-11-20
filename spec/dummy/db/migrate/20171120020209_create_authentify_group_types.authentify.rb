# This migration comes from authentify (originally 20130121221405)
class CreateAuthentifyGroupTypes < ActiveRecord::Migration
  def change
    create_table :authentify_group_types do |t|
      t.string :name
      t.timestamps
      t.string :brief_note
      t.string :resource_string
      t.string :fort_token  
      t.integer :id_in_cis    
    end
    
    add_index :authentify_group_types, :name 
    add_index :authentify_group_types, :fort_token
  end
end
