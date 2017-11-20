# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171120031705) do

  create_table "authentify_engine_configs", force: :cascade do |t|
    t.string   "engine_name"
    t.string   "engine_version"
    t.string   "argument_name"
    t.text     "argument_value"
    t.integer  "last_updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brief_note"
    t.boolean  "global",             default: false
    t.string   "fort_token"
    t.integer  "id_in_cis"
  end

  add_index "authentify_engine_configs", ["argument_name"], name: "index_authentify_engine_configs_on_argument_name"
  add_index "authentify_engine_configs", ["engine_name", "argument_name"], name: "authentify_engine_configs_names"
  add_index "authentify_engine_configs", ["engine_name"], name: "index_authentify_engine_configs_on_engine_name"
  add_index "authentify_engine_configs", ["fort_token"], name: "index_authentify_engine_configs_on_fort_token"

  create_table "authentify_group_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brief_note"
    t.string   "resource_string"
    t.string   "fort_token"
    t.integer  "id_in_cis"
  end

  add_index "authentify_group_types", ["fort_token"], name: "index_authentify_group_types_on_fort_token"
  add_index "authentify_group_types", ["name"], name: "index_authentify_group_types_on_name"

  create_table "authentify_role_definitions", force: :cascade do |t|
    t.string   "name"
    t.string   "brief_note"
    t.integer  "last_updated_by_id"
    t.integer  "manager_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flag"
    t.string   "fort_token"
    t.integer  "id_in_cis"
  end

  add_index "authentify_role_definitions", ["flag"], name: "index_authentify_role_definitions_on_flag"
  add_index "authentify_role_definitions", ["fort_token"], name: "index_authentify_role_definitions_on_fort_token"
  add_index "authentify_role_definitions", ["manager_role_id"], name: "index_authentify_role_definitions_on_manager_role_id"

  create_table "authentify_sys_logs", force: :cascade do |t|
    t.datetime "log_date"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "user_ip"
    t.string   "action_logged"
    t.string   "fort_token"
    t.string   "resource"
  end

  add_index "authentify_sys_logs", ["fort_token"], name: "index_authentify_sys_logs_on_fort_token"
  add_index "authentify_sys_logs", ["user_id"], name: "index_authentify_sys_logs_on_user_id"
  add_index "authentify_sys_logs", ["user_name"], name: "index_authentify_sys_logs_on_user_name"

  create_table "authentify_sys_user_groups", force: :cascade do |t|
    t.string   "user_group_name"
    t.string   "short_note"
    t.integer  "zone_id"
    t.integer  "group_type_id"
    t.integer  "manager_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fort_token"
    t.integer  "id_in_cis"
  end

  add_index "authentify_sys_user_groups", ["fort_token"], name: "index_authentify_sys_user_groups_on_fort_token"
  add_index "authentify_sys_user_groups", ["group_type_id"], name: "index_authentify_sys_user_groups_on_group_type_id"
  add_index "authentify_sys_user_groups", ["manager_group_id"], name: "index_authentify_sys_user_groups_on_manager_group_id"
  add_index "authentify_sys_user_groups", ["zone_id"], name: "index_authentify_sys_user_groups_on_zone_id"

  create_table "authentify_user_accesses", force: :cascade do |t|
    t.string   "action"
    t.string   "resource"
    t.string   "brief_note"
    t.integer  "last_updated_by_id"
    t.integer  "role_definition_id"
    t.text     "sql_code"
    t.text     "masked_attrs"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fort_token"
    t.integer  "id_in_cis"
  end

  add_index "authentify_user_accesses", ["action", "resource"], name: "index_authentify_user_accesses_on_action_and_resource"
  add_index "authentify_user_accesses", ["action"], name: "index_authentify_user_accesses_on_action"
  add_index "authentify_user_accesses", ["fort_token"], name: "index_authentify_user_accesses_on_fort_token"
  add_index "authentify_user_accesses", ["rank"], name: "index_authentify_user_accesses_on_rank"
  add_index "authentify_user_accesses", ["resource"], name: "index_authentify_user_accesses_on_resource"
  add_index "authentify_user_accesses", ["role_definition_id"], name: "index_authentify_user_accesses_on_role_definition_id"

  create_table "authentify_user_levels", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "sys_user_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brief_note"
    t.string   "fort_token"
  end

  add_index "authentify_user_levels", ["fort_token"], name: "index_authentify_user_levels_on_fort_token"
  add_index "authentify_user_levels", ["sys_user_group_id"], name: "index_authentify_user_levels_on_sys_user_group_id"
  add_index "authentify_user_levels", ["user_id"], name: "index_authentify_user_levels_on_user_id"

  create_table "authentify_user_roles", force: :cascade do |t|
    t.integer  "last_updated_by_id"
    t.integer  "role_definition_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brief_note"
    t.string   "fort_token"
  end

  add_index "authentify_user_roles", ["fort_token"], name: "index_authentify_user_roles_on_fort_token"
  add_index "authentify_user_roles", ["role_definition_id"], name: "index_authentify_user_roles_on_role_definition_id"
  add_index "authentify_user_roles", ["user_id"], name: "index_authentify_user_roles_on_user_id"

  create_table "authentify_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "login"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "status",                     default: "active"
    t.integer  "last_updated_by_id"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brief_note"
    t.string   "cell"
    t.boolean  "allow_text_msg",             default: false
    t.boolean  "allow_email",                default: false
    t.integer  "customer_id"
    t.string   "local"
    t.date     "last_time_password_changed"
    t.text     "previous_passwords"
    t.boolean  "remember_me",                default: false
    t.string   "fort_token"
    t.text     "current_sessions"
    t.text     "home_redirect"
  end

  add_index "authentify_users", ["allow_email"], name: "index_authentify_users_on_allow_email"
  add_index "authentify_users", ["allow_text_msg"], name: "index_authentify_users_on_allow_text_msg"
  add_index "authentify_users", ["customer_id"], name: "index_authentify_users_on_customer_id"
  add_index "authentify_users", ["email"], name: "index_authentify_users_on_email"
  add_index "authentify_users", ["fort_token"], name: "index_authentify_users_on_fort_token"
  add_index "authentify_users", ["name"], name: "index_authentify_users_on_name"
  add_index "authentify_users", ["status"], name: "index_authentify_users_on_status"

  create_table "authentify_zones", force: :cascade do |t|
    t.string   "zone_name"
    t.string   "brief_note"
    t.boolean  "active",        default: true
    t.integer  "ranking_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fort_token"
    t.integer  "id_in_cis"
  end

  add_index "authentify_zones", ["fort_token"], name: "index_authentify_zones_on_fort_token"
  add_index "authentify_zones", ["id", "active"], name: "index_authentify_zones_on_id_and_active"

  create_table "commonx_logs", force: :cascade do |t|
    t.text     "log"
    t.integer  "resource_id"
    t.string   "resource_name"
    t.integer  "last_updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fort_token"
  end

  add_index "commonx_logs", ["fort_token"], name: "index_commonx_logs_on_fort_token"
  add_index "commonx_logs", ["resource_id", "resource_name"], name: "index_commonx_logs_on_resource_id_and_resource_name"
  add_index "commonx_logs", ["resource_id"], name: "index_commonx_logs_on_resource_id"
  add_index "commonx_logs", ["resource_name"], name: "index_commonx_logs_on_resource_name"

  create_table "commonx_misc_definitions", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",             default: true
    t.string   "for_which"
    t.text     "brief_note"
    t.integer  "last_updated_by_id"
    t.integer  "ranking_index"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fort_token"
  end

  add_index "commonx_misc_definitions", ["active", "for_which"], name: "index_commonx_misc_definitions_on_active_and_for_which"
  add_index "commonx_misc_definitions", ["active"], name: "index_commonx_misc_definitions_on_active"
  add_index "commonx_misc_definitions", ["for_which"], name: "index_commonx_misc_definitions_on_for_which"
  add_index "commonx_misc_definitions", ["fort_token"], name: "index_commonx_misc_definitions_on_fort_token"

  create_table "commonx_report_config_details", force: :cascade do |t|
    t.integer  "report_config_id"
    t.string   "display_as"
    t.text     "time_periods"
    t.string   "measure_choices",              default: "--- []\n"
    t.integer  "segment_ranges_choices"
    t.string   "segment_color_ranges_choices", default: "--- []\n"
    t.string   "x_axis_choices",               default: "--- []\n"
    t.string   "y_axis_choices",               default: "--- []\n"
    t.string   "sort_by_choices",              default: "--- []\n"
    t.string   "stack_by_choices",             default: "--- []\n"
    t.boolean  "stack_to_100_percent",         default: false
    t.boolean  "horizontal_bar",               default: false
    t.string   "value_choices",                default: "--- []\n"
    t.string   "sliced_by_choices",            default: "--- []\n"
    t.boolean  "cumulative",                   default: false
    t.integer  "last_updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dimension",                    default: "--- []\n"
    t.string   "columns",                      default: "--- []\n"
    t.string   "display_icon"
    t.string   "applicable_columns",           default: "--- []\n"
    t.string   "fort_token"
    t.text     "max_values_displayed"
    t.text     "view_template"
    t.text     "min_layout"
  end

  add_index "commonx_report_config_details", ["display_as"], name: "index_commonx_report_config_details_on_display_as"
  add_index "commonx_report_config_details", ["fort_token"], name: "index_commonx_report_config_details_on_fort_token"
  add_index "commonx_report_config_details", ["report_config_id"], name: "index_commonx_report_config_details_on_report_config_id"

  create_table "commonx_report_configs", force: :cascade do |t|
    t.string   "report_name"
    t.string   "resource_name"
    t.string   "display_as_choices"
    t.string   "measure_choices"
    t.string   "x_axis_choices"
    t.string   "y_axis_choices"
    t.string   "stack_by_choices"
    t.string   "sort_rows_by_choices"
    t.string   "icon_url"
    t.string   "fort_token"
    t.text     "data_series"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "id_in_cis"
  end

  add_index "commonx_report_configs", ["fort_token"], name: "index_commonx_report_configs_on_fort_token"
  add_index "commonx_report_configs", ["id_in_cis"], name: "index_commonx_report_configs_on_id_in_cis"
  add_index "commonx_report_configs", ["report_name"], name: "index_commonx_report_configs_on_report_name"
  add_index "commonx_report_configs", ["resource_name"], name: "index_commonx_report_configs_on_resource_name"

  create_table "commonx_search_stat_configs", force: :cascade do |t|
    t.string   "resource_name"
    t.text     "stat_function"
    t.text     "stat_summary_function"
    t.text     "labels_and_fields"
    t.string   "time_frame"
    t.string   "search_list_form"
    t.text     "search_where"
    t.text     "search_results_period_limit"
    t.integer  "last_updated_by_id"
    t.string   "brief_note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stat_header"
    t.text     "search_params"
    t.text     "search_summary_function"
    t.string   "fort_token"
  end

  add_index "commonx_search_stat_configs", ["fort_token"], name: "index_commonx_search_stat_configs_on_fort_token"
  add_index "commonx_search_stat_configs", ["resource_name"], name: "index_commonx_search_stat_configs_on_resource_name"

  create_table "commonx_search_stat_meta_configs", force: :cascade do |t|
    t.string   "resource_name"
    t.text     "stat_summary_function"
    t.text     "search_summary_function"
    t.text     "labels_and_fields"
    t.text     "time_frame"
    t.text     "stat_header"
    t.string   "fort_token"
    t.integer  "last_updated_by_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "commonx_search_stat_meta_configs", ["fort_token"], name: "index_commonx_search_stat_meta_configs_on_fort_token"
  add_index "commonx_search_stat_meta_configs", ["resource_name"], name: "index_commonx_search_stat_meta_configs_on_resource_name"

  create_table "messagingx_notifications", force: :cascade do |t|
    t.integer  "resource_id"
    t.string   "resource_string"
    t.string   "content"
    t.integer  "last_updated_by_id"
    t.string   "fort_token"
    t.integer  "urgency_scale"
    t.string   "user_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "messagingx_notifications", ["fort_token"], name: "index_messagingx_notifications_on_fort_token"
  add_index "messagingx_notifications", ["resource_string"], name: "index_messagingx_notifications_on_resource_string"
  add_index "messagingx_notifications", ["urgency_scale"], name: "index_messagingx_notifications_on_urgency_scale"
  add_index "messagingx_notifications", ["user_name"], name: "index_messagingx_notifications_on_user_name"

  create_table "produced_item_warehousex_checkouts", force: :cascade do |t|
    t.integer  "item_id"
    t.date     "out_date"
    t.decimal  "out_qty",            precision: 12, scale: 4
    t.integer  "last_updated_by_id"
    t.string   "wf_state"
    t.integer  "requested_by_id"
    t.integer  "checkout_by_id"
    t.text     "brief_note"
    t.text     "packaging_desp"
    t.decimal  "requested_qty",      precision: 12, scale: 4
    t.string   "fort_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "produced_item_warehousex_checkouts", ["fort_token"], name: "index_produced_item_warehousex_checkouts_on_fort_token"
  add_index "produced_item_warehousex_checkouts", ["item_id"], name: "index_produced_item_warehousex_checkouts_on_item_id"
  add_index "produced_item_warehousex_checkouts", ["out_date"], name: "index_produced_item_warehousex_checkouts_on_out_date"
  add_index "produced_item_warehousex_checkouts", ["wf_state"], name: "index_produced_item_warehousex_checkouts_on_wf_state"

  create_table "produced_item_warehousex_items", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "name"
    t.string   "spec"
    t.string   "part_num"
    t.string   "unit"
    t.date     "in_date"
    t.decimal  "in_qty",             precision: 12, scale: 4
    t.decimal  "stock_qty",          precision: 12, scale: 4
    t.integer  "last_updated_by_id"
    t.string   "storage_location"
    t.text     "brief_note"
    t.text     "packaging_desp"
    t.integer  "checkin_by_id"
    t.integer  "i_unit_id"
    t.integer  "resource_id"
    t.string   "resource_string"
    t.integer  "whs_id"
    t.string   "fort_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "produced_item_warehousex_items", ["checkin_by_id"], name: "index_produced_item_warehousex_items_on_checkin_by_id"
  add_index "produced_item_warehousex_items", ["fort_token"], name: "index_produced_item_warehousex_items_on_fort_token"
  add_index "produced_item_warehousex_items", ["name"], name: "index_produced_item_warehousex_items_on_name"
  add_index "produced_item_warehousex_items", ["order_id"], name: "index_produced_item_warehousex_items_on_order_id"
  add_index "produced_item_warehousex_items", ["part_num"], name: "index_produced_item_warehousex_items_on_part_num"
  add_index "produced_item_warehousex_items", ["spec"], name: "index_produced_item_warehousex_items_on_spec"
  add_index "produced_item_warehousex_items", ["whs_id"], name: "index_produced_item_warehousex_items_on_whs_id"

  create_table "production_orderx_operators", force: :cascade do |t|
    t.string   "name"
    t.integer  "hr_id"
    t.decimal  "hours_spent",        precision: 8, scale: 2
    t.integer  "last_updated_by_id"
    t.decimal  "hourly_rate",        precision: 8, scale: 2
    t.string   "fort_token"
    t.text     "brief_note"
    t.integer  "production_step_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "production_orderx_operators", ["fort_token"], name: "index_production_orderx_operators_on_fort_token"
  add_index "production_orderx_operators", ["hr_id"], name: "index_production_orderx_operators_on_hr_id"
  add_index "production_orderx_operators", ["name"], name: "index_production_orderx_operators_on_name"
  add_index "production_orderx_operators", ["production_step_id"], name: "index_production_orderx_operators_on_production_step_id"

  create_table "production_orderx_part_productions", force: :cascade do |t|
    t.integer  "part_id"
    t.integer  "order_id"
    t.string   "part_name"
    t.string   "spec"
    t.string   "part_num"
    t.string   "drawing_num"
    t.text     "requirement"
    t.date     "start_date"
    t.date     "finish_date"
    t.boolean  "void",                                        default: false
    t.integer  "last_updated_by_id"
    t.decimal  "qty",                precision: 12, scale: 2
    t.string   "unit"
    t.decimal  "qty_produced",       precision: 12, scale: 2
    t.boolean  "completed",                                   default: false
    t.boolean  "expedite",                                    default: false
    t.integer  "coordinator_id"
    t.date     "actual_finish_date"
    t.string   "wf_state"
    t.string   "batch_num"
    t.text     "brief_note"
    t.string   "aux_resource"
    t.string   "fort_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "production_orderx_part_productions", ["aux_resource"], name: "production_orderx_part_productions_aux"
  add_index "production_orderx_part_productions", ["batch_num"], name: "index_production_orderx_part_productions_on_batch_num"
  add_index "production_orderx_part_productions", ["completed"], name: "index_production_orderx_part_productions_on_completed"
  add_index "production_orderx_part_productions", ["coordinator_id"], name: "index_production_orderx_part_productions_on_coordinator_id"
  add_index "production_orderx_part_productions", ["drawing_num"], name: "index_production_orderx_part_productions_on_drawing_num"
  add_index "production_orderx_part_productions", ["expedite"], name: "index_production_orderx_part_productions_on_expedite"
  add_index "production_orderx_part_productions", ["fort_token"], name: "index_production_orderx_part_productions_on_fort_token"
  add_index "production_orderx_part_productions", ["order_id"], name: "index_production_orderx_part_productions_on_order_id"
  add_index "production_orderx_part_productions", ["part_id"], name: "index_production_orderx_part_productions_on_part_id"
  add_index "production_orderx_part_productions", ["part_name"], name: "index_production_orderx_part_productions_on_part_name"
  add_index "production_orderx_part_productions", ["part_num"], name: "index_production_orderx_part_productions_on_part_num"
  add_index "production_orderx_part_productions", ["spec"], name: "index_production_orderx_part_productions_on_spec"
  add_index "production_orderx_part_productions", ["void"], name: "index_production_orderx_part_productions_on_void"

  create_table "production_orderx_production_steps", force: :cascade do |t|
    t.integer  "part_production_id"
    t.integer  "step_status_id"
    t.decimal  "qty_in",             precision: 12, scale: 2
    t.decimal  "qty_out",            precision: 12, scale: 2
    t.text     "brief_note"
    t.integer  "last_updated_by_id"
    t.string   "ontime_indicator"
    t.datetime "start_time"
    t.datetime "finish_time"
    t.string   "fort_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "production_orderx_production_steps", ["fort_token"], name: "index_production_orderx_production_steps_on_fort_token"
  add_index "production_orderx_production_steps", ["ontime_indicator"], name: "index_production_orderx_production_steps_on_ontime_indicator"
  add_index "production_orderx_production_steps", ["part_production_id"], name: "index_production_orderx_production_steps_on_part_production_id"
  add_index "production_orderx_production_steps", ["step_status_id"], name: "index_production_orderx_production_steps_on_step_status_id"

end
