require "produced_item_warehousex/engine"

module ProducedItemWarehousex
  mattr_accessor :batch_class, :part_class
  
  def self.batch_class
    @@batch_class.constantize
  end
    
  def self.part_class
    @@part_class.constantize
  end
end
