import 'package:flutter/material.dart';
import 'package:fogsi/utils/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pageProminent,
        titleSpacing: 0,
        toolbarHeight: 70,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width*0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("FOGSI", style: TextStyle(color: tealColor, fontSize: 16, fontFamily: 'Rubik', fontWeight: FontWeight.w700),),
                  ),
                  Container(
                    child: Text("Awareness App", style: TextStyle(color: tealColor, fontSize: 16, fontFamily: 'Rubik', fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            ),
            Container(
              child: GestureDetector(),
            )
          ],
        ),
      ),
    );
  }
}