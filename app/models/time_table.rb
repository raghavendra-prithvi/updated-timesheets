class TimeTable < ActiveRecord::Base
attr_accessible :project_id, :user_id, :date, :hours, :created_at, :updated_at

belongs_to :project
belongs_to :user

scope :chronological, :order => 'date ASC'

def self.alpha
	joins(:project).order("projects.name ASC")
end

def self.viewDate (startDate, endDate)
	where(:date => startDate..endDate)
end

def self.getTotal
	sum('hours')
end

def self.getDayTotal (day)
	where(:date => day).sum('hours')
end


end