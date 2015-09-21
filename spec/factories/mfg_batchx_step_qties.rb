# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mfg_batchx_step_qty, :class => 'MfgBatchx::StepQty' do
    batch_id 1
    batch_status_id 1
    ontime_indicator 'green'
    qty_in 1
    qty_out 1
    brief_note "MyText"
  end
end
