class AddStatusToApplicationPets < ActiveRecord::Migration[7.1]
  def change
    add_column :application_pets, :status, :string
  end
end
