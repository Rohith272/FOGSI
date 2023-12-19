import 'package:flutter/material.dart';
import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/utils/posters.dart';

class NoInternetScreenScreen extends StatefulWidget {
  const NoInternetScreenScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreenScreen> createState() => _NoInternetScreenScreenState();
}

class _NoInternetScreenScreenState extends State<NoInternetScreenScreen>{

  @override
  void initState(){}

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: pageProminent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(Posters.noInternet, width: 192, height: 264,),
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 5),
            child: const DefaultTextStyle(
              style: TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w700, fontSize: 32, color: tealColor),
              child: Text("Oops!",),
            ),
          ),
          Container(
            width: 280,
            child: const DefaultTextStyle(
              style: TextStyle(color: textDark, fontFamily: 'Rubik', fontWeight: FontWeight.w400, fontSize: 16),textAlign: TextAlign.center,
              child: Text("You don’t seem to have an internet connection. Please check your network and try again!",
              ),
            ),
          )
        ],
      ),
    );
  }
}