require 'rails_helper'

RSpec.describe Hospital do
  describe 'relationships' do
    it {should have_many :doctors}
  end

  describe 'instance methods' do
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

    it '#number_of_doctors' do
      expect(@grey_sloan.number_of_doctors).to eq(4)
    end

    it '#unique_universities' do
      expected = ["Harvard University", "Johns Hopkins University", "University of Pennsylvania"]
      expect(@grey_sloan.unique_universities).to eq(expected)
    end
  end
end
