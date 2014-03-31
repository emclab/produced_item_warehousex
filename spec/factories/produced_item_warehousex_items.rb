# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :produced_item_warehousex_item, :class => 'ProducedItemWarehousex::Item' do
    batch_id 1
    name 'a product 123'
    in_date "2014-03-27"
    in_qty 1
    stock_qty 1
    last_updated_by_id 1
    storage_location "MyString"
    brief_note "MyText"
    packaging_desp "MyText"
    checkin_by_id 1
  end
end
