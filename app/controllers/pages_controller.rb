class PagesController < ApplicationController
  def about
    @hide_side_nav = true
  end

  def index
    @hide_side_nav = true
  end

  def login
    @hide_side_nav = true
  end

  def dashboard
    @hide_side_nav = true
  end
end
