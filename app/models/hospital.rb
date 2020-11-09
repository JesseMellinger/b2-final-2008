class Hospital < ApplicationRecord
  has_many :doctors

  def number_of_doctors
    doctors.count
  end

  def unique_universities
    doctors.distinct
           .pluck(:university)
  end
end
