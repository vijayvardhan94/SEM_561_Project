# widget configuration

unit_system   = "METRIC"
date_format   = "%H:%M"
animate_views = true

#=begin
#=end
#SCHEDULER.every "5m", first_in: 0 do |job|
#Dashing.scheduler.every '1m', :first => :now do |job|
Dashing.scheduler.every '5m', first_in: 0 do |job|

  
end
