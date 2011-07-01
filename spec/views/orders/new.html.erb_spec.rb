require 'spec_helper'

describe "orders/new.html.erb" do
  before(:each) do
    assign(:order, stub_model(Order,
      :cart_id => 1,
      :ip_address => "MyString"
    ).as_new_record)
  end

  it "renders new order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orders_path, :method => "post" do
      assert_select "input#order_cart_id", :name => "order[cart_id]"
      assert_select "input#order_ip_address", :name => "order[ip_address]"
    end
  end
end
