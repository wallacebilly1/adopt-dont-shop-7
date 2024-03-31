# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
adoption_application = AdoptionApplication.create!(
  name: "Billy Neilson",
  street_address: "123 Main St",
  city: "Denver",
  state: "CO",
  zip_code: "80210",
  description: "I like doggos",
  status: "Pending"
)
shelter = Shelter.create(
  name: "Aurora shelter",
  city: "Aurora, CO",
  foster_program: false,
  rank: 9
)
pet1 = Pet.create(
  adoptable: true,
  age: 1,
  breed: "sphynx",
  name: "Lucille Bald",
  shelter_id: shelter.id
)
pet2 = Pet.create(
  adoptable: true,
  age: 3,
  breed: "doberman",
  name: "Lobster",
  shelter_id: shelter.id
)
ApplicationPet.create!(
  pet_id: pet1.id,
  adoption_application_id: adoption_application.id
)
ApplicationPet.create!(
  pet_id: pet2.id,
  adoption_application_id: adoption_application.id
)
