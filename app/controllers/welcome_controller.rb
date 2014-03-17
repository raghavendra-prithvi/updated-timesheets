class WelcomeController < ApplicationController
  before_filter :require_login

  def index
    today = Date.today
    @todayRecs = TimeTable.where(:date => today,:user_id => session[:user_id])
  
  end

  def weekFunc
  end
  
  def saveDayTime
    puts "********************************DAY TIME******************************"
    puts params.inspect
    if params[:today]
      if params[:id].nil? || params[:id].empty?
        time = TimeTable.new
      else
        time = TimeTable.find(params[:id])
      end
      today = Date.strptime(params[:today], '%m/%d/%Y')
     
      time.user_id = session[:user_id]
      time.project_id = params[:project]
      time.date = today
      time.hours = params[:hours]
      time.save
    end
    data = {}
    data[:id] = time.id
    data[:msg] = "saved Successfully"
    render :json => data.to_json
  end



  def saveTime
    puts "************************tst******************"
    puts params.inspect
    if params[:hiddenMonday]
      day = Date.strptime(params[:hiddenMonday], '%m/%d/%Y') 
      time = TimeTable.new
      time.user_id = session[:user_id]
      time.project_id = params[:project]
      time.date = day
      time.hours = params[:monday]
      time.save
    end
    if params[:hiddenTuesday]
      day = Date.strptime(params[:hiddenTuesday], '%m/%d/%Y')	
      time = TimeTable.new
      time.user_id = session[:user_id]
      time.project_id = params[:project]
      time.date = day
      time.hours = params[:tuesday]
      time.save
    end
    if params[:wednesdayHidden]
      day = Date.strptime(params[:wednesdayHidden], '%m/%d/%Y')
      time = TimeTable.new
      time.user_id = session[:user_id]
      time.project_id = params[:project]
      time.date = day
      time.hours = params[:wednesday]
      time.save
    end
    if params[:thursdayHidden]
      day = Date.strptime(params[:thursdayHidden], '%m/%d/%Y')
      time = TimeTable.new
      time.user_id = session[:user_id]
      time.project_id = params[:project]
      time.date = day
      time.hours = params[:thursday]
      time.save
    end
    if params[:fridayHidden]
      day = Date.strptime(params[:fridayHidden], '%m/%d/%Y')
      time = TimeTable.new
      time.user_id = session[:user_id]
      time.project_id = params[:project]
      time.date = day
      time.hours = params[:friday]
      time.save
    end
    if params[:saturdayHidden]
      day = Date.strptime(params[:saturdayHidden], '%m/%d/%Y')
      time = TimeTable.new
      time.user_id = session[:user_id]
      time.project_id = params[:project]
      time.date = day
      time.hours = params[:saturday]
      time.save
    end
    if params[:sundayHidden]
      day = Date.strptime(params[:sundayHidden], '%m/%d/%Y')
      time = TimeTable.new
      time.user_id = session[:user_id]
      time.project_id = params[:project]
      time.date = day
      time.hours = params[:sunday]
      time.save
    end
    render :text => "saved successfully"
  end

  def loadToDay
    puts "-p-a-r-a-m-s---"
    puts params.inspect
    puts "***************-*-*"
    today = Date.strptime(params[:toDay], '%m/%d/%Y')
    @todayRecs = TimeTable.where(:date => today, :user_id => session[:user_id])
    render :html => "loadToDay", :layout => false
  end

  def deleteDayTimesheets    
    @rec = TimeTable.where(:id => params[:id],:user_id => session[:user_id] )
    data = {}
    
    if @rec[0].destroy
      data[:deleted] = true
      data[:msg] = "deleted successfully"
    else
      data[:deleted] = false
      data[:msg] = "Unable to delete the timesheet. Please try again."
    end

    render :json => data.to_json

end
	
	

	def createPieChart
		   puts "********************************PIE CHART******************************"
   		   puts params.inspect
		   pieHash = {}        
		   today = Date.strptime(params[:today], '%m/%d/%Y')
    	@pieRow = TimeTable.where(:date => today,:user_id => session[:user_id] )
		
		unless @pieRow.nil?
			@pieRow.each do |t|
				project = Project.find(t.project_id)
				if pieHash.has_key?(project.name)
					puts project.name
					i = pieHash[project.name]
					pieHash[project.name] = i + t.hours
				else
					pieHash[project.name] = t.hours
				end
			end
		end

			@initialPieHash = pieHash.to_json
			render :json => pieHash.to_json
		
		
	end
	
end
