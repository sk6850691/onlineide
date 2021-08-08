import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Bookings extends StatefulWidget {
  const Bookings({Key key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {

  String uid = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuid();
  }

  getuid()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('orders').where('adminid',isEqualTo: uid).snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return CircularProgressIndicator();
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            return Container(
              height: MediaQuery.of(context).size.height-10,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document){

                  Map<String,dynamic> data = document.data()['cart'] as Map<String,dynamic>;
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('OrderId' + ' '+data['id'].toString(),style: GoogleFonts.lato(fontSize: 25,fontWeight: FontWeight.w800),),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Price' + ' '+ data['price'].toString(),style: GoogleFonts.lato(fontSize: 25,fontWeight: FontWeight.w800),),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  );

                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
