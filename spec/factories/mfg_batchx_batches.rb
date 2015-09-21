# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mfg_batchx_batch, :class => 'MfgBatchx::Batch' do
    order_id 1
    last_updated_by_id 1
    qty 1
    rfq_id 1
    completed false
    start_date "2013-10-23"
    finish_date "2013-10-23"
    brief_note "MyText"
    void false
    qty_produced 1
    batch_status_id 1
    wf_state ''
    batch_num 'mydrawing1234'
  end
end
