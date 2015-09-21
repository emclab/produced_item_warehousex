# This migration comes from mfg_batchx (originally 20140305051337)
class CreateMfgBatchxStepQties < ActiveRecord::Migration
  def change
    create_table :mfg_batchx_step_qties do |t|
      t.integer :batch_id
      t.integer :batch_status_id
      t.integer :qty_in
      t.integer :qty_out
      t.text :brief_note
      t.integer :last_updated_by_id
      t.string :ontime_indicator  #green, red and yellow
      t.datetime :start_time
      t.datetime :finish_time
      
      t.timestamps
      
    end
    
    add_index :mfg_batchx_step_qties, :batch_id
    add_index :mfg_batchx_step_qties, :batch_status_id
    add_index :mfg_batchx_step_qties, :start_time
    add_index :mfg_batchx_step_qties, :finish_time
  end
end
