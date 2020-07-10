import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



var x,violations;

class Calendar1{
  final List<dynamic> nine,twelve,three,six;

  Calendar1({this.nine,this.twelve,this.three,this.six});




  factory Calendar1.fromJson(List< dynamic> l) {

List<dynamic> m1 = List<dynamic>();
List<dynamic> m2 = List<dynamic>();
List<dynamic> m3 = List<dynamic>();
List<dynamic> m4 = List<dynamic>();

    for(var i = 0; i < l[0].length-1; i++){


      m1.add(l[0][i] + l[1][i] );

      m2.add(l[3][i] + l[4][i] + l[5][i]);

      m3.add(l[6][i] + l[7][i] + l[8][i] );

      m4.add(l[9][i] + l[10][i] + l[11][i] );


    }
    return Calendar1(
      nine: m1,
      twelve: m2,
      three: m3,
      six: m4,


    );
  }
}


class Album {
  final int first,second;
  final int sociald;
  final int people;

  Album({this.sociald, this.people,this.first, this.second});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      people: json['people'],
      sociald: json['social-distance'],
      first: json['1hr'],
      second: json['3hr'],

    );
  }
}




Future<Calendar1> fetchAlbum() async {
  print('hello');
  var queryParameters = {
    "oper": "query",
  };
  //var uri = Uri.https('https://us-south.functions.cloud.ibm.com', '/api/v1/namespaces/c4cteam_queue/actions/book-query?blocking=true', queryParameters);
  //var response = await http.get(uri);
  print('hello2');

  final response = await http.post('https://us-south.functions.cloud.ibm.com/api/v1/web/c4cteam_queue/default/book-query.json?blocking=true',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "oper": "query",
    }));
 // final response = await http.post('https://eu-gb.functions.cloud.ibm.com/api/v1/web/Mohamed.badreldin%40ibm.com_dev/hello-world-flutter/helloworld.json');//https://eu-gb.functions.cloud.ibm.com/api/v1/web/Mohamed.badreldin%40ibm.com_dev/hello-world-flutter/helloworld.json

  print (response.body);
  var l = json.decode(response.body)['res'];
  x = json.decode(response.body)['number'][0][0];
  violations = json.decode(response.body)['violations'][0][0];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Calendar1.fromJson(l);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.

    throw Exception('Failed to load album');
  }
}




class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin{

