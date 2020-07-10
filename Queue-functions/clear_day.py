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
from datetime import datetime
def main(dict):
    # get current date 
    day = datetime.today().strftime('%A')
    
    #connect to db
    try:
        connection= psycopg2.connect(user="admin",
                    password="c4cegypt2020",
                    host="db8dbc41-5e21-42bc-9d93-d417b36ffab3.bn2a0fgd0tu045vmv2i0.databases.appdomain.cloud",
                    port="31308",
                    database="ibmclouddb")
        print("connected successfully")
        print("day is:" ,day)
        cur = connection.cursor()
    except (Exception, psycopg2.Error) as error :
            print ("Error while fetching data from PostgreSQL", error)
            
    with connection:
        cur.execute(f"UPDATE slots SET {day} = NULL;");
            
    return { 'message': 'DAY CLEARED' }

