require_dependency "produced_item_warehousex/application_controller"

module ProducedItemWarehousex
  class CheckoutsController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record
    
    def index
      @title = t('Warehouse Items')
      @checkouts = params[:produced_item_warehousex_checkouts][:model_ar_r]
      @checkouts = @checkouts.where(:item_id => @item.id) if @item
      @checkouts = @checkouts.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('checkout_index_view', 'produced_item_warehousex')
    end
  
    def new
      @title = t('New Warehouse Item')
      @checkout = ProducedItemWarehousex::Checkout.new()
      @erb_code = find_config_const('checkout_new_view', 'produced_item_warehousex')
    end
  
    def create
      @checkout = ProducedItemWarehousex::Checkout.new(params[:checkout], :as => :role_new)
      @checkout.last_updated_by_id = session[:user_id]
      @checkout.requested_by_id = session[:user_id]
      @checkout.transaction do  #need to deduct the qty of checkout from the item.stock_qty
        @item.stock_qty -= params[:checkout][:out_qty].to_i
        if @item.stock_qty >= 0 && @checkout.save && @item.save
          redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
        else
          @item = ProducedItemWarehousex::Item.find_by_id(params[:checkout][:item_id]) if params[:checkout].present? && params[:checkout][:item_id].present?
          flash[:notice] = t('Data Error. Not Saved!')
          render 'new'
        end
      end 
    end
  
    def edit
      @title = t('Update Warehouse Item')
      @checkout = ProducedItemWarehousex::Checkout.find_by_id(params[:id])
      @erb_code = find_config_const('checkout_edit_view', 'produced_item_warehousex')
    end
  
    def update
      @checkout = ProducedItemWarehousex::Checkout.find_by_id(params[:id])
      @checkout.last_updated_by_id = session[:user_id]
      if @checkout.update_attributes(params[:checkout], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
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
  end
end
