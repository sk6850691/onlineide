import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_admin/providers/userprovider.dart';
import 'package:travel_admin/screens/CreateListing.dart';
import 'package:travel_admin/screens/EditListing.dart';
class MyListings extends StatefulWidget {
  const MyListings({Key key}) : super(key: key);

  @override
  _MyListingsState createState() => _MyListingsState();
}

class _MyListingsState extends State<MyListings> {
  String uid = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getString();
  }

  getString()async{
    SharedPreferences prefs =await  SharedPreferences.getInstance();
    uid = prefs.getString('uid');

  }




  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButton: MaterialButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),

        ),
        minWidth: 80,
        color: Colors.red,
        child: Text('Create Listing',),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateListing()));
        },
      ),
      appBar: AppBar(
        title: Text('Your Listings',style: GoogleFonts.lato(fontSize: 25,fontWeight: FontWeight.w900),),
      ),
      body: SingleChildScrollView(

        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Camps').where("id",isEqualTo:uid ).snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }

             return Container(
               width: MediaQuery.of(context).size.height,
               height: MediaQuery.of(context).size.width,
               child: ListView.builder(
                 itemCount: snapshot.data.docs.length,
                 itemBuilder: (context,index){
                   DocumentSnapshot doc = snapshot.data.docs[index];
                   return GestureDetector(

                     onTap:(){
                       Navigator.push(context,MaterialPageRoute(builder: (context)=>EditListing(images: doc['images'],price: doc['price'],description: doc['description'],location: doc['location'],),));
                     } ,
                     child: Card(
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                       child: Row(
                         children:[ Image.network(
                           doc['images'][0],
                           cacheWidth: 100,
                           cacheHeight: 100,

                         ),


                           Column(children:[



                           Text(doc['description'],style: GoogleFonts.lato(),),
                           SizedBox(
                             height: 10,
                           ),
                           Text(doc['price'].toString()),
                           SizedBox(
                             height: 10,
                           ),Text(doc['location'].toString()),
                           SizedBox(
                             height: 30,
                           )

                         ]),
                       ]),
                     ),
                   );
                 },

               ),
             );


          },
        ),
      ),
    );
  }


}

