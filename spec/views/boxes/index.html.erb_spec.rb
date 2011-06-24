require 'spec_helper'

describe "boxes/index.html.erb" do
  before(:each) do
    assign(:boxes, [
      stub_model(Box),
      stub_model(Box)
    ])
  end

  it "renders a list of boxes" do
    render
  end
end
