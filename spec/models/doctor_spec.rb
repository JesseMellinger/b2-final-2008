require 'rails_helper'

RSpec.describe Doctor do
  describe 'relationships' do
    it {should belong_to :hospital}
    it {should have_many :doctor_patients}
    it {should have_many(:patients).through(:doctor_patients)}
  end

  describe 'instance methods' do
    before :each do
      @grey_sloan = Hospital.create!(name: "Grey Sloan Memorial Hospital")
      @doctor_grey = @grey_sloan.doctors.create!(name: "Meredith Grey",
                                                 specialty: "General Surgery",
                                                 university: "Harvard University")
      @patient_1 = Patient.create!(name: "Katie Bryce", age: 24)
      @patient_2 = Patient.create!(name: "Denny Duquette", age: 39)
      @patient_3 = Patient.create!(name: "Rebecca Pope", age: 32)
      @doctor_patient_1 = @doctor_grey.doctor_patients.create!(patient_id: @patient_1.id)
      @doctor_patient_2 = @doctor_grey.doctor_patients.create!(patient_id: @patient_2.id)
      @doctor_patient_3 = @doctor_grey.doctor_patients.create!(patient_id: @patient_3.id)
    end

    it '#find_patient' do
      expect(@doctor_grey.find_patient(@patient_1.id)).to eq(@doctor_patient_1)
    end
  end
end
