# This migration comes from commonx (originally 20170320231914)
class CreateCommonxReportConfigDetails < ActiveRecord::Migration
  def change
    create_table :commonx_report_config_details do |t|
      t.integer   :report_config_id
      t.string    :display_as
      t.text      :time_periods
      t.string    :measure_choices, array: true, default: []
      t.integer   :segment_ranges_choices, array: true, default: []
      t.string    :segment_color_ranges_choices, array: true, default: []
      t.string    :x_axis_choices,   array: true, default: []
      t.string    :y_axis_choices,   array: true, default: []
      t.string    :sort_by_choices,   array: true, default: []
      t.string    :stack_by_choices,   array: true, default: []
      t.boolean   :stack_to_100_percent, default: false
      t.boolean   :horizontal_bar, default: false
      t.string    :value_choices,    array: true, default: []
      t.string    :sliced_by_choices, array: true, default: []
      t.boolean   :cumulative, default: false
      t.integer   :last_updated_by_id
      t.timestamps
      t.string    :dimension, array: true, default: []
      t.string    :columns, array: true, default: []
      t.string    :display_icon
      t.string    :applicable_columns, array: true, default: []
      t.string    :fort_token
      t.text      :max_values_displayed, json: true
      t.text      :view_template
      t.text      :min_layout, json: true

    end

    add_index :commonx_report_config_details, :report_config_id
    add_index :commonx_report_config_details, :fort_token
    add_index :commonx_report_config_details, :display_as

    
  end
end
