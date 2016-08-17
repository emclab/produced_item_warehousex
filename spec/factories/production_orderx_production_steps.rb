# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :production_orderx_production_step, :class => 'ProductionOrderx::ProductionStep' do
    part_production_id 1
    step_status_id 1
    qty_in 1
    qty_out 1
    brief_note "MyText"
    #last_updated_by_id 1
    ontime_indicator "green"
    fort_token '123456789'
  end
end
