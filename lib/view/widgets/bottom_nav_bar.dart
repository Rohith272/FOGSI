import 'package:flutter/material.dart';
import '../../controller/main-layout/main_layout_controller.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import 'package:get/get.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.pageIndex}) : super(key: key);
  final int pageIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
      children: [
        Positioned(child: Container(
          height: 80,
          color: Colors.white,
        )),
        Positioned(child: Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: lightGrey, width: 2)),
            color: Colors.white,
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Image.asset(Images.wellnessIcon,
                      width: 20,
                      height: 20,
                      color: mainLayoutController.currentIndex.value == 0 ? tealColor : darkGrey),
                ),
                label: 'Wellness',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Image.asset(Images.eventIcon,
                      width: 20,
                      height: 20,
                      color: mainLayoutController.currentIndex.value == 1 ? tealColor : darkGrey),
                ),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Image.asset(Images.libraryIcon,
                      width: 20,
                      height: 20,
                      color: mainLayoutController.currentIndex.value == 2 ? tealColor : darkGrey),
                ),
                label: 'Library',
              ),
            ],
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            selectedItemColor: tealColor,
            selectedLabelStyle: const TextStyle(color: tealColor, fontSize: 14, fontWeight: FontWeight.w500),
            unselectedLabelStyle: const TextStyle(color: darkGrey, fontSize: 14, fontWeight: FontWeight.w500),
            unselectedItemColor: darkGrey,
            iconSize: 28,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (int index) {
              setState(() {
                  mainLayoutController.setIndex(index, "", 0);
                  currentIndex = index;
              });
            },
          ),
        ))
      ],
    );
  }
}
