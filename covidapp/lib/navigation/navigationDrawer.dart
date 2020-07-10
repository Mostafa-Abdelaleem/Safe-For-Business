import 'package:covidapp/widgets/createDrawerBodyItem.dart';
import 'package:covidapp/widgets/createDrawerHeader.dart';
import 'package:covidapp/routes/pageRoutes.dart';
import 'package:flutter/material.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.home),
          ),

          createDrawerBodyItem(
            icon: Icons.event_note,
            text: 'Book',
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.booking),
          ),

          createDrawerBodyItem(
            icon: Icons.contact_phone,
            text: 'Chat',
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.watsonAssistant),
          ),
          ListTile(
            title: Text('C4C Covid App v 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}