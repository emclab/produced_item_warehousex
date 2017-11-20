# This migration comes from production_orderx (originally 20170119184424)
class CreateProductionOrderxOperators < ActiveRecord::Migration
  def change
    create_table :production_orderx_operators do |t|
      t.string :name
      t.integer :hr_id
      t.decimal :hours_spent, :precision => 8, :scale => 2
      t.integer :last_updated_by_id
      t.decimal :hourly_rate, :precision => 8, :scale => 2
      t.string :fort_token
      t.text :brief_note
      t.integer :production_step_id

      t.timestamps null: false
    end
    
    add_index :production_orderx_operators, :production_step_id
    add_index :production_orderx_operators, :name
    add_index :production_orderx_operators, :fort_token
    add_index :production_orderx_operators, :hr_id
  end
end
