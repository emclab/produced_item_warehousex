# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :production_orderx_part_production, :class => 'ProductionOrderx::PartProduction' do
    part_name "MyString"
    batch_num "MyString"
    drawing_num "MyString"
    requirement "MyText"
    start_date "2014-11-11"
    finish_date "2014-11-11"
    void false
    #last_updated_by_id 1
    qty 1
    qty_produced 1
    completed false
    order_id 1
    expedite false
    coordinator_id 1
    actual_finish_date "2014-11-11"
    wf_state "MyString"
    fort_token '123456789'
  end
end
