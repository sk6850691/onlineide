
import 'package:flutter/material.dart';
class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key key}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          children:[
            Text('Total Earning this month'),


            TextFormField(),
            TextFormField(),
            TextFormField()
          ]


        ),
      ),
    );
  }
}
