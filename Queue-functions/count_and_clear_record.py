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
    code=dict['code']
    day = datetime.today().strftime('%A')
    print(day)
    day='monday'
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
        cur.execute(f"update  slots set {day} = array_remove({day},'{code}') ;");
        cur.execute(f"UPDATE count SET number = number + 1 WHERE id = 1;");

    return { 'res': 'number updated' }

