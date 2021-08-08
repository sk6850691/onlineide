
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CreateCampsListing extends StatefulWidget {

  final collectionName;
  const CreateCampsListing({Key key,this.collectionName}) : super(key: key);

  @override
  _CreateCampsListingState createState() => _CreateCampsListingState();
}

class _CreateCampsListingState extends State<CreateCampsListing> {

  String description = '';
  String price = '';
  int price1 = 0;
  String location = '';
  String uid = '';
  List l = ['https://images.unsplash.com/photo-1597395234026-36e08a008b75?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=364&q=80'];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Column(

            children: [
              Text('Create your Listing',style: GoogleFonts.lato(fontSize: 25,fontWeight: FontWeight.w800),)

              ,
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter Description'
                ),
                onChanged: (value){

                  setState(() {
                    description = value;
                  });


                },

              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter Location'
                ),
                onChanged: (value){
                  setState(() {
                    location = value;
                  });

                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter Price'
                ),
                onChanged: (value){

                  setState(() {

                    var myInt = int.parse(value);
                    assert(myInt is int);
                    price1 = myInt;

                  });


                },
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                minWidth: 200,
                height: 40,
                onPressed: ()async{

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  print(prefs.getString('uid'));



                  await FirebaseFirestore.instance.collection(widget.collectionName).doc().set({

                    'images':FieldValue.arrayUnion(l),








                    "adminid":prefs.getString('uid'),
                    "description": description,
                    "price":price1,
                    "location":location
                  });



                },
                child: Text('Submit'),
              )


            ],
          ),
        ),
      ),
    );;
  }
}
