class PatientsController < ApplicationController
  def index
    @patients = Patient.sorted_by_age
  end
  def destroy
    doctor = Doctor.find(params[:doctor_id])
    patient = doctor.find_patient(params[:id])

    patient.destroy

    redirect_to "/doctors/#{doctor.id}"
  end
end
