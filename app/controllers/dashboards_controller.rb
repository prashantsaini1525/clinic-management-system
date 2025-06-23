class DashboardsController < ApplicationController
  def receptionist
    # Future logic for receptionist dashboard
  end

  def doctor
    # 1️⃣ Define the selected time range (fallback: 'all')
    selected_range = params[:time_range].presence || 'all'

    # 2️⃣ Filter logic based on time_range
    date_range = case selected_range
                 when 'today'
                   Date.today.beginning_of_day..Date.today.end_of_day
                 when 'week'
                   1.week.ago.beginning_of_day..Time.now.end_of_day
                 when 'month'
                   Date.today.beginning_of_month..Date.today.end_of_day
                 else
                   nil
                 end

    # 3️⃣ Base patients scope
    patients = Patient.all

    # Apply date filter if applicable
    patients = patients.where(registered_on: date_range) if date_range

    # 4️⃣ Search filter
    if params[:search].present?
      keyword = params[:search].strip.downcase
      patients = patients.where("LOWER(name) LIKE ? OR LOWER(disease) LIKE ?", "%#{keyword}%", "%#{keyword}%")
    end

    # 5️⃣ Dashboard statistics
    @total_patients       = patients.count
    @patients_today       = Patient.where(registered_on: Date.today.all_day).count
    @patients_this_week   = Patient.where(registered_on: 1.week.ago.beginning_of_day..Time.now.end_of_day).count
    @most_common_disease  = patients.group(:disease).order('count_id DESC').count(:id).first&.first

    # 6️⃣ Charts and patient data
    @patients_per_day     = patients.group_by_day(:registered_on).count
    @patients_by_disease  = patients.group(:disease).count
    @recent_patients      = patients.order(registered_on: :desc).limit(5)
    @last_10_patients     = patients.order(registered_on: :desc).limit(10)

    # 7️⃣ Send selected_range to view to highlight the right button
    @selected_range = selected_range
  end
end
