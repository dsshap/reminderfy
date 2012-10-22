class DashboardController < ApplicationController

  def show
    @provider = current_provider
    render layout: 'application_sidebar'
  end

  def my_plan
    @provider = current_provider
  end

  def clients
    @provider = current_provider
    render layout: 'application_sidebar'
  end

end