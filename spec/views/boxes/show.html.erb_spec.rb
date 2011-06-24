require 'spec_helper'

describe "boxes/show.html.erb" do
  before(:each) do
    @box = assign(:box, stub_model(Box))
  end

  it "renders attributes in <p>" do
    render
  end
end
