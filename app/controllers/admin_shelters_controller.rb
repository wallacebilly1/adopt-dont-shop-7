class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_name_desc
  end
end
