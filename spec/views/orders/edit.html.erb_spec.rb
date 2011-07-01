require 'spec_helper'

describe "orders/edit.html.erb" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :cart_id => 1,
      :ip_address => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orders_path(@order), :method => "post" do
      assert_select "input#order_cart_id", :name => "order[cart_id]"
      assert_select "input#order_ip_address", :name => "order[ip_address]"
    end
  end
end
