require_dependency "produced_item_warehousex/application_controller"

module ProducedItemWarehousex
  class ItemsController < ApplicationController
    before_action :require_employee
    before_action :load_record
    
    def index
      @title = t('Warehouse Items')
      @items = params[:produced_item_warehousex_items][:model_ar_r]
      @items = @items.where(batch_id: @batch.id) if @batch
      @items = @items.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('item_index_view', 'produced_item_warehousex')
    end
  
    def new
      @title = t('New Warehouse Item')
      @item = ProducedItemWarehousex::Item.new()
      @erb_code = find_config_const('item_new_view', 'produced_item_warehousex')
    end
  
    def create
      @item = ProducedItemWarehousex::Item.new(new_params)
      @item.last_updated_by_id = session[:user_id]
      @item.checkin_by_id = session[:user_id]
      @item.stock_qty = params[:item][:in_qty]
      if @item.save
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
      else
        @name = params[:item][:name].strip if params[:item][:name].present?
        @qty = params[:item][:qty] if params[:item][:qty].present?
        @batch = ProducedItemWarehousex.batch_class.find_by_id(params[:item][:batch_id]) if params[:item][:batch_id].present?
        @erb_code = find_config_const('item_new_view', 'produced_item_warehousex')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Warehouse Item')
      @item = ProducedItemWarehousex::Item.find_by_id(params[:id])
      @erb_code = find_config_const('item_edit_view', 'produced_item_warehousex')
    end
  
    def update
      @item = ProducedItemWarehousex::Item.find_by_id(params[:id])
      @item.last_updated_by_id = session[:user_id]
      if @item.update_attributes(edit_params)
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      else
        @name = ProducedItemWarehousex::Item.find_by_id(params[:id]).name
        @batch = ProducedItemWarehousex.batch_class.find_by_id(@item.batch_id)
        @erb_code = find_config_const('item_edit_view', 'produced_item_warehousex')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Warehouse Item Info')
      @item = ProducedItemWarehousex::Item.find_by_id(params[:id])
      @erb_code = find_config_const('item_show_view', 'produced_item_warehousex')
    end
    
    protected
    def load_record
      @name = params[:name].strip if params[:name].present?
      @name = params[:item][:name].strip if params[:item].present? && params[:item][:name].present?
      @qty = params[:qty] if params[:qty].present?
      @batch = ProducedItemWarehousex.batch_class.find_by_id(params[:batch_id]) if params[:batch_id].present?
      @batch = ProducedItemWarehousex.batch_class.find_by_id(ProducedItemWarehousex::Item.find_by_id(params[:id]).batch_id) if params[:id].present?
    end
    
    private
    
    def new_params
      params.require(:item).permit(:batch_id, :brief_note, :in_date, :in_qty, :stock_qty, :last_updated_by_id, :packaging_desp, :storage_location, :checkin_by_id, :name,
                                   :part_id)
    end
    
    def edit_params
      params.require(:item).permit(:brief_note, :in_date, :in_qty, :stock_qty, :last_updated_by_id, :packaging_desp, :storage_location, :checkin_by_id, :name, :part_id)
    end
    
  end
end
