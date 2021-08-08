import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_admin/providers/userprovider.dart';
import 'package:travel_admin/screens/FInanceDetails.dart';
import 'package:travel_admin/screens/homescreen.dart';
import 'package:travel_admin/screens/homescreen.dart';


import 'CreateListing.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  String Bool = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  getbool()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   Bool =  prefs.getString('bool');

  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('RegistrationScreen'),
      ),
      body: Center(
        child: RoundedLoadingButton(
          child: Text('Login With Google'),
          controller: controller , onPressed: (){
          userProvider.signInWithGoogle().then((value) {
            controller.success();


            Bool!=null?Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen())):Navigator.push(context,MaterialPageRoute(builder: (context)=>FinanceDetails()));
    }
            );
        },
        ),
      ),
    );

  }
}
