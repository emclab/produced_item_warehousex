require 'rails_helper'

RSpec.describe "LinkTests", type: :request do
  describe "GET /produced_item_warehousex_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link',
         'right-span#'         => '2', 
               'left-span#'         => '6', 
               'offset#'         => '2',
               'form-span#'         => '4'
        }
    before(:each) do
      FactoryGirl.create(:engine_config, :engine_name => 'rails_app', :engine_version => nil, :argument_name => 'enable_info_logger', :argument_value => 'true')
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
      @b1 = FactoryGirl.create(:production_orderx_part_production, :part_name => 'a new name', :spec => 'a new spec')
      #@i = FactoryGirl.create(:produced_item_warehousex_item, order_id: @b.id)
      #@i1 = FactoryGirl.create(:produced_item_warehousex_item, order_id: @b1.id)
      
      user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ProducedItemWarehousex::Item.order('created_at DESC')")
      user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'produced_item_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.checkin_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ProducedItemWarehousex::Checkout.order('created_at DESC')")
      user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'produced_item_warehousex_checkouts', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
    end
    it "works! for items(now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      q = FactoryGirl.create(:produced_item_warehousex_item, :checkin_by_id => @u.id, order_id: @b.id)
      
      visit produced_item_warehousex.items_path
      #save_and_open_page
      expect(page).to have_content('Warehouse Items')
      click_link 'Edit'
      expect(page).to have_content('Update Warehouse Item')
      #save_and_open_page
      visit produced_item_warehousex.items_path
      click_link q.id.to_s
      #save_and_open_page
      expect(page).to have_content('Warehouse Item Info')
      
      visit produced_item_warehousex.new_item_path(order_id: @b.id)
      #save_and_open_page
      expect(page).to have_content('New Warehouse Item')
    end
    
    it "works for checkout" do
      i = FactoryGirl.create(:produced_item_warehousex_item, order_id: @b.id)
      q = FactoryGirl.create(:produced_item_warehousex_checkout, :item_id => i.id)
      visit produced_item_warehousex.checkouts_path
      #save_and_open_page
      expect(page).to have_content('Warehouse Checkouts')
      click_link 'Edit'
      expect(page).to have_content('Update Warehouse Checkout')
           
      visit produced_item_warehousex.new_checkout_path(:item_id => i.id)
      #save_and_open_page
      expect(page).to have_content('New Warehouse Checkout')
      
      #
      visit produced_item_warehousex.checkouts_path(item_id: i.id)
      #save_and_open_page
      click_link 'New Checkout'
      expect(page).to have_content('New Warehouse Checkout')
      save_and_open_page
    end
  end
end
