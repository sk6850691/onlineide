import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FinanceDetails extends StatefulWidget {
  const FinanceDetails({Key key}) : super(key: key);

  @override
  _FinanceDetailsState createState() => _FinanceDetailsState();
}

class _FinanceDetailsState extends State<FinanceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(),
            TextFormField(),
            TextFormField(),
            MaterialButton(
              color: Colors.red,
              onPressed: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('bool','true');


              },
            )
          ],
        ),
      ),
    );
  }
}
