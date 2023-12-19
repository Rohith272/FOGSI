import 'package:flutter/material.dart';
import 'package:fogsi/utils/enum.dart';
import 'package:fogsi/view/screens/events/events_page.dart';
import 'package:fogsi/view/screens/faq/faq_screen.dart';
import 'package:fogsi/view/screens/home/doctor_home.dart';
import 'package:fogsi/view/screens/home/regular_home.dart';
import 'package:fogsi/view/screens/library/library_page.dart';
import '../../controller/main-layout/main_layout_controller.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import 'package:get/get.dart';


class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({Key? key, required this.pageIndex}) : super(key: key);
  final int pageIndex;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70,
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: darkGrey,
                    width: 1
                )
            ),
            color: Colors.transparent,
          ),
        ),
        Container(
          // decoration: const BoxDecoration(
          //   border: Border(
          //       top: BorderSide(
          //           color: darkGrey,
          //           width: 1
          //       )
          //   ),
          //   color: Colors.transparent,
          // ),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (mainLayoutController.isDoctor.value)
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    if (mainLayoutController.indexStack.last != Screens.doctor){
                      mainLayoutController.stack.add(DoctorHomeScreen());
                      mainLayoutController.indexStack.add(Screens.doctor);
                    }
                    mainLayoutController.setIndex(Screens.doctor, "", 0);
                    currentIndex = Screens.doctor;
                    setState(() {});
                  },
                  child: Container(
                      height: 70,
                      width: 64,
                      child: Center(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: mainLayoutController.indexStack.last == Screens.doctor ? tealColor : Colors.transparent,
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3))
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                width: 64,
                                height: 5,
                              ),
                              Container(
                                  child: Image.asset(
                                    mainLayoutController.indexStack.last == Screens.doctor ? Images.doctorHomeActiveIcon : Images.doctorHomeIcon,
                                    height: 20,
                                    width: 20,)
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text("Resources",
                                  style:
                                  TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Rubik',
                                      color: mainLayoutController.indexStack.last == Screens.doctor ? tealColor : darkGrey),maxLines: 1, overflow: TextOverflow.ellipsis,),
                              )
                            ],
                          )
                      )
                  ),
                ),
              if (!mainLayoutController.isDoctor.value)
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    if (mainLayoutController.indexStack.last != 0){
                      mainLayoutController.stack.add(HomeScreen());
                      mainLayoutController.indexStack.add(0);
                    }
                    mainLayoutController.setIndex(0, "", 0);
                    currentIndex = 0;
                    print(mainLayoutController.currentIndex.value);
                    setState(() {});
                  },
                  child: Container(
                      height: 70,
                      width: 64,
                      child: Center(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color:  mainLayoutController.indexStack.last == 0 ? tealColor : Colors.transparent,
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3))
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                width: 64,
                                height: 5,
                              ),
                              Container(
                                  child: Image.asset(
                                    mainLayoutController.indexStack.last == 0 ? Images.wellnessActiveIcon : Images.wellnessIcon,
                                    height: 20,
                                    width: 20,)
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text("Wellness",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Rubik',
                                      color: mainLayoutController.indexStack.last == 0 ? Colors.teal : darkGrey),maxLines: 1, overflow: TextOverflow.ellipsis,),
                              )
                            ],
                          )
                      )
                  ),
                ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  if (mainLayoutController.indexStack.last != 1){
                    mainLayoutController.stack.add(EventsScreen());
                    mainLayoutController.indexStack.add(1);
                  }
                  mainLayoutController.setIndex(1, "", 0);
                  currentIndex = 1;
                  setState(() {});
                },
                child: Container(
                    height: 70,
                    width: 64,
                    child: Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: mainLayoutController.indexStack.last == 1 ? tealColor : Colors.transparent,
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3))
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              width: 64,
                              height: 5,
                            ),
                            Container(
                                child: Image.asset(
                                  mainLayoutController.indexStack.last == 1 ? Images.eventActiveIcon : Images.eventIcon,
                                  height: 20,
                                  width: 20,
                                )
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              child: Text("Events",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Rubik',
                                    color: mainLayoutController.indexStack.last == 1 ? tealColor : darkGrey),maxLines: 1, overflow: TextOverflow.ellipsis,),
                            )
                          ],
                        )
                    )
                ),
              ),
              if (!mainLayoutController.isDoctor.value)
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    if (mainLayoutController.indexStack.last != 2){
                      mainLayoutController.stack.add(LibraryScreen());
                      mainLayoutController.indexStack.add(2);
                    }
                    mainLayoutController.setIndex(2, "", 0);
                    currentIndex = 2;
                    setState(() {});
                  },
                  child: Container(
                      height: 70,
                      width: 64,
                      child: Center(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: mainLayoutController.indexStack.last == 2 ? tealColor : Colors.transparent,
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3))
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                width: 64,
                                height: 5,
                              ),
                              Container(
                                  child: Image.asset(
                                    mainLayoutController.indexStack.last == 2 ? Images.libraryActiveIcon : Images.libraryIcon,
                                    height: 20,
                                    width: 20,)
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text("Library",
                                  style:
                                  TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Rubik',
                                      color: mainLayoutController.indexStack.last == 2 ? tealColor : darkGrey),maxLines: 1, overflow: TextOverflow.ellipsis,),
                              )
                            ],
                          )
                      )
                  ),
                ),
              if (mainLayoutController.isDoctor.value)
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    if (mainLayoutController.indexStack.last != Screens.faqScreen){
                      mainLayoutController.stack.add(FaqScreen());
                      mainLayoutController.indexStack.add(Screens.faqScreen);
                    }
                    mainLayoutController.setIndex(Screens.faqScreen, "", 0);
                    currentIndex = Screens.faqScreen;
                    setState(() {});
                  },
                  child: Container(
                      height: 70,
                      width: 64,
                      child: Center(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: mainLayoutController.indexStack.last == Screens.faqScreen ? tealColor : Colors.transparent,
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3))
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                width: 64,
                                height: 5,
                              ),
                              Container(
                                  child: Image.asset(
                                    mainLayoutController.indexStack.last == Screens.faqScreen ? Images.faqActiveIcon : Images.faqInActiveIcon,
                                    height: 20,
                                    width: 20,)
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text("FAQ",
                                  style:
                                  TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Rubik',
                                      color: mainLayoutController.indexStack.last == Screens.faqScreen ? tealColor : darkGrey),),
                              )
                            ],
                          )
                      )
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
