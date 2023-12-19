import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:fogsi/controller/main-layout/main_layout_controller.dart';
import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/utils/components_list.dart';
import 'package:fogsi/utils/enum.dart';
import 'package:fogsi/utils/images.dart';
import 'package:fogsi/view/screens/search/search_result.dart';
import 'package:fogsi/view/widgets/custom_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:fogsi/view/widgets/custom_search_bar.dart';

import '../screens/home/regular_home.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({Key? key}) : super(key: key);

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen>{

  TextEditingController searchKeyController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final List<Widget> components= ComponentList.components;
  @override
  void initState(){
    super.initState();
    setState(() {
      mainLayoutController.isSearch.value = false;
      mainLayoutController.stack.add(HomeScreen());
      mainLayoutController.indexStack.add(0);
    });
  }
  FocusNode _focusNode = FocusNode();

  Future<void> onWillPop() async {
    mainLayoutController.isSearch.value = false;
    searchKeyController.clear();
    if (mainLayoutController.stack.length == 1 || mainLayoutController.indexStack.last == Screens.home || mainLayoutController.indexStack.last == Screens.doctor) {
      exit(0);
    } else {
      // Otherwise, remove the last screen from the stack
      mainLayoutController.stack.removeLast();
      mainLayoutController.indexStack.removeLast();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context){
    return PopScope(
        canPop: mainLayoutController.stack.length < 1, onPopInvoked: (bool didPop){
      onWillPop();
      if (didPop){
        return;
      }
    },
        child: Scaffold(

      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 70,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 12),
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                width: MediaQuery.of(context).size.width*0.8,
                child: CustomSearchField(
                  hintText: "Search for wellness tips, etc",
                  textEditingController: searchKeyController,
                  prefixIcon: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      setState(() {
                        mainLayoutController.isSearch.value = true;
                      });
                      _focusNode.requestFocus();
                      if(!searchKeyController.text.isEmpty){
                        await mainLayoutController.getSearchResult(searchKeyController.text);
                        mainLayoutController.setIndex(7, "", 1);
                        mainLayoutController.stack.add(SearchResultScreen());
                        mainLayoutController.indexStack.add(7);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 2, bottom: 2),
                      child: SvgPicture.asset( mainLayoutController.isSearch.value ? Images.activeSearchIcon : Images.inActiveSearchIcon, height: 40, width: 40,),
                    ),
                    ),
                  suffixIcon: mainLayoutController.isSearch.value ? IconButton(
                    onPressed: () async {
                      setState(() {
                        mainLayoutController.isSearch.value = true;
                      });
                      searchKeyController.clear();
                    },
                    icon: const Icon(Icons.restart_alt_sharp),
                    color: minContrastGrey,
                    iconSize: 25,
                  ) : null,
                  onPressed: (){
                    setState(() {
                      mainLayoutController.isSearch.value = true;
                    });
                  },
                  onSubmitted: (String value) async {
                    if(!searchKeyController.text.isEmpty){
                      await mainLayoutController.getSearchResult(value);
                      setState(() {
                        mainLayoutController.isSearch.value = true;
                      });
                      mainLayoutController.setIndex(7, "", 1);
                      mainLayoutController.stack.add(SearchResultScreen());
                      mainLayoutController.indexStack.add(7);
                    }
                  },
                )),
            if (mainLayoutController.isSearch.value) Container(
              height: 60,
              width: MediaQuery.of(context).size.width*0.15,
              child: IconButton(onPressed: (){
                setState(() {
                  mainLayoutController.isSearch.value = false;
                  FocusScope.of(context).unfocus();
                  print(mainLayoutController.indexStack.last);
                  if (mainLayoutController.indexStack.last == 7){
                    mainLayoutController.removeScreen();
                    mainLayoutController.setIndex(0, "hai", 1);
                  }
                  searchKeyController.clear();
                });

              },icon: Image.asset(Images.closeIcon),iconSize: 400,color: Colors.teal,),
            )
            else Container(
              height: 60,
              width: MediaQuery.of(context).size.width*0.15,
              child: IconButton(
                onPressed: (){
                  setState(() {
                    mainLayoutController.toggleMode();
                  });
                },
                icon: SvgPicture.asset( mainLayoutController.isDoctor.value ? Images.doctorMode : Images.publicMode,),iconSize: 400,color: Colors.teal,),
            )
          ],
        ),
      ),
      body: Obx(() => mainLayoutController.stack.last),
      // bottomNavigationBar: BottomNavBar(pageIndex: mainLayoutController.currentIndex.value),
      bottomNavigationBar: CustomBottomNavBar(pageIndex: mainLayoutController.currentIndex.value),
    ));
  }

}
