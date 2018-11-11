import fitbit
import pandas as pd
from datetime import datetime, date, time, timedelta

authd_client = fitbit.Fitbit(OAuthTwoClientID, ClientSecret, oauth2=True,
                             access_token=AccessToken, refresh_token=RefreshToken)

def get_raw_week_sleep():
    week_sleep_data = []
    week_date_range = (date.today() - timedelta(days=x) for x in xrange(7))
    for day in week_date_range:
        day_sleep_data = authd_client.sleep(date=day)
        week_sleep_data.append(day_sleep_data)
    return week_sleep_data

def get_useful_sleep(raw_data):
    return [day['sleep'][0] for day in week_sleep_data if day['sleep']]

def start_time_convert(start_time):
    return datetime.strptime(start_time[-12:-4], '%H:%M:%S').time()

def start_time_total_seconds(start_time):
    return start_time.hour * 3600 + start_time.minute * 60 + start_time.second if start_time <= time(12) else (
            start_time.hour - 24) * 3600 + start_time.minute * 60 + start_time.second

def seconds_to_time(seconds):
    seconds = int(seconds)
    hours, minutes = divmod(seconds, 3600)
    minutes,seconds = divmod(minutes, 60)
    return time(hours,minutes,seconds)

def ms_duration_to_hours(duration_seconds):
    duration_seconds = int(duration_seconds)
    hours, minutes = divmod(duration_seconds, 3600000)
    minutes, seconds = divmod(minutes, 60000)
    seconds = seconds // 1000
    return time(hours,minutes,seconds)

if __name__ == '__main__':
    week_sleep_data = get_raw_week_sleep()
    week_cleaned_list = get_useful_sleep(week_sleep_data)
    df = pd.DataFrame(week_cleaned_list)

    df['duration_hours'] = df['duration'].apply(ms_duration_to_hours)
    avg_duration = df['duration'].mean()
    avg_duration = ms_duration_to_hours(avg_duration)

    df['startTime'] = df['startTime'].apply(start_time_convert)
    df['start_time_seconds']= df['startTime'].apply(start_time_total_seconds)
    avg_bed_time = seconds_to_time(df['start_time_seconds'].mean())

    duration_start_time_col = ['dateOfSleep','duration_hours','startTime']
    print df[duration_start_time_col]
    print 'Average bed time: {}'.format(avg_bed_time)
    print 'Average sleep duration: {}'.format(avg_duration)
