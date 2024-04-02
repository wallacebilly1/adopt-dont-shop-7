class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_name_desc
    @shelters_with_pending = Shelter.shelters_with_pending_applications
  end
end
