import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_admin/models/createlistingmodel.dart';
class MainListingWidget extends StatefulWidget {
  final CreateListingModel listingModel;
  const MainListingWidget({Key key, this.listingModel}) : super(key: key);

  @override
  _MainListingWidgetState createState() => _MainListingWidgetState();
}

class _MainListingWidgetState extends State<MainListingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(widget.listingModel.image.toString(),cacheHeight: 150,cacheWidth: 150,filterQuality: FilterQuality.high,)),
          Padding(
              padding: EdgeInsets.only(top: 20,left: 10),
              child: Text(widget.listingModel.description,style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white),))
        ],
      ),
    );
  }
}

