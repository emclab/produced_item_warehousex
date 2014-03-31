class CreateProducedItemWarehousexCheckouts < ActiveRecord::Migration
  def change
    create_table :produced_item_warehousex_checkouts do |t|
      t.integer :item_id
      t.date :out_date
      t.integer :out_qty
      t.integer :last_updated_by_id
      t.string :wf_state
      t.integer :requested_by_id
      t.integer :checkout_by_id
      t.text :brief_note
      t.text :packaging_desp

      t.timestamps
    end
    
    add_index :produced_item_warehousex_checkouts, :item_id
    add_index :produced_item_warehousex_checkouts, :wf_state
  end
end
