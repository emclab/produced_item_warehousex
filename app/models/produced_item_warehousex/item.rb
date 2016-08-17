module ProducedItemWarehousex
  class Item < ActiveRecord::Base
    
    default_scope {where(fort_token: Thread.current[:fort_token])}
    
    attr_accessor :order_id_noupdate, :checkin_by_name, :last_updated_by_name
                 
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :checkin_by, :class_name => 'Authentify::User'
    belongs_to :order, :class_name => ProducedItemWarehousex.order_class.to_s
    has_many :checkouts, :class_name => 'ProducedItemWarehousex::Checkout'
    belongs_to :whs, :class_name => 'Commonx::MiscDefinition'
    belongs_to :i_unit, :class_name => 'Commonx::MiscDefinition'

    validates :storage_location, :in_date, :in_qty, :fort_token, :presence => true
    validates :order_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'order_id.present?'
    validates :in_qty, :checkin_by_id, :numericality => {:greater_than => 0}
    validates :stock_qty, :numericality => {:less_than_or_equal_to => :in_qty}
    validates :stock_qty, :numericality => {:greater_than_or_equal_to => 0}
    validates :resource_id, :numericality => {:greater_than => 0}, :if => 'resource_id.present?'
    validates :whs_id, :numericality => {:greater_than => 0}, :if => 'whs_id.present?'
    validates :i_unit_id, :numericality => {:greater_than => 0}, :if => 'i_unit_id.present?'
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_item', self.fort_token, 'produced_item_warehousex')
      eval(wf) if wf.present?
    end
    
    def calculate_stock_qty
      qty = in_qty
      qty -= self.checkouts.sum("out_qty")
      return ((qty < 0) ? 0 : qty)
    end
  end
end
