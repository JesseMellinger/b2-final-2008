require 'rails_helper'

# As a visitor
# When I visit a doctor's show page
# I see all of that doctor's information including:
#  - name
#  - specialty
#  - university where they got their doctorate
# And I see the name of the hospital where this doctor works
# And I see the names of all of the patients this doctor has

RSpec.describe 'Doctors Show Page' do
  describe 'as a visitor' do
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

    it 'I see all of that doctors information, the name of the hospital where the doctor works, and names of all the patients this doctor has' do
      visit("doctors/#{@doctor_grey.id}")

      expect(page).to have_content("Name: #{@doctor_grey.name}")
      expect(page).to have_content("Specialty: #{@doctor_grey.specialty}")
      expect(page).to have_content("University: #{@doctor_grey.university}")
      expect(page).to have_content("Hospital: #{@doctor_grey.hospital}")

      within("#patient-#{@patient_1.id}") do
        expect(page).to have_content("Patient Name: #{@patient_1.name}")
      end

      within("#patient-#{@patient_2.id}") do
        expect(page).to have_content("Patient Name: #{@patient_2.name}")
      end

      within("#patient-#{@patient_3.id}") do
        expect(page).to have_content("Patient Name: #{@patient_3.name}")
      end
    end
  end
end
