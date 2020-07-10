#
#
# main() will be run when you invoke this action
#
# @param Cloud Functions actions accept a single parameter, which must be a JSON object.
#
# @return The output of this action, which must be a JSON object.
#
#
import sys
import calendar
from datetime import datetime,timezone
import psycopg2

def verify_code(code):
# get current date and time
    day = datetime.today().strftime('%A')
    hour= datetime.now().astimezone().time().hour + 2
    print("code is: ",code)
    day="Monday"
    hour=18
    if hour > 20 :
        return {'res':'out of working hours'}
        
    # day=calendar.day_name[date]
    # print("day is:",date)
    # longh = datetime.datetime.strptime(hour, '%H:%M:%S' )
    #hour=9


#connect to db
    try:
        connection= psycopg2.connect(user="admin",
                    password="c4cegypt2020",
                    host="db8dbc41-5e21-42bc-9d93-d417b36ffab3.bn2a0fgd0tu045vmv2i0.databases.appdomain.cloud",
                    port="31308",
                    database="ibmclouddb")
        print("connected successfully")
        print("code is: " ,code )
        print("hour is ", hour)
        print("day is:" ,day)
        cur = connection.cursor()
    except (Exception, psycopg2.Error) as error :
            print ("Error while fetching data from PostgreSQL", error)
#query db
    with connection:
        cur.execute(f"SELECT {day} FROM slots where slot={hour};");
        record = cur.fetchall()
        print (record)
    if ( record[0][0] ) and  ( code in record[0][0]):

        return {'res':'access granted'}
    else:

        return {'res':'invalid code'}
    

def main(dict):
    print(dict)
    
    return verify_code(dict['code'])
