import 'package:covidapp/navigation/navigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class WatsonAssistantPage extends StatelessWidget {
  static const String routeName = '/watsonAssistantPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Watson"),
        ),
        drawer: navigationDrawer(),
        body: Center(child: Text("Watson Assistant")));
  }
}

