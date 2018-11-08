# widget configuration

unit_system   = "METRIC"
date_format   = "%H:%M"
animate_views = true

=begin
=end
#SCHEDULER.every "5m", first_in: 0 do |job|
#Dashing.scheduler.every '1m', :first => :now do |job|
Dashing.scheduler.every '5m', first_in: 0 do |job|

  fitbit = Fitbit.new unit_system: unit_system, date_format: date_format
  if fitbit.errors?
    Dashing.send_event('fitbit', { error: fitbit.error })
  else
    Dashing.send_event('fitbit', {
      device:   fitbit.device,
      steps:    fitbit.steps,
      calories: fitbit.calories,
      distance: fitbit.distance,
      active:   fitbit.active,
      animate:  animate_views
    })
  end
end
