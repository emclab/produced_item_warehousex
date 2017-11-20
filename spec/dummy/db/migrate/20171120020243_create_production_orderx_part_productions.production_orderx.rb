# This migration comes from production_orderx (originally 20141111213647)
class CreateProductionOrderxPartProductions < ActiveRecord::Migration
  def change
    create_table :production_orderx_part_productions do |t|
      t.integer :part_id  
      t.integer :order_id  #belongs to a sales order
      t.string :part_name
      t.string :spec
      t.string :part_num
      t.string :drawing_num
      t.text :requirement
      t.date :start_date
      t.date :finish_date
      t.boolean :void, :default => false
      t.integer :last_updated_by_id
      t.decimal :qty, :precision => 12, :scale => 2
      t.string :unit
      t.decimal :qty_produced, :precision => 12, :scale => 2
      t.boolean :completed, :default => false
      t.boolean :expedite, :default => false
      t.integer :coordinator_id
      t.date :actual_finish_date
      t.string :wf_state
      t.string :batch_num
      t.text :brief_note
      t.string :aux_resource   #'ic_productionx/ic_infos'.  pointing to a table with more production order detail
      t.string :fort_token
      #t.decimal :material_cost, :precision => 10, :scale => 2
           
      t.timestamps
    end
    
    add_index :production_orderx_part_productions, :part_name
    add_index :production_orderx_part_productions, :drawing_num
    add_index :production_orderx_part_productions, :part_num
    add_index :production_orderx_part_productions, :fort_token
    add_index :production_orderx_part_productions, :spec
    add_index :production_orderx_part_productions, :batch_num
    add_index :production_orderx_part_productions, :coordinator_id
    add_index :production_orderx_part_productions, :completed
    add_index :production_orderx_part_productions, :void
    add_index :production_orderx_part_productions, :expedite
    add_index :production_orderx_part_productions, :order_id
    add_index :production_orderx_part_productions, :part_id
    add_index :production_orderx_part_productions, :aux_resource, :name => :production_orderx_part_productions_aux
    
  end
end
