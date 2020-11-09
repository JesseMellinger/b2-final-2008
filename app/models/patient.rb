class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.sorted_by_age
    order("age DESC")
  end
end
