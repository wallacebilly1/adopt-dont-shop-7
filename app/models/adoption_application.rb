class AdoptionApplication < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  after_initialize :set_defaults

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true

  def set_defaults
    status = "In Progress"
  end

  def pending
    update(status: "Pending")
  end
end
