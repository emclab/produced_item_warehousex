module ProducedItemWarehousex
  class Item < ActiveRecord::Base
    attr_accessor :batch_id_noupdate, :checkin_by_name, :last_updated_by_name
    attr_accessible :batch_id, :brief_note, :in_date, :in_qty, :stock_qty, :last_updated_by_id, :packaging_desp, :storage_location, :checkin_by_id, :name,
                    :as => :role_new
    attr_accessible :brief_note, :in_date, :in_qty, :stock_qty, :last_updated_by_id, :packaging_desp, :storage_location, :checkin_by_id, :name,
                    :batch_id_noupdate, :checkin_by_name, :last_updated_by_name,
                    :as => :role_update
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :checkin_by, :class_name => 'Authentify::User'
    belongs_to :batch, :class_name => ProducedItemWarehousex.batch_class.to_s
    has_many :checkouts, :class_name => 'ProducedItemWarehousex::Checkout'

    validates :storage_location, :in_date, :name, :presence => true
    validates :batch_id, presence: true, uniqueness: {message: I18n.t('One checkin for one batch only')} #only checkin once for one batch
    validates_numericality_of :in_qty, :batch_id, :checkin_by_id, :only_integer => true, :greater_than => 0
    validates_numericality_of :stock_qty, :less_than_or_equal_to => :in_qty
    validates :stock_qty, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  end
end
