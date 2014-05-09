# This migration comes from mfg_batchx (originally 20131023212224)
class CreateMfgBatchxBatches < ActiveRecord::Migration
  def change
    create_table :mfg_batchx_batches do |t|
      t.string :batch_num
      t.string :wf_state
      t.integer :order_id
      t.integer :last_updated_by_id
      t.integer :qty
      t.integer :rfq_id
      t.boolean :completed, :default => false
      t.date :start_date
      t.date :finish_date
      t.text :brief_note
      t.boolean :void, :default => false
      t.integer :qty_produced
      t.integer :batch_status_id

      t.timestamps
    end
    
    add_index :mfg_batchx_batches, :order_id
    add_index :mfg_batchx_batches, :rfq_id
    add_index :mfg_batchx_batches, :batch_status_id
    add_index :mfg_batchx_batches, :completed
    add_index :mfg_batchx_batches, :void
    add_index :mfg_batchx_batches, :wf_state
    add_index :mfg_batchx_batches, :finish_date
  end
end
