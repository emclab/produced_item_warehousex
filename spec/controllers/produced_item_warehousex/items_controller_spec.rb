require 'rails_helper'

module ProducedItemWarehousex
  RSpec.describe ItemsController, type: :controller do
    routes {ProducedItemWarehousex::Engine.routes}
    before(:each) do
      expect(controller).to receive(:require_signin)
      expect(controller).to receive(:require_employee)
      
    end
    
    before(:each) do
      config_entry = FactoryGirl.create(:engine_config, :engine_name => 'rails_app', :engine_version => nil, :argument_name => 'SESSION_TIMEOUT_MINUTES', :argument_value => 30)
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @b = FactoryGirl.create(:production_orderx_part_production)
      
      session[:user_role_ids] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id).user_role_ids  
      session[:fort_token] = @u.fort_token
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns all items" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ProducedItemWarehousex::Item.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:produced_item_warehousex_item, :checkin_by_id => @u.id)
        q1 = FactoryGirl.create(:produced_item_warehousex_item, :checkin_by_id => @u.id, order_id: q.order_id + 1)
        get 'index'
        expect(assigns(:items)).to match_array( [q, q1])
      end
      
    end
  
    describe "GET 'new'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        get 'new', {order_id: @b.id}
        expect(response).to be_success
      end
    end
  
    describe "GET 'create'" do
      it "returns redirect with success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.attributes_for(:produced_item_warehousex_item, order_id: @b.id)
        get 'create', {:item => q}
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.attributes_for(:produced_item_warehousex_item, :in_qty => nil, order_id: @b.id)
        get 'create', {:item => q}
        expect(response).to render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:produced_item_warehousex_item, :checkin_by_id => @u.id, order_id: @b.id)
        get 'edit', {:id => q.id}
        expect(response).to be_success
      end
    end
  
    describe "GET 'update'" do
      it "should redirect successfully" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:produced_item_warehousex_item, :checkin_by_id => @u.id)
        get 'update', {:id => q.id, :item => {:in_qty => 20}}
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:produced_item_warehousex_item, :checkin_by_id => @u.id)
        get 'update', {:id => q.id, :item => {:in_qty => 0}}
        expect(response).to render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.checkin_by_id == session[:user_id]")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:produced_item_warehousex_item, :checkin_by_id => @u.id, order_id: @b.id)
        get 'show', {:id => q.id }
        expect(response).to be_success
      end
    end
  end
end
