class ReportController < ApplicationController
before_filter :require_login

def index
@user = User.find(session[:user_id])
end


def projectReport
		puts "********************************Project Report******************************"
   		puts params.inspect
   		
   		@user = User.find(session[:user_id])
   		   
		timeRowArray = []
		hourTotals = []
		today = params[:today].to_date
		
		userTable = @user.time_tables
		
		if params[:view] == "weekly"
			startDate = today.beginning_of_week.to_s	
			endDate = today.end_of_week.to_s
			startTime = Time.parse(startDate).utc.to_i*1000
			endTime = Time.parse(endDate).utc.to_i*1000
			timeRowArray << { start: startTime, end: endTime}
			
			startDate.to_date.upto(endDate.to_date) do |date|
				hourTotals << userTable.getDayTotal(date)
			end
		end
		if params[:view] == "monthly"
			startDate = today.beginning_of_month
			endDate = today.end_of_month
		end
		if params[:view] == "yearly"
			startDate = today.beginning_of_year
			endDate = today.end_of_year
		end
		
		dateSpan = userTable.viewDate(startDate, endDate)
		totalHours = dateSpan.getTotal
		timeRow = dateSpan.alpha.group_by(&:project_id)
		
		timeRow.each do |key, value|
			timeInfo = []
			value.each do |v|
				date = v.date.to_s
				time = Time.parse(date).utc.to_i*1000
				timeInfo << {

				pDate: time,
				pHours: v.hours
				}
			end
			timeRowArray << {
				name: Project.find(key).name,
				info: timeInfo,
				}
			
		end
	
	
		
	timeRowArray << { totals: hourTotals}
			
	
		
			puts "Time Array"
			puts timeRowArray
		
	render :json => timeRowArray.to_json
		
	end	
	
def totals
	puts "********************************Totals******************************"
   		puts params.inspect
end
	

	
end
