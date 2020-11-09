class PatientsController < ApplicationController
  def destroy
    doctor = Doctor.find(params[:doctor_id])
    patient = doctor.find_patient(params[:id])

    patient.destroy

    redirect_to "/doctors/#{doctor.id}"
  end
end
