require "produced_item_warehousex/engine"

module ProducedItemWarehousex
  mattr_accessor :batch_class, :show_batch_path
  
  def self.batch_class
    @@batch_class.constantize
  end
    
end
