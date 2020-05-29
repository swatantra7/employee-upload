class PatientsController < ApplicationController

  def index
    @patients = Patient.all
    if params[:search_query].present?
      @patients = @patients.basic_search(params[:search_query])
    end
  end

  def new
    @patient = Patient.new
  end

  def create
    require "csv"
    @success=[]
    @errors=[]
    CSV.foreach(patient_params[:patient_file].tempfile, {:headers=>:first_row, :encoding=> "iso-8859-1:utf-8"}) do |row|
      patient_name = row["name"]&.strip
      patient_date = Date.parse(row["date"]&.strip)
      patient_number = row["number"]&.strip&.to_i
      description = row["description"]
      patient = Patient.new(
        name: patient_name,
        date: patient_date,
        number: patient_number,
        description: description,
      )
      if patient.save
        @success << {patient_name: row["name"], message: ["success"]}
      else
        @errors << {patient_name: row["name"], message: patient.errors.full_messages.join(",")}
      end
    end
  end

  private

  def patient_params
    params.require(:patient).permit(
      :patient_file
    )
  end

end
