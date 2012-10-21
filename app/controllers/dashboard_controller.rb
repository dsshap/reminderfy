class DashboardController < ApplicationController
  layout 'application'

  def show
    @provider = current_provider
  end

end