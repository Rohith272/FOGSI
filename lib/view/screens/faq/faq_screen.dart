import 'package:flutter/material.dart';
import 'package:fogsi/controller/main-layout/main_layout_controller.dart';
import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/utils/posters.dart';
import 'package:get/get.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen>{

  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());

  @override
  void initState(){
    if (mainLayoutController.indexStack.last != 2){
      setState(() {
        mainLayoutController.addScreen(FaqScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 90),
                child: Image.asset(Posters.faq, height: 280, width: 280,),
              ),
              Container(
                margin: EdgeInsets.only(top: 24, bottom: 10),
                child: Text("Welcome to FAQ!", style: TextStyle(fontWeight: FontWeight.w600, color: tealColor, fontSize: 22, fontFamily: 'Rubik'),),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                child: Text("View common queries, and ask questions of your own", style: TextStyle(fontWeight: FontWeight.w600, color: menuTitleGrey, fontSize: 18, fontFamily: 'Rubik'), textAlign: TextAlign.center, ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: primaryTheame,
                alignment: Alignment.center,
                child: Text("Coming Soon!", style: TextStyle(color: tealColor, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Rubik'),),
              )
            ],
          ),
        )
    );
  }
}