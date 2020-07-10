import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    super.initState();

    watsonAssistantContext.resetContext();

    WidgetsBinding.instance.addPostFrameCallback((_) => chatResponse('hello'));


  }

  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  WatsonAssistantV2Credential credentials = WatsonAssistantV2Credential(
      apikey:'wOQSKdOyF5LEgrvvQp_4-5p6ksbWC1o9PwmHBnZFLhfx',
      url: 'https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/7a3ebfc6-a24d-40d1-a931-8e3e2def27b7/v2',
      assistantID: 'bb57a837-2325-4c0a-a34f-c5ed32057837'
  );

  WatsonAssistantApiV2 watsonAssistant;
  WatsonAssistantResponse response;
  WatsonAssistantContext watsonAssistantContext =
  WatsonAssistantContext(context: {});


  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void chatResponse(query) async {
    _textController.clear();
    watsonAssistant =
        WatsonAssistantApiV2(watsonAssistantCredential: credentials);

    response = await watsonAssistant.sendMessage(
        query, watsonAssistantContext);
    print(response.resultText);
    ChatMessage message = new ChatMessage(
      text: response.resultText,
      name: "Watson",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    ChatMessage message = new ChatMessage(
      text: text,
      name: "Me",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    chatResponse(text);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Make An Appointment",style: new TextStyle(fontFamily:'IBM',fontWeight: FontWeight.bold)),
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),

      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;
  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child: new Text('W',style:TextStyle(fontFamily:'IBM',fontWeight: FontWeight.bold))),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("Watson Assistant Scheduler: ",
                style: new TextStyle(fontFamily:'IBM',fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text,style:TextStyle(fontFamily:'IBM')),
            ),
            isNumeric(this.text.substring(this.text.length - 6))  ?
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new QrImage(
                data: this.text.substring(this.text.length - 6),
                version: QrVersions.auto,
                size: 200.0,
              )
            ): new Text(''),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: TextStyle(fontFamily:'IBM',fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(
            child: new Text(
              this.name[0],
              style: new TextStyle(fontFamily:'IBM',fontWeight: FontWeight.bold),
            )),
      ),
    ];
  }
//hh44100 honeywell
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}