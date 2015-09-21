require 'rails_helper'

module ProducedItemWarehousex
  RSpec.describe Checkout, type: :model do
 
    it "should be OK" do
      c = FactoryGirl.create(:produced_item_warehousex_checkout)
      expect(c).to be_valid
    end
    
    it "should reject 0 item_id" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :item_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should allow 0 out qty" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :out_qty => 0)
      expect(c).to be_valid
    end
    
    it "should reject nil in_out_date" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :out_date => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil out_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :out_qty => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject if requested_qty <= out_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :out_qty => 2, :requested_qty => 1)
      expect(c).not_to be_valid
    end
    
    it "should be OK if requested_qty == out_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :out_qty => 1, :requested_qty => 1)
      expect(c).to be_valid
    end
    
  end
end
