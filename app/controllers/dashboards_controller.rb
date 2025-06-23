class DashboardsController < ApplicationController
  def receptionist
    # Receptionist dashboard logic can be added later
  end

  def doctor
    @patients_per_day = Patient.group_by_day(:registered_on).count
    @total_patients = Patient.count
    @patients_today = Patient.where(registered_on: Date.today).count
    @patients_this_week = Patient.where(registered_on: 1.week.ago.beginning_of_day..Time.now.end_of_day).count

    @most_common_disease = Patient.group(:disease).order('count_id DESC').count(:id).first&.first

    @recent_patients = Patient.order(registered_on: :desc).limit(5)
    @patients_by_disease = Patient.group(:disease).count
    @last_10_patients = Patient.order(registered_on: :desc).limit(10)
  end
end
