class PatientsController < ApplicationController
  before_action :require_receptionist
  before_action :set_patient, only: %i[show edit update destroy]

  def index
    @patients = Patient.all
  end

  def show
    # @patient is already set from before_action
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to patients_path, notice: "Patient registered successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @patient.update(patient_params)
      redirect_to patients_path, notice: "Patient updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path, notice: "Patient deleted successfully."
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:name, :age, :disease, :address, :registered_on)
  end

  def require_receptionist
    unless logged_in? && current_user.role == "receptionist"
      redirect_to login_path, alert: "Access denied. Only receptionists can access this page."
    end
  end
end
