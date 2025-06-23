class DashboardsController < ApplicationController
  def receptionist
    # Future logic for receptionist dashboard
  end

  def doctor
    # 1️⃣ Date Filter Logic
    case params[:time_range]
    when 'today'
      date_range = Date.today.beginning_of_day..Date.today.end_of_day
    when 'week'
      date_range = 1.week.ago.beginning_of_day..Time.now.end_of_day
    when 'month'
      date_range = 1.month.ago.beginning_of_day..Time.now.end_of_day
    else
      date_range = nil # Default = All time
    end

    # 2️⃣ Search Filter Logic
    patients = Patient.all
    if date_range
      patients = patients.where(registered_on: date_range)
    end

    if params[:search].present?
      search_term = "%#{params[:search].strip.downcase}%"
      patients = patients.where("LOWER(name) LIKE ? OR LOWER(disease) LIKE ?", search_term, search_term)
    end

    # 3️⃣ Dashboard Stats from Filtered Data
    @total_patients       = patients.count
    @patients_today       = Patient.where(registered_on: Date.today).count
    @patients_this_week   = Patient.where(registered_on: 1.week.ago.beginning_of_day..Time.now.end_of_day).count
    @most_common_disease  = patients.group(:disease).order('count_id DESC').count(:id).first&.first

    # 4️⃣ Charts and Lists
    @patients_per_day     = patients.group_by_day(:registered_on).count
    @patients_by_disease  = patients.group(:disease).count
    @recent_patients      = patients.order(registered_on: :desc).limit(5)
    @last_10_patients     = patients.order(registered_on: :desc).limit(10)
  end
end
