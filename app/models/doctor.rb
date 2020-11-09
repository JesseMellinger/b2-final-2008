class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients

  def find_patient(patient_id)
    doctor_patients.find(patient_id)
  end
end
