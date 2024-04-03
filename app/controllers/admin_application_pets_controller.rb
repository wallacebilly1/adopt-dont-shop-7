class AdminApplicationPetsController < ApplicationController
  def update
    application_pet = ApplicationPet.find(params[:id])

    application_pet.update(status: params[:status])

    redirect_to(
      "/admin/adoption_applications/#{params[:adoption_application_id]}"
    )
  end
end
