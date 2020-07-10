import 'package:covidapp/navigation/navigationDrawer.dart';
import 'package:flutter/material.dart';
class BookingPage extends StatelessWidget {
  static const String routeName = '/bookingPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        ),
        drawer: navigationDrawer(),
        body: Center(child: Text("Hey! this is events list page")));
  }
}