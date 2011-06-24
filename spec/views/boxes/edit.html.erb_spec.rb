require 'spec_helper'

describe "boxes/edit.html.erb" do
  before(:each) do
    @box = assign(:box, stub_model(Box))
  end

  it "renders the edit box form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => boxes_path(@box), :method => "post" do
    end
  end
end
