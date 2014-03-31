require 'spec_helper'

module ProducedItemWarehousex
  describe Item do
    it "should be OK" do
      c = FactoryGirl.create(:produced_item_warehousex_item)
      c.should be_valid
    end
    
    it "should reject 0 qty" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :in_qty => 0)
      c.should_not be_valid
    end
    
    it "should reject nil in_date" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :in_date => nil)
      c.should_not be_valid
    end
    
    it "should reject nil storage_location" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :storage_location => nil)
      c.should_not be_valid
    end
    
    it "should reject if stock_qty > in_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :in_qty => 1, :stock_qty => 2)
      c.should_not be_valid
    end
    
    it "should be OK if stock_qty == in_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :in_qty => 1, :stock_qty => 1)
      c.should be_valid
    end
    
    it "should reject nil stock_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :stock_qty => nil)
      c.should_not be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :name => nil)
      c.should_not be_valid
    end
    
    it "should have unique batch#" do
      c = FactoryGirl.create(:produced_item_warehousex_item, :batch_id => 1)
      c1 = FactoryGirl.build(:produced_item_warehousex_item, :batch_id => 1)
      c1.should_not be_valid
    end
  end
end
