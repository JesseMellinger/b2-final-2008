require 'rails_helper'

# As a visitor
# When I visit a hospital's show page
# I see the hospital's name
# And I see the number of doctors that work at this hospital
# And I see a unique list of universities that this hospital's doctors attended

RSpec.describe 'Hospital Show Page' do
  describe 'as a visitor' do
    before :each do
      @grey_sloan = Hospital.create!(name: "Grey Sloan Memorial Hospital")
      @doctor_grey = @grey_sloan.doctors.create!(name: "Meredith Grey",
                                                 specialty: "General Surgery",
                                                 university: "Harvard University")
      @doctor_karev = @grey_sloan.doctors.create!(name: "Alex Karev",
                                                  specialty: "Pediatric Surgery",
                                                  university: "Johns Hopkins University")
      @doctor_bailey = @grey_sloan.doctors.create!(name: "Miranda Bailey",
                                                   specialty: "General Surgery",
                                                   university: "Harvard University")
      @doctor_shepherd = @grey_sloan.doctors.create!(name: "Derek McDreamy Shepherd",
                                                     specialty: "Attending Surgeon",
                                                     university: "University of Pennsylvania")
    end

    it 'I see the name of the hospital, the number of doctors that work at the hospital, and a unique list of universities attended by the doctors of the hospital' do
      visit(hospital_path(@grey_sloan))

      expect(page).to have_content("Name: #{@grey_sloan.name}")
      expect(page).to have_content("Number of doctors: #{@grey_sloan.number_of_doctors}")

      within("#unique-universities") do
        expect(page).to have_content("Name: Harvard University")
        expect(page).to have_content("Name: Johns Hopkins University")
        expect(page).to have_content("Name: University of Pennsylvania")
      end
    end
  end
end
