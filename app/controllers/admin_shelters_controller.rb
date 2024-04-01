class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql(
      "SELECT * FROM shelters ORDER BY shelters.name DESC"
    )
    @pending_applications = Shelter.pending_applications
  end
end
