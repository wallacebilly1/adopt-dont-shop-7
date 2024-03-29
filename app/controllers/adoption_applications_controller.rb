class AdoptionApplicationsController < ApplicationController
  def index; end

  def show
    @adoption_application = AdoptionApplication.find(params[:id])
  end
end
