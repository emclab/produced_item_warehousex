# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :produced_item_warehousex_checkout, :class => 'ProducedItemWarehousex::Checkout' do
    item_id 1
    out_date "2014-03-27"
    out_qty 1
    last_updated_by_id 1
    wf_state "MyString"
    requested_by_id 1
    checkout_by_id 1
    brief_note "MyText"
    packaging_desp "MyText"
  end
end
