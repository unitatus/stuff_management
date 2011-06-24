class AdminController < ApplicationController

  def home

  end

  def send_boxes

  end

  def send_boxes_user_search
    conditions = Hash.new()

    if (!params[:user][:id].empty?)
      conditions[:id] = params[:user][:id]
    end

    if (!params[:user][:first_name].empty?)
      conditions[:first_name] = params[:user][:first_name]
    end

    if (!params[:user][:last_name].empty?)
      conditions[:last_name] = params[:user][:last_name]
    end

    @found_users = User.all(:conditions => conditions)
  end
end
