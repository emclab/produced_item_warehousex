class CreateProducedItemWarehousexItems < ActiveRecord::Migration
  def change
    create_table :produced_item_warehousex_items do |t|
      t.integer :batch_id
      t.string :name
      t.string :spec
      t.string :part_num
      t.string :unit
      t.date :in_date
      t.decimal :in_qty, :precision => 12, :scale => 4
      t.decimal :stock_qty, :precision => 12, :scale => 4
      t.integer :last_updated_by_id
      t.string :storage_location
      t.text :brief_note
      t.text :packaging_desp
      t.integer :checkin_by_id
      t.integer :part_id

      t.timestamps
    end
    
    add_index :produced_item_warehousex_items, :batch_id
    add_index :produced_item_warehousex_items, :checkin_by_id
    add_index :produced_item_warehousex_items, :part_id
    add_index :produced_item_warehousex_items, :part_num
    add_index :produced_item_warehousex_items, :name
    add_index :produced_item_warehousex_items, :spec
  end
end
