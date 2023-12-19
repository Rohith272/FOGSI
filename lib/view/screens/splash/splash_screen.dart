import 'dart:async';
import 'package:fogsi/utils/images.dart';
import 'package:fogsi/view/screens/home/regular_home.dart';
import 'package:fogsi/view/widgets/main_layout.dart';
import '../../../../utils/colors.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MainLayoutScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.25),
                child: Image.asset(Images.appLogo, width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35,),
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.08),
                child: Text("An Initiative of",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Rubik',
                      color: lowContrast
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Image.asset(Images.fogsiLogo, width: MediaQuery.of(context).size.height*0.1, height: MediaQuery.of(context).size.height*0.1,),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text("FOGSI Public Awareness Committee", style: TextStyle(
                  color: menuTitleGrey,
                  fontFamily: 'Rubik',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.center,),
              ),
              Spacer(),
              Container(
                child: Text("Developed by", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Rubik',
                    color: menuTitleGrey
                ),),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 21),
                child: Text("Genworks Health Pvt. Ltd.", style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: menuTitleGrey
                ),),
              )
            ],
          )
      ),
    );
  }
}