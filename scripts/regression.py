#!pip install fitbit
#!pip install -r requirements/base.txt
#!pip install -r requirements/dev.txt
#!pip install -r requirements/test.txt
from time import sleep
import fitbit
import cherrypy
import requests
import json
import datetime
import scipy.stats
import pandas as pd
import numpy as np

# plotting
import matplotlib
from matplotlib import pyplot as plt
import seaborn as sns
get_ipython().magic(u'matplotlib inline')


with open('heartrate/HR2017-12-23.json') as f:
    hr_dat_sample = json.loads(f.read())

parsed_json_hr_samp = json.loads(hr_dat_sample)

list(parsed_json_hr_samp['activities-heart-intraday'].keys())

# ## Heart Rate

dates = pd.date_range('2017-12-23', '2018-01-25')
hrval = []

for date in dates:
    fname = 'heartrate/HR' + date.strftime('%Y-%m-%d') + '.json'
    with open(fname) as f:
        date_data = json.loads(f.read())
        
        data = pd.read_json(date_data, typ='series')
        hrval.append(data['activities-heart-intraday']['dataset'][1])

HR_df = pd.DataFrame(hrval,index = dates)
HR_df.columns = ['time', 'bpm']
HR_df.head()

stats = data['activities-heart-intraday']['dataset']
HR=pd.DataFrame(stats)
HR.head()
HR.columns = ['time', 'bpm']
HR.plot(color = "firebrick")
plt.ylabel('Heart Rate');
HR.describe()



with open('sleep/sleep2017-12-23.json') as f:
    sleepdat = json.loads(f.read())
sleepdata = pd.read_json(sleepdat, typ='series')
sleepdata

parsed_json = json.loads(sleepdat)
list(parsed_json['sleep'][0].keys())



sleepy = []
for date in dates:
    fname = 'sleep/sleep' + date.strftime('%Y-%m-%d') + '.json'
    with open(fname) as f:
        date_data_sleep = json.loads(f.read())
        datsleep = pd.read_json(date_data_sleep, typ='series')
        sleepy.append(datsleep['summary']['totalTimeInBed'])

sleepdf = pd.DataFrame(sleepy,index = dates) #use the date as the column row names
sleepdf.columns = ['hours'] #rename column
sleepdf['hours'] = sleepdf['hours']/60 # Turn minutes to hours
sleepdf.head()
sleepdf.describe()



sleepdf['hours'].plot(color = "mediumseagreen")
plt.title('Hours of Sleep (12.23.17-1.25.18)')
plt.ylabel('Hours')
plt.show()



sns.distplot(sleepdf['hours'], color="mediumseagreen")
plt.title("My Sleep Distribution")
plt.xlabel("Hours")
plt.show()




sleepdf["day_of_week"] = sleepdf.index.weekday
days = {0: "Monday", 1: "Tuesday", 2: "Wednesday", 3: "Thursday", 4: "Friday", 
        5: "Saturday", 6: "Sunday"}
sleepdf["day_name"] = sleepdf["day_of_week"].apply(lambda x: days[x])
sleepdf.head()


# Make a Bar Plot 
sns.countplot(x='day_name', data=sleepdf, palette = "Set2")
plt.xticks(rotation=45)
plt.xlabel("")
plt.show()



sns.swarmplot(x='day_name', y='hours', data=sleepdf,  palette = "Set2")
plt.xticks(rotation=45)
plt.title("Sleep Distribution Over the Week")
plt.ylabel("Hours")
plt.xlabel("")
plt.show()


# view- violin style!

sns.violinplot(x='day_name',
               y='hours', 
               data=sleepdf, 
               inner=None, palette = 'Set2' ) 

sns.swarmplot(x='day_name',
               y='hours', 
              data=sleepdf, 
              color='k', 
              alpha=0.7)
 
plt.title('Sleep by Day')
plt.xticks(rotation=45)
plt.show()

sns.boxplot(x = 'day_name', y = 'hours', data = sleepdf, palette = 'Set2')
plt.title('Hours of Sleep by Day')
plt.xticks(rotation=45)
plt.xlabel("") 
plt.ylabel("")
plt.show()


with open('steps/step2018-01-13.json') as f:
    step_data = json.loads(f.read())
stepsdata = pd.read_json(step_data, typ='series')
stepsdata

parsed_json = json.loads(step_data)
#print(json.dumps(parsed_json))
list(parsed_json.keys())
dates = pd.date_range('2017-12-23', '2018-01-25')
steppers = []
for date in dates:
    fname = 'steps/step' + date.strftime('%Y-%m-%d') + '.json'
    with open(fname) as f:
        date_data = json.loads(f.read())
        
        stepsdata = pd.read_json(date_data, typ='series')
        steppers.append(stepsdata['activities-steps'][0]) 

stepsdf = pd.DataFrame(steppers,index = dates)
stepsdf.columns = ['date','steps'] 
stepsdf.head()
stepsdf["day_of_week"] = stepsdf.index.weekday
stepsdf["day_name"] = stepsdf["day_of_week"].apply(lambda x: days[x])
stepsdf.head()

stepsdf['steps'] = pd.to_numeric(stepsdf['steps'])
stepsdf.info()
sns.set_style("ticks")
sns.distplot(stepsdf['steps'], color = 'steelblue')
plt.title("Step Distribution")
plt.xlabel("Steps") 
plt.show()
sns.violinplot(x='day_name',
               y='steps', 
               data=stepsdf, 
               inner=None, palette="Set3" ) 
            

sns.swarmplot(x='day_name',
               y='steps', 
              data=stepsdf, 
              color='k',  
              alpha = 0.5)
plt.title('Steps by Day')
plt.xticks(rotation=45)
plt.xlabel("") 
plt.ylabel("")
plt.show()

sns.boxplot(x = 'day_name', y = 'steps', data = stepsdf, palette="Set3")
plt.title('Steps by Day')
plt.xticks(rotation=45)
plt.xlabel("") 
plt.ylabel("")
plt.show()

import statsmodels.api as sm
import statsmodels.formula.api as smf
from pandas.core import datetools
stepsdf['hours'] = sleepdf['hours'].values

stepsdf["hours_prev"] = stepsdf.shift(1).hours
stepsdf.head()

mod1 = smf.ols(formula = "steps ~ hours_prev", data = stepsdf).fit()
mod1.summary().tables[1]


sns.regplot(x = stepsdf.steps, y = stepsdf.hours_prev, color = 'steelblue')
plt.xlabel("Daily Steps")
plt.ylabel("Hours of Sleep")
plt.title("Does Sleep Amount Predict Activity Level?")
plt.show()

stepsdf["hours_diff"] = stepsdf.hours - stepsdf.hours_prev
stepsdf.head()

mod2 = smf.ols(formula = 'hours_diff ~ hours_prev', data = stepsdf).fit()
mod2.summary().tables[1]

sns.regplot(x = stepsdf.hours_prev, y = stepsdf.hours_diff, color = "mediumseagreen")
plt.title("Sleep Deficit?")
plt.ylabel("Difference in Hours")
plt.xlabel("Hours of Sleep")
plt.show()

