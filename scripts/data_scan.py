import pandas as pd
import csv
import os
import matplotlib.pyplot as plt

daily_heart_data = pd.read_csv("dailyRestingHeartRate.csv")
quarter_hour_heart_data = pd.read_csv("heartrate_15min.csv")
hourly_steps = pd.read_csv("hourlySteps.csv")
daily_steps = pd.read_csv("dailySteps.csv")
sleep_data = pd.read_csv("sleep_stage.csv")


mean_dailysteps=daily_steps['StepTotal'].mean()      #mean steps upto date
std_steps=daily_steps['StepTotal'].std()       #standard deviation of steps upto date

mean_heartrate=daily_heart_data['RestingHeartRate'].mean()
std_heartrate=daily_heart_data['RestingHeartRate'].std()

mean_efficiency=sleep_data['Efficiency'].mean()
mean_bedtime= sleep_data['TimeInBed'].mean()

daily_heart_data.hist(column='RestingHeartRate')
plt.xlabel('Heart rate in bpm')
plt.ylabel('Frequency')
quarter_hour_heart_data.hist(column="Value")

print("Mean resting heart rate=",mean_heartrate)
print("Mean daily steps=",mean_dailysteps)
print("Mean sleep efficiency=",mean_efficiency)
print("Mean bed time=",mean_bedtime)

# can compare with mean values to detect abnormality
if (mean_dailysteps<6000):
    print("you need to work out more")
else:
    print("you are doing good. keep it up.")
plt.xlabel('Time')
plt.ylabel('Heart rate in bpm')
plt.plot(quarter_hour_heart_data['Time'],quarter_hour_heart_data['Value'])
plt.gcf().autofmt_xdate()
plt.show()
