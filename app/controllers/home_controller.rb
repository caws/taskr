class HomeController < ApplicationController
  def index
    @statuses = Status.all
  end
end
