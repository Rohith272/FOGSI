import 'package:flutter/material.dart';
import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/utils/enum.dart';
import 'package:fogsi/view/screens/medication-reference/medication_references_screen.dart';
import 'package:fogsi/view/widgets/banner_carousel.dart';
import 'package:get/get.dart';
import 'package:fogsi/utils/images.dart';
import '../../../controller/main-layout/main_layout_controller.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {

  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dynamicFontSize = (screenWidth < 360) ? screenWidth * 0.033 : 17;
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 313,
              child: BannerCarousel(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      mainLayoutController.stack.add(MedicationReferenceScreen());
                      mainLayoutController.indexStack.add(Screens.medicalReference);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.42,
                      height: MediaQuery.of(context).size.width*0.42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: menuGrey
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 34),
                            child: Image.asset(Images.medicationIcon, width: MediaQuery.of(context).size.width*0.20, height: MediaQuery.of(context).size.width*0.15,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                            child: Text("Medication References", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w500, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: (screenWidth) < 280 ? 1 : 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        // mainLayoutController.stack.add(MedicationReferenceScreen());
                        // mainLayoutController.indexStack.add(Screens.medicalReference);
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.42,
                      height: MediaQuery.of(context).size.width*0.42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: menuGrey
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 34),
                            child: Image.asset(Images.clinicalGuidelinesIcon, width: MediaQuery.of(context).size.width*0.20, height: MediaQuery.of(context).size.width*0.15),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                            child: Text("Clinical Guidelines", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w500, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: (screenWidth) < 280 ? 1 : 2, overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.92,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: pageProminent
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12, top: 16, right: 12),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(Images.ssnppIcon, height: MediaQuery.of(context).size.width*0.15,),
                        ),
                        Expanded(child: Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            "SSNPP App for Cancer Screening",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: tealColor,
                              fontFamily: 'Rubik',
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, top: 12, right: 12),
                    child: Container(
                      child: Text("Swasthya Sunder Nari Prevent the Preventable (SSNPP) app for cervical and breast screening aims to simplify Women’s health screening through connected care.",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: menuTitleGrey,
                            fontFamily: 'Rubik'
                        ),),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 12, right: 12, bottom: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Image.asset(Images.appStoreIcon, width: MediaQuery.of(context).size.width*0.4, height: 48,),
                        ),
                        Spacer(),
                        GestureDetector(
                          child: Image.asset(Images.playStoreIcon, width: MediaQuery.of(context).size.width*0.4, height: 48,),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}