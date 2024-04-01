class CreateApplicationShelters < ActiveRecord::Migration[7.1]
  def change
    create_table :application_shelters do |t|
      t.references :adoption_application, null: false, foreign_key: true
      t.references :shelter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
