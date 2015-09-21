module ProducedItemWarehousex
  class Item < ActiveRecord::Base
    attr_accessor :batch_id_noupdate, :checkin_by_name, :last_updated_by_name
                 
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :checkin_by, :class_name => 'Authentify::User'
    belongs_to :batch, :class_name => ProducedItemWarehousex.batch_class.to_s
    belongs_to :part, :class_name => ProducedItemWarehousex.part_class.to_s
    has_many :checkouts, :class_name => 'ProducedItemWarehousex::Checkout'

    validates :storage_location, :in_date, :in_qty, :presence => true
    validates :batch_id, presence: true, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'batch_id.present?'
    validates :part_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'part_id.present?'
    validates :in_qty, :checkin_by_id, :numericality => {:greater_than => 0}
    validates :stock_qty, :numericality => {:less_than_or_equal_to => :in_qty}
    validates :stock_qty, :numericality => {:greater_than_or_equal_to => 0}
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_item', 'produced_item_warehousex')
      eval(wf) if wf.present?
    end
    
    def calculate_stock_qty
      qty = in_qty
      qty -= self.checkouts.sum("out_qty")
      return ((qty < 0) ? 0 : qty)
    end
  end
end
