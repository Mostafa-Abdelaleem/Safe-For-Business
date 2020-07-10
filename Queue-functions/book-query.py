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
import psycopg2
import random
import string
import datetime
from datetime import date
import calendar
###Book-fun######################################################################################################################
def book(day,hour,max_cust):
    
    date = datetime.datetime.strptime(day, '%Y-%m-%d' )
    day=calendar.day_name[date.weekday()]
    longh = datetime.datetime.strptime(hour, '%H:%M:%S' )
    hour=longh.hour


    if(hour>21 or hour<9):
        return{"res":"out of working hours plz choose a time between 9am and 10pm"}
    

    try:
        connection= psycopg2.connect(user="admin",
                    password="c4cegypt2020",
                    host="db8dbc41-5e21-42bc-9d93-d417b36ffab3.bn2a0fgd0tu045vmv2i0.databases.appdomain.cloud",
                    port="31308",
                    database="ibmclouddb")
        print("connected successfully")
        cur = connection.cursor()
    except (Exception, psycopg2.Error) as error :
            print ("Error while fetching data from PostgreSQL", error)
            
            
          
    with connection:
        cur.execute(f"SELECT {day} FROM avail where slot={hour};");
        record = cur.fetchall()
        if(record[0][0] >= max_cust):
            return{"res":"sorry this time is very crowded, plz try another time"}
        N=6;
        uniqstring=''.join(random.SystemRandom().choice(string.digits) for _ in range(N))
        
        print("day is:",day)
        print("hour is:",hour)
        print("token is:",uniqstring)
         
        sql_string=f''' UPDATE slots SET {day} = array_append({day},'{uniqstring}') WHERE slot={hour};
                        UPDATE avail SET {day} = {day}+1 WHERE slot={hour}; '''
        
        cur.execute(sql_string);
        
    return {"res":"slot booked","code":uniqstring}
###query-day######################################################################################################################
def query_day(day,max_cust):
    
    date = datetime.datetime.strptime(day, '%Y-%m-%d' )
    day=calendar.day_name[date.weekday()]
    print("day is:",day)
    
    try:
            
            connection = psycopg2.connect(user="admin",password="c4cegypt2020",port="31308",database="ibmclouddb",
                         host="db8dbc41-5e21-42bc-9d93-d417b36ffab3.bn2a0fgd0tu045vmv2i0.databases.appdomain.cloud")
            print("connected successfully")
            cur = connection.cursor()
    except (Exception, psycopg2.Error) as error :
         print ("Error while fetching data from PostgreSQL", error)
     
    with connection:
        sql_string=f" SELECT slot,{day} FROM avail order by slot; "
        cur.execute(sql_string);
        record = cur.fetchall()
    ##get available slots##    
        avail_slots=[]
        for slot ,res in record:
            if(res< max_cust):
                if(slot < 12):
                    avail_slots.append(str(slot)+" am" )
                elif(slot == 12):
                    avail_slots.append(str(slot)+" pm" )
                else:
                    avail_slots.append(str(slot-12)+" pm" )
    ##return list of available slots##
        avail_slots=["slot "+ s  for s in avail_slots]
    ##return slots as string##
        # timestr=s = ','.join(avail_slots)
        # avail_slots=f" there is available slots at {timestr},plz choose a slot from the available"
                
            
                        
                
        print (avail_slots)
    return {"res":"done","slots":avail_slots}
    
#############################################################################################################################################################     
def main(dict):
    
    print("operation is:",dict['oper'])
    max_cust=50
#################################################################
    if(dict["oper"]== "book"):
        
        return (     book( dict["day"],dict["hour"],max_cust )    )

#############################################################################################################################################################    
    elif(dict['oper']=='query'):
        
        try:
            
            connection = psycopg2.connect(user="admin",password="c4cegypt2020",port="31308",database="ibmclouddb",
                         host="db8dbc41-5e21-42bc-9d93-d417b36ffab3.bn2a0fgd0tu045vmv2i0.databases.appdomain.cloud")
                                      
            print("connected successfully")
            cur = connection.cursor()
        except (Exception, psycopg2.Error) as error :
             print ("Error while fetching data from PostgreSQL", error)
         
        with connection:
          
            
            sql_string=''' SELECT sunday,monday,tuesday,wednesday,thursday,friday,saturday FROM avail order by slot; '''
            cur.execute(sql_string);
            record = cur.fetchall()
            cur.execute("select number from count where id=1;");
            number=cur.fetchall()
            print("HERE YOU GO ", record,"\n")
         
    
        return {"res":record,"number":number}
#################################################################
    elif (dict['oper'] =='query' and dict["day"] !=None):
        
        return (     query_day(  dict["day"],max_cust  )    )    
    
    
        

