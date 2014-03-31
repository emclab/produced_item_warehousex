class CreateProducedItemWarehousexItems < ActiveRecord::Migration
  def change
    create_table :produced_item_warehousex_items do |t|
      t.integer :batch_id
      t.string :name
      t.date :in_date
      t.integer :in_qty
      t.integer :stock_qty
      t.integer :last_updated_by_id
      t.string :storage_location
      t.text :brief_note
      t.text :packaging_desp
      t.integer :checkin_by_id

      t.timestamps
    end
    
    add_index :produced_item_warehousex_items, :batch_id
    add_index :produced_item_warehousex_items, :checkin_by_id
  end
end
