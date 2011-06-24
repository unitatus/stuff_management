require 'spec_helper'

describe "boxes/new.html.erb" do
  before(:each) do
    assign(:box, stub_model(Box).as_new_record)
  end

  it "renders new box form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => boxes_path, :method => "post" do
    end
  end
end
