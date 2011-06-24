require "spec_helper"

describe BoxesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/boxes" }.should route_to(:controller => "boxes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/boxes/new" }.should route_to(:controller => "boxes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/boxes/1" }.should route_to(:controller => "boxes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/boxes/1/edit" }.should route_to(:controller => "boxes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/boxes" }.should route_to(:controller => "boxes", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/boxes/1" }.should route_to(:controller => "boxes", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/boxes/1" }.should route_to(:controller => "boxes", :action => "destroy", :id => "1")
    end

  end
end
