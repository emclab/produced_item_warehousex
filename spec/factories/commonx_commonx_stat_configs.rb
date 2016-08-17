# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commonx_search_stat_config, :class => 'Commonx::SearchStatConfig' do
    resource_name "MyString"
    stat_function "MyText"
    stat_summary_function 'mystatSummaryFunction'
    labels_and_fields "MyText"
    stat_header "Dates, 'Payment Total'"
    search_where "MyText"
    search_list_form 'form_list'
    search_results_period_limit "MyText"
    fort_token '123456789'
  end
end