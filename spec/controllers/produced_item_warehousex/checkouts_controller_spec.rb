require 'spec_helper'

module ProducedItemWarehousex
  describe CheckoutsController do
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      
    end
    
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])      
      @b = FactoryGirl.create(:mfg_batchx_batch)
      @b1 = FactoryGirl.create(:mfg_batchx_batch)
      @i = FactoryGirl.create(:produced_item_warehousex_item, batch_id: @b.id)
      @i1 = FactoryGirl.create(:produced_item_warehousex_item, batch_id: @b1.id)
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns all quotes" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ProducedItemWarehousex::Checkout.scoped.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => @i1.id)
        get 'index', {:use_route => :produced_item_warehousex}
        assigns(:checkouts).should =~ [q, q1]
      end
      
      it "should only return the quotes which belongs to the quote task" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ProducedItemWarehousex::Checkout.scoped.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => @i.id)
        q1 = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => @i1.id)
        get 'index', {:use_route => :produced_item_warehousex, :item_id => @i1.id}
        assigns(:checkouts).should =~ [q1]
      end
    end
  
    describe "GET 'new'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new', {:use_route => :produced_item_warehousex, :item_id => @i.id}
        response.should be_success
      end
    end
  
    describe "GET 'create'" do
      it "returns redirect with success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.attributes_for(:produced_item_warehousex_checkout, :item_id => @i1.id)
        get 'create', {:use_route => :produced_item_warehousex, :item_id => @i1.id, :checkout => q}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.attributes_for(:produced_item_warehousex_checkout, :item_id => @i1.id, :out_qty => nil)
        get 'create', {:use_route => :produced_item_warehousex, :item_id => @i1.id, :checkout => q}
        response.should render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'edit', {:use_route => :produced_item_warehousex, :id => q.id}
        response.should be_success
      end
    end
  
    describe "GET 'update'" do
      it "should redirect successfully" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'update', {:use_route => :produced_item_warehousex, :id => q.id, :checkout => {:out_qty => 20}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => @i1.id, :last_updated_by_id => @u.id)
        get 'update', {:use_route => :produced_item_warehousex, :id => q.id, :checkout => {:out_date => nil}}
        response.should render_template('edit')
      end
    end

=begin  
    describe "GET 'show'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.checkout_by_id == session[:user_id]")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => @i1.id, :checkout_by_id => @u.id, :last_updated_by_id => @u.id)
        get 'show', {:use_route => :produced_item_warehousex, :id => q.id }
        response.should be_success
      end
    end
=end
  end
end
