class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql(
      "SELECT * FROM shelters ORDER BY shelters.name DESC"
    )
    @pending_applications = ApplicationShelter.shelters_with_pending_applications
  end
end