  Future<Calendar1> futureAlbum;



  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    x =0;


  }
  void _refresh() {
    setState(() {
      futureAlbum = fetchAlbum();
    });
  }


  Column statscont(snapshot){
    print(snapshot.data.nine[0]);
   final List<Color> c9 =  <Color> [];
   final List<Color> c12 =  <Color> [];
   final List<Color> c3 =  <Color> [];
   final List<Color> c6 =  <Color> [];
   for (int i=0; i<6;i++){
     if (snapshot.data.nine[i]<10) c9.add(Colors.green);
     else if (snapshot.data.nine[i]>=10 &&snapshot.data.nine[i]<20 )c9.add(Colors.yellow);
     else if (snapshot.data.nine[i]>=20 &&snapshot.data.nine[i]<30 )c9.add(Colors.orange);
     else if (snapshot.data.nine[i]>=30 )c9.add(Colors.red);
     else c9.add(Colors.green);

   }
    for (int i=0; i<6;i++){
      if (snapshot.data.twelve[i]<10) c12.add(Colors.green);
      else if (snapshot.data.twelve[i]>=10 &&snapshot.data.twelve[i]<20 )c12.add(Colors.yellow);
      else if (snapshot.data.twelve[i]>=20 &&snapshot.data.twelve[i]<30 )c12.add(Colors.orange);
      else if (snapshot.data.twelve[i]>=30 )c12.add(Colors.red);
      else c12.add(Colors.green);

    }
    for (int i=0; i<6;i++){
      if (snapshot.data.three[i]<10) c3.add(Colors.green);
      else if (snapshot.data.three[i]>=10 &&snapshot.data.three[i]<20 )c3.add(Colors.yellow);
      else if (snapshot.data.three[i]>=20 &&snapshot.data.three[i]<30 )c3.add(Colors.orange);
      else if (snapshot.data.three[i]>=30 )c3.add(Colors.red);
      else c3.add(Colors.green);

    }
    for (int i=0; i<6;i++){
      if (snapshot.data.six[i]<10) c6.add(Colors.green);
      else if (snapshot.data.six[i]>=10 &&snapshot.data.six[i]<20 )c6.add(Colors.yellow);
      else if (snapshot.data.six[i]>=20 &&snapshot.data.six[i]<30 )c6.add(Colors.orange);
      else if (snapshot.data.six[i]>=30 )c6.add(Colors.red);
      else c6.add(Colors.green);

    }



    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.black38,
                padding: EdgeInsets.all(20.0),

                child: Text('People Inside' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'IBM',
                        height: 5,
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8)
                    )
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black38,
                padding: EdgeInsets.all(20.0),
                child: Text('Next Hour',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'IBM',
                        height:5,
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8)
                    )
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black38,
                padding: EdgeInsets.all(20.0),
                child: Text('Next 3 Hours',
                    textAlign:
                    TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'IBM',
                        height: 5,
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8)
                    )
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.black38,
                padding: EdgeInsets.all(1.0),

                //child: Text(snapshot.data.people.toString(), textAlign: TextAlign.center,style: TextStyle(fontFamily:'IBM',fontSize: 77,color: Colors.lightBlue.withOpacity(0.8))),
                child: Text(x.toString(), textAlign: TextAlign.center,style: TextStyle(fontFamily:'IBM',fontSize: 77,color: Colors.lightBlue.withOpacity(0.8))),

                ),
              ),

            Expanded(
              child: Container(
                color: Colors.black38,
                padding: EdgeInsets.all(1.0),
               // child: snapshot.data.first > snapshot.data.people?  new Icon(Icons.arrow_drop_up,color:Colors.red,size: 100):  new Icon(Icons.arrow_drop_down,color:Colors.green,size:100),
                child: 15 > 10?  new Icon(Icons.arrow_drop_up,color:Colors.red,size: 100):  new Icon(Icons.arrow_drop_down,color:Colors.green,size:100),

              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black38,
                padding: EdgeInsets.all(1.0),
                //child: snapshot.data.second > snapshot.data.first?  new Icon(Icons.arrow_drop_up,color:Colors.red,size:100.0):  new Icon(Icons.arrow_drop_down,color:Colors.green,size:100.0),
                child: 10 > 15?  new Icon(Icons.arrow_drop_up,color:Colors.red,size:100.0):  new Icon(Icons.arrow_drop_down,color:Colors.green,size:100.0),

              ),
            ),
          ],
        ),

        Row(children:<Widget>[

               Expanded(
                 child: Container(
                      color: Colors.black38,
                      padding: EdgeInsets.all(20.0),
                      child: Text('Social distancing violations : $violations ',textAlign: TextAlign.center,style: TextStyle(fontFamily:'IBM',fontSize: 18,color: Colors.white70.withOpacity(0.8)))
                  ),
               ),


          ]),
        Row(
          children:[
            Expanded(
                child: Container(
                    color: Colors.black38,
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text('Less than 10% capacity:',style: TextStyle(fontFamily:'IBM',fontStyle: FontStyle.italic, color:Colors.white70)),
                          Icon(Icons.center_focus_strong,size:20.0,color: Colors.green),

                          Text('Less than 30% capacity:',style: TextStyle(fontFamily:'IBM',fontStyle: FontStyle.italic, color:Colors.white70)),
                          Icon(Icons.center_focus_strong,size:20.0,color: Colors.yellow),

                          Text('Less than 60% capacity:',style: TextStyle(fontFamily:'IBM',fontStyle: FontStyle.italic, color:Colors.white70)),
                          Icon(Icons.center_focus_strong,size:20.0,color: Colors.orange),

                          Text('More than 80% capacity:',style: TextStyle(fontFamily:'IBM',fontStyle: FontStyle.italic, color:Colors.white70)),
                          Icon(Icons.center_focus_strong,size:20.0,color: Colors.red),

                        ]
                    )
                )

            ),
          ]
        ),
        Row(
          children:<Widget>[

            Expanded(
             child: Container(
                  color: Colors.black38,
                  padding: EdgeInsets.all(20.0),
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(

                        label: Center(
                          child: Text(
                            'Time',
                            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.white70,fontSize: 15.0),
                          ),
                        )
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            'Sunday',
                            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.white70),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            'Monday',
                            style: TextStyle(fontStyle: FontStyle.italic, color:Colors.white70),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            'Tuesday',
                            style: TextStyle(fontStyle: FontStyle.italic, color:Colors.white70),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            'Wednesday',
                            style: TextStyle(fontStyle: FontStyle.italic, color:Colors.white70),
                          ),
                        ),
                      ),
                      DataColumn(
                        label:  Text(
                            'Thursday',
                            style: TextStyle(fontStyle: FontStyle.italic, color:Colors.white70),
                          ),

                      ),
                    ],

                    rows:  <DataRow>[

                      DataRow(
                        cells: <DataCell>[
                          DataCell(Container(width:40,child: Text('9:00 - 12:00',style: TextStyle(fontStyle: FontStyle.italic, color:Colors.white70)))),
                          DataCell(Container(width:40,child: Icon(Icons.center_focus_strong,size:40.0,color: c9[0]))),
                          DataCell(Container(width:40,child: Icon(Icons.center_focus_strong,size:40.0,color:c9[1]))),
                          DataCell(Container(width:40,child: Icon(Icons.center_focus_strong,size:40.0,color:c9[2]))),
                          DataCell(Container(width:40,child: Icon(Icons.center_focus_strong,size:40.0,color:c9[3]))),
                          DataCell(Container(width:40,child: Icon(Icons.center_focus_strong,size:40.0,color:c9[4]))),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('12:00 - 15:00',style: TextStyle(fontStyle: FontStyle.italic, color:Colors.white70))),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c12[0])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c12[1])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c12[2])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c12[3])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c12[4])),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('15:00 - 18:00',style: TextStyle(fontStyle: FontStyle.italic, color:Colors.white70))),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c3[0])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c3[1])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c3[2])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c3[3])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c3[4])),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('18:00 - 21:00',style: TextStyle(fontStyle: FontStyle.italic, color:Colors.white70))),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c6[0])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c6[1])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c6[2])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c6[3])),
                          DataCell(Icon(Icons.center_focus_strong,size:40.0,color:c6[4])),
                        ],
                      ),

                    ],


                  ),

                ),
           ),

          ],
        ),
        


      ],
    );



  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.withOpacity(0.9),
        centerTitle: true,
        title: Text(' B-SAFE \uEBE7 cares', style: TextStyle(fontFamily: 'IBM', fontSize: 40.0,letterSpacing: 14.0) ),
        //actions: [Image(image: AssetImage('graphics/background.png'))],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('REGULTIONS AND ALERTS',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'IBM',
                  height:10.0,
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8)),),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height:20.0),
            ListTile(
              title: Card(
                color: Colors.grey[100],

                  child:ListTile(
                        leading: Icon(Icons.warning, size: 30,color:Colors.blue.withOpacity(0.9)),
                        title: Text('It is prohibited to enter premises without a mask', style:TextStyle(fontFamily: 'IBM',color:Colors.blue..withOpacity(0.9))),

                      ),
                  ),



            ),
            SizedBox(height:20.0),
            ListTile(
              title: Card(

                color: Colors.grey[100],
                child: ListTile(
                  leading: Icon(Icons.warning, size: 30, color:Colors.blue.withOpacity(0.9)),
                  title: Text('Always stay 1.5 meters away from any person', style:TextStyle(fontFamily: 'IBM',color:Colors.blue.withOpacity(0.9))),

                ),

              ),

            ),
            SizedBox(height:20.0),
            ListTile(
              title: Card(
                color: Colors.grey[100],
                child:  ListTile(
                  leading: Icon(Icons.add_alert, size: 30, color:Colors.red[900].withOpacity(0.8)),
                  title: Text('New Store Hours: 6 AM to 5 PM',style:TextStyle(fontFamily: 'IBM',color:Colors.red[900].withOpacity(0.8))),

                ),
              )
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FutureBuilder<Calendar1>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return statscont(snapshot);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),

            ]
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.

      floatingActionButton: Row (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Container(
              padding: EdgeInsets.all(40.0),
              child: FloatingActionButton.extended(
                label: Text('Make Appointment'),
                icon: Icon(Icons.chat, color: Colors.white,),
                onPressed: (){Navigator.pushNamed(context, '/chat');},

            ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: _refresh,
                tooltip: 'Refresh',
                child: Icon(Icons.refresh),
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ]
      ),
    );
  }
}