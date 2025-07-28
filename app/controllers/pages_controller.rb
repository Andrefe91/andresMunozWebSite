class PagesController < ApplicationController
  def index
  end

  def projects
  end

  def tools
  end

  def contact
    @communication = Communication.new
  end
end
