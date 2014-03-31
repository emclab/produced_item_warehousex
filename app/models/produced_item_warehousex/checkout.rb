module ProducedItemWarehousex
  class Checkout < ActiveRecord::Base
    attr_accessor :last_updated_by_name, :id_noupdate, :wf_comment, :item_id_noupdate
    
    attr_accessible :brief_note, :checkout_by_id, :item_id, :last_updated_by_id, :out_date, :out_qty, :packaging_desp, :requested_by_id, :wf_state,
                    :as => :role_new
    attr_accessible :brief_note, :checkout_by_id, :last_updated_by_id, :out_date, :out_qty, :packaging_desp, :requested_by_id, :wf_state,
                    :last_updated_by_name, :id_noupdate, :wf_comment, :item_id_noupdate, 
                    :as => :role_update
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :requested_by, :class_name => 'Authentify::User'
    belongs_to :checkout_by, :class_name => 'Authentify::User'
    belongs_to :item, :class_name => 'ProducedItemWarehousex::Item'
    
    validates :out_date, :out_qty, :presence => true
    validates_numericality_of :item_id, :only_integer => true, :greater_than => 0
    validates :out_qty,  :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  end
end
