require 'rails_helper'

module ProducedItemWarehousex
  RSpec.describe Item, type: :model do
    it "should be OK" do
      c = FactoryGirl.create(:produced_item_warehousex_item)
      expect(c).to be_valid
    end
    
    it "should reject 0 qty" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :in_qty => 0)
      expect(c).not_to be_valid
    end
    
    it "should reject 0 resource_id" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :resource_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should reject 0 whs_id" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :whs_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should reject 0 i_unit_id" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :i_unit_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should reject nil in_date" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :in_date => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil fort_token" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :fort_token => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil storage_location" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :storage_location => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject if stock_qty > in_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :in_qty => 1, :stock_qty => 2)
      expect(c).not_to be_valid
    end
    
    it "should be OK if stock_qty == in_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :in_qty => 1, :stock_qty => 1)
      expect(c).to be_valid
    end
    
    it "should reject nil stock_qty" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :stock_qty => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:produced_item_warehousex_item, :name => nil)
      expect(c).to be_valid
    end
    
    it "should require no unique batch#" do
      c = FactoryGirl.create(:produced_item_warehousex_item, :order_id => 1)
      c1 = FactoryGirl.build(:produced_item_warehousex_item, :order_id => 1)
      expect(c1).to be_valid
    end
    
    it "should calculate right stock qty" do
      Thread.current[:fort_token] =
      c = FactoryGirl.create(:produced_item_warehousex_item, :order_id => 1, :in_qty => 20, :stock_qty => 20)
      d = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => c.id, :out_qty => 10)
      Thread.current[:fort_token] = c.fort_token
      expect(c.calculate_stock_qty).to eq(10)
    end
    
    it "should reject if out_qty > stock_qty" do 
      c = FactoryGirl.create(:produced_item_warehousex_item, :order_id => 1, :in_qty => 20, :stock_qty => 20)
      d = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => c.id, :out_qty => 21)
      Thread.current[:fort_token] = c.fort_token
      expect(c.calculate_stock_qty).to eq(0)
    end
  end
end
