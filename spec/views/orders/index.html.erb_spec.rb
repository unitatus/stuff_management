require 'spec_helper'

describe "orders/index.html.erb" do
  before(:each) do
    assign(:orders, [
      stub_model(Order,
        :cart_id => 1,
        :ip_address => "Ip Address"
      ),
      stub_model(Order,
        :cart_id => 1,
        :ip_address => "Ip Address"
      )
    ])
  end

  it "renders a list of orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ip Address".to_s, :count => 2
  end
end
