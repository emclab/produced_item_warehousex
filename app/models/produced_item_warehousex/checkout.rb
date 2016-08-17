module ProducedItemWarehousex
  class Checkout < ActiveRecord::Base
    
    default_scope {where(fort_token: Thread.current[:fort_token])}
    
    attr_accessor :last_updated_by_name, :id_noupdate, :wf_comment, :item_id_noupdate, :stock_qty, :name
             
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :requested_by, :class_name => 'Authentify::User'
    belongs_to :checkout_by, :class_name => 'Authentify::User'
    belongs_to :item, :class_name => 'ProducedItemWarehousex::Item'
    
    validates :out_date, :out_qty, :fort_token, :presence => true
    validates :item_id, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
    #validates :out_qty,  :numericality => {:greater_than_or_equal_to => 0}   
    validates :out_qty,  :numericality => {:less_than_or_equal_to => :requested_qty}, :if => 'out_qty.present? && requested_qty.present?'   
    validates :requested_qty, :numericality => {:greater_than => 0}, :if => 'requested_qty.present?'   
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_checkout', self.fort_token, 'produced_item_warehousex')
      eval(wf) if wf.present?
    end
  end
end
