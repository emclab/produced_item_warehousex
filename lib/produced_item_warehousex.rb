require "produced_item_warehousex/engine"

module ProducedItemWarehousex
  mattr_accessor :order_class
  
  def self.order_class
    @@order_class.constantize
  end
    
end
