# This migration comes from messagingx (originally 20171015150309)
class CreateMessagingxNotifications < ActiveRecord::Migration
  def change
    create_table :messagingx_notifications do |t|
      t.integer :resource_id
      t.string :resource_string
      t.string :content
      t.integer :last_updated_by_id
      t.string :fort_token
      t.integer :urgency_scale #1..10 with 10 highest
      t.string :user_name

      t.timestamps null: false
    end
    add_index :messagingx_notifications, :resource_string
    add_index :messagingx_notifications, :fort_token
    add_index :messagingx_notifications, :urgency_scale
    add_index :messagingx_notifications, :user_name
  end
end
