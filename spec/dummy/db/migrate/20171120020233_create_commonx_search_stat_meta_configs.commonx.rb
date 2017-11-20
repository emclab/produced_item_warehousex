# This migration comes from commonx (originally 20161117190901)
class CreateCommonxSearchStatMetaConfigs < ActiveRecord::Migration
  def change
    create_table :commonx_search_stat_meta_configs do |t|
      t.string :resource_name
      t.text :stat_summary_function
      t.text :search_summary_function
      t.text :labels_and_fields
      t.text :time_frame
      t.text :stat_header
      t.string :fort_token
      t.integer :last_updated_by_id

      t.timestamps null: false
    end
    
    add_index :commonx_search_stat_meta_configs, :resource_name
    add_index :commonx_search_stat_meta_configs, :fort_token
  end
end
