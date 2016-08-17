class CreateProducedItemWarehousexCheckouts < ActiveRecord::Migration
  def change
    create_table :produced_item_warehousex_checkouts do |t|
      t.integer :item_id
      t.date :out_date
      t.decimal :out_qty, :precision => 12, :scale => 4
      t.integer :last_updated_by_id
      t.string :wf_state
      t.integer :requested_by_id
      t.integer :checkout_by_id
      t.text :brief_note
      t.text :packaging_desp
      t.decimal :requested_qty, :precision => 12, :scale => 4
      t.string :fort_token

      t.timestamps
    end
    
    add_index :produced_item_warehousex_checkouts, :item_id
    add_index :produced_item_warehousex_checkouts, :wf_state
    add_index :produced_item_warehousex_checkouts, :out_date
    add_index :produced_item_warehousex_checkouts, :fort_token
  end
end
