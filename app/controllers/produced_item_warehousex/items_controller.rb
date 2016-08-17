require_dependency "produced_item_warehousex/application_controller"

module ProducedItemWarehousex
  class ItemsController < ApplicationController
    before_action :require_employee
    before_action :load_record
    after_action :info_logger, :except => [:new, :edit, :event_action_result, :wf_edit_result, :search_results, :stats_results, :acct_summary_result]
    
    def index
      @title = t('Warehouse Items')
      @items = params[:produced_item_warehousex_items][:model_ar_r]
      @items = @items.where(batch_id: @order.id) if @order
      @items = @items.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('item_index_view', session[:fort_token], 'produced_item_warehousex')
    end
  
    def new
      @title = t('New Warehouse Item')
      @item = ProducedItemWarehousex::Item.new()
      @erb_code = find_config_const('item_new_view', session[:fort_token], 'produced_item_warehousex')
    end
  
    def create
      @item = ProducedItemWarehousex::Item.new(new_params)
      @item.last_updated_by_id = session[:user_id]
      @item.resource_id = session[:resource_id] if session[:resource_id].present?
      @item.resource_string = session[:resource_string] if session[:resource_string].present?
      @item.fort_token = session[:fort_token]
      @item.checkin_by_id = session[:user_id]
      @item.stock_qty = params[:item][:in_qty]
      if @item.save
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
      else
        @name = params[:item][:name].strip if params[:item][:name].present?
        @qty = params[:item][:qty] if params[:item][:qty].present?
        @order = ProducedItemWarehousex.order_class.find_by_id(params[:item][:order_id]) if params[:item][:order_id].present?
        @erb_code = find_config_const('item_new_view', session[:fort_token], 'produced_item_warehousex')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Warehouse Item')
      @item = ProducedItemWarehousex::Item.find_by_id(params[:id])
      @erb_code = find_config_const('item_edit_view', session[:fort_token], 'produced_item_warehousex')
    end
  
    def update
      @item = ProducedItemWarehousex::Item.find_by_id(params[:id])
      @item.last_updated_by_id = session[:user_id]
      if @item.update_attributes(edit_params)
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      else
        @name = ProducedItemWarehousex::Item.find_by_id(params[:id]).name
        @order = ProducedItemWarehousex.order_class.find_by_id(@item.order_id)
        @erb_code = find_config_const('item_edit_view', session[:fort_token], 'produced_item_warehousex')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Warehouse Item Info')
      @item = ProducedItemWarehousex::Item.find_by_id(params[:id])
      @erb_code = find_config_const('item_show_view', session[:fort_token], 'produced_item_warehousex')
    end
    
    protected
    def load_record
      @name = params[:name].strip if params[:name].present?
      @name = params[:item][:name].strip if params[:item].present? && params[:item][:name].present?
      @qty = params[:qty] if params[:qty].present?
      @order = ProducedItemWarehousex.order_class.find_by_id(params[:order_id]) if params[:order_id].present?
      @order = ProducedItemWarehousex.order_class.find_by_id(ProducedItemWarehousex::Item.find_by_id(params[:id]).order_id) if params[:id].present?
    end
    
    private
    
    def new_params
      params.require(:item).permit(:order_id, :brief_note, :in_date, :in_qty, :stock_qty, :last_updated_by_id, :packaging_desp, :storage_location, :checkin_by_id, :name,
                                   :resource_id, :resource_string)
    end
    
    def edit_params
      params.require(:item).permit(:brief_note, :in_date, :in_qty, :stock_qty, :last_updated_by_id, :packaging_desp, :storage_location, :checkin_by_id, :name)
    end
    
  end
end
