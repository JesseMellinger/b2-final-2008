require 'rails_helper'

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
      visit(doctor_path(@doctor_grey))

      expect(page).to have_content("Name: #{@doctor_grey.name}")
      expect(page).to have_content("Specialty: #{@doctor_grey.specialty}")
      expect(page).to have_content("University: #{@doctor_grey.university}")
      expect(page).to have_content("Hospital: #{@doctor_grey.hospital.name}")

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

    it 'I see a button to remove a patient from that doctors caseload next to the patients name and when I click that button I am returned to the doctors show page and I no longer see the patients name listed' do
      visit(doctor_path(@doctor_grey))

      within("#patient-#{@patient_1.id}") do
        expect(page).to have_button("Remove Patient")
      end

      within("#patient-#{@patient_2.id}") do
        expect(page).to have_button("Remove Patient")
      end

      within("#patient-#{@patient_3.id}") do
        click_button("Remove Patient")
      end

      expect(current_path).to eq("/doctors/#{@doctor_grey.id}")

      expect(page).to have_selector("#patient-#{@patient_1.id}")
      expect(page).to have_selector("#patient-#{@patient_2.id}")

      expect(page).not_to have_selector("#patient-#{@patient_3.id}")
      expect(page).to_not have_content("Patient Name: #{@patient_3.name}")
    end
  end
end
