require_dependency "produced_item_warehousex/application_controller"

module ProducedItemWarehousex
  class CheckoutsController < ApplicationController
    before_action :require_employee
    before_action :load_parent_record
    after_action :info_logger, :except => [:new, :edit, :event_action_result, :wf_edit_result, :search_results, :stats_results, :acct_summary_result]
    
    def index
      @title = t('Warehouse Checkouts')
      @checkouts = params[:produced_item_warehousex_checkouts][:model_ar_r]
      @checkouts = @checkouts.where(:item_id => @item.id) if @item
      @checkouts = @checkouts.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('checkout_index_view', session[:fort_token], 'produced_item_warehousex')
    end
  
    def new
      @title = t('New Warehouse Checkout')
      @checkout = ProducedItemWarehousex::Checkout.new()
      @erb_code = find_config_const('checkout_new_view', session[:fort_token], 'produced_item_warehousex')
    end
  
    def create
      @checkout = ProducedItemWarehousex::Checkout.new(new_params)
      @checkout.last_updated_by_id = session[:user_id]
      @checkout.fort_token = session[:fort_token]
      @checkout.requested_by_id = session[:user_id]
      @checkout.transaction do  #need to deduct the qty of checkout from the item.stock_qty
        @item.stock_qty -= params[:checkout][:out_qty].to_i
        if @item.stock_qty >= 0 && @checkout.save && @item.save
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
        else
          @item = ProducedItemWarehousex::Item.find_by_id(params[:checkout][:item_id]) if params[:checkout].present? && params[:checkout][:item_id].present?
          @erb_code = find_config_const('checkout_new_view', session[:fort_token], 'produced_item_warehousex')
          flash[:notice] = t('Data Error. Not Saved!')
          render 'new'
        end
      end 
    end
  
    def edit
      @title = t('Update Warehouse Checkout')
      @checkout = ProducedItemWarehousex::Checkout.find_by_id(params[:id])
      @erb_code = find_config_const('checkout_edit_view', session[:fort_token], 'produced_item_warehousex')
    end
  
    def update
      @checkout = ProducedItemWarehousex::Checkout.find_by_id(params[:id])
      @checkout.last_updated_by_id = session[:user_id]
      if @checkout.update_attributes(edit_params)
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('checkout_edit_view', 'produced_item_warehousex')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end

=begin  
    def show
      @title = t('Warehouse Item Info')
      @checkout = ItemCheckoutx::Checkout.find_by_id(params[:id])
      @erb_code = find_config_const('checkout_show_view', 'item_checkoutx_checkouts')
    end
=end
    protected
    def load_parent_record
      @item = ProducedItemWarehousex::Item.find_by_id(params[:checkout][:item_id]) if params[:checkout].present? && params[:checkout][:item_id].present?
      @item = ProducedItemWarehousex::Item.find_by_id(params[:item_id]) if params[:item_id].present?
      @item = ProducedItemWarehousex::Item.find_by_id(ProducedItemWarehousex::Checkout.find_by_id(params[:id]).item_id) if params[:id].present?
    end
    
    private
    
    def new_params
      params.require(:checkout).permit(:brief_note, :checkout_by_id, :item_id, :last_updated_by_id, :out_date, :out_qty, :packaging_desp, :requested_by_id, :wf_state)
    end
    
    def edit_params
      params.require(:checkout).permit(:brief_note, :checkout_by_id, :last_updated_by_id, :out_date, :out_qty, :packaging_desp, :requested_by_id, :wf_state)
    end
  end
end
