# This migration comes from commonx (originally 20130827231304)
class CreateCommonxReportConfigs < ActiveRecord::Migration
  def change
    create_table :commonx_report_configs do |t|
      t.string    :report_name
      t.string    :resource_name
      t.string    :display_as_choices
      t.string    :measure_choices
      t.string    :x_axis_choices
      t.string    :y_axis_choices
      t.string    :stack_by_choices
      t.string    :sort_rows_by_choices
      t.string    :icon_url
      t.string    :fort_token
      t.text      :data_series
      t.integer   :last_updated_by_id
      t.timestamps null: false
      t.integer   :id_in_cis
    end

    add_index :commonx_report_configs, :report_name
    add_index :commonx_report_configs, :resource_name
    add_index :commonx_report_configs, :fort_token
    add_index :commonx_report_configs, :id_in_cis
  end
end
