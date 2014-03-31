require 'spec_helper'

module ProducedItemWarehousex
  describe Checkout do
 
    it "should be OK" do
      c = FactoryGirl.create(:produced_item_warehousex_checkout)
      c.should be_valid
    end
    
    it "should reject 0 item_id" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :item_id => 0)
      c.should_not be_valid
    end
    
    it "should allow 0 out qty" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :out_qty => 0)
      c.should be_valid
    end
    
    it "should reject nil in_out_date" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :out_date => nil)
      c.should_not be_valid
    end
    
    it "should reject nil out_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_checkout, :out_qty => nil)
      c.should_not be_valid
    end
    
  end
end
