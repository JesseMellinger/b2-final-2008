require 'rails_helper'

RSpec.describe Patient do
  describe 'relationships' do
    it {should have_many :doctor_patients}
    it {should have_many(:doctors).through(:doctor_patients)}
  end

  describe 'class methods' do
    before :each do
      @patient_1 = Patient.create!(name: "Katie Bryce", age: 24)
      @patient_2 = Patient.create!(name: "Denny Duquette", age: 39)
      @patient_3 = Patient.create!(name: "Rebecca Pope", age: 32)
      @patient_4 = Patient.create!(name: "Zola Shepherd", age: 2)
    end

    it '.sorted_by_age' do
      expected = [@patient_2, @patient_3, @patient_1, @patient_4]
      expect(Patient.sorted_by_age).to eq(expected)
    end
  end
end
