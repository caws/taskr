class HomeController < ApplicationController
  def index
    @statuses = Status.all
  end

  def about

  end
end
