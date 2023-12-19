import 'package:flutter/material.dart';
import 'package:fogsi/main.dart';
import 'package:fogsi/utils/colors.dart';
import 'package:fogsi/view/screens/list/list_layout.dart';
import 'package:fogsi/view/widgets/banner_carousel.dart';
import 'package:fogsi/view/widgets/content_screen.dart';
import 'package:get/get.dart';
import 'package:fogsi/utils/images.dart';
import 'package:fogsi/utils/posters.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../controller/main-layout/main_layout_controller.dart';
import '../../../model/response/banner_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchKeyController = TextEditingController();
  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());
  final _scrollController = ScrollController();
  var isLoading = false.obs;
  var isNormalLoading = true.obs;
  int relationTypeId = 1;
  List<BannerRecords> contentList = <BannerRecords>[];


  setIndex() {
    setState(() {
      mainLayoutController.currentIndex.value = 3;
    });
  }

  @override
  void initState(){
    if (mainLayoutController.indexStack.last != 0){
      setState(() {
        mainLayoutController.addScreen(HomeScreen());
      });
    }
  }

  final List<String> images = [
    Posters.firstPoster,
    Posters.secondPoster,
    Posters.thirdPoster
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dynamicFontSize = (screenWidth < 320) ? screenWidth * 0.033 : 17;
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        controller: _scrollController,
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
                      if (relationTypeId == 1){
                        setState(() {
                          mainLayoutController.setIndex(3, "Safety", 1);
                          mainLayoutController.addScreen(SubTopicScreen());
                        });
                      }else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageCarousel(listId: 1,displayOrder: 1,relationTypeId: 2,),
                          ),
                        );
                      }
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
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(Images.safetyIcon, width: MediaQuery.of(context).size.width*0.30, height: MediaQuery.of(context).size.width*0.30,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 10, right: 10),
                            child: Text("Safety", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w600, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: 1, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        mainLayoutController.setIndex(3, "Contraception", 2);
                        mainLayoutController.addScreen(SubTopicScreen());
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
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(Images.contraceptionIcon, width: MediaQuery.of(context).size.width*0.30, height: MediaQuery.of(context).size.width*0.30,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 10, right: 10),
                            child: Text("Contraception", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w600, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: 1, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                      setState(() {
                        mainLayoutController.setIndex(3, "Nutrition", 3);
                        mainLayoutController.addScreen(SubTopicScreen());
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
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(Images.nutritionMenuIcon, width: MediaQuery.of(context).size.width*0.30, height: MediaQuery.of(context).size.width*0.30),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 10, right: 10),
                            child: Text("Nutrition", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w600, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: 1, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        mainLayoutController.setIndex(3, "Yoga & Exercise", 4);
                        mainLayoutController.addScreen(SubTopicScreen());
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
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(Images.yogaMenuIcon, width: MediaQuery.of(context).size.width*0.30, height: MediaQuery.of(context).size.width*0.30,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 10, right: 10,),
                            child: Text("Yoga & Exercise", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w600, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: 1, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                      setState(() {
                        mainLayoutController.setIndex(3, "Adolescent Health", 5);
                        mainLayoutController.addScreen(SubTopicScreen());
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
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(Images.adolescentMenuIcon, width: MediaQuery.of(context).size.width*0.30, height: MediaQuery.of(context).size.width*0.30,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 10, right: 10),
                            child: Text("Adolescent Health", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w600, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: 1, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        mainLayoutController.setIndex(3, "Pregnancy", 6);
                        mainLayoutController.addScreen(SubTopicScreen());
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
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(Images.pregnancyMenuIcon, width: MediaQuery.of(context).size.width*0.30, height: MediaQuery.of(context).size.width*0.30,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 10, right: 10),
                            child: Text("Pregnancy", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w600, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: 1, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                      setState(() {
                        mainLayoutController.setIndex(3, "Menstruation", 7);
                        mainLayoutController.addScreen(SubTopicScreen());
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
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(Images.menstruationMenuIcon, width: MediaQuery.of(context).size.width*0.30, height: MediaQuery.of(context).size.width*0.30,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 10, right: 10),
                            child: Text("Menstruation", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w600, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: 1, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        mainLayoutController.setIndex(3, "Menopause", 8);
                        mainLayoutController.addScreen(SubTopicScreen());
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
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(Images.menopauseMenuIcon, width: MediaQuery.of(context).size.width*0.30, height: MediaQuery.of(context).size.width*0.30,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 10, right: 10),
                            child: Text("Menopause", style: TextStyle(fontSize: dynamicFontSize, fontWeight: FontWeight.w600, color: menuTitleGrey, fontFamily: 'Rubik'),maxLines: 1, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// class ImageCarousel extends StatefulWidget {
//   final List<String> images;
//   final List<BannerRecords> contentList;
//
//   ImageCarousel({
//     required this.images,
//     required this.contentList
//   });
//
//   @override
//   _ImageCarouselState createState() => _ImageCarouselState();
// }
//
// class _ImageCarouselState extends State<ImageCarousel> {
//   int _currentIndex = 0;
//   final MainLayoutController mainLayoutController = Get.put(MainLayoutController());
//   var isLoading = false.obs;
//   var isNormalLoading = true.obs;
//   List<BannerRecords> contentList = <BannerRecords>[];
//
//   @override
//   void initState(){
//     contentList = [];
//     getAndPrefillData();
//     setState(() {
//
//     });
//   }
//
//   Future<void> getAndPrefillData() async {
//     await mainLayoutController.getBanner(1);
//     List<BannerRecords> tList = [];
//     for (int i = 0; i < mainLayoutController.records.length; i++) {
//       tList.add(mainLayoutController.bannerRecords[i]);
//     }
//     contentList.addAll(tList);
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider(
//           items: contentList.map((record) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               child: Image.asset(record.imageUrl ?? '', fit: BoxFit.fill),
//             );
//           }).toList(),
//           options: CarouselOptions(
//             height: 200,
//             autoPlay: true,
//             enlargeCenterPage: true,
//             aspectRatio: 16 / 9,
//             enableInfiniteScroll: true,
//             viewportFraction: 1,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(
//             contentList.length,
//                 (index) => buildIndicator(index),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildIndicator(int index) {
//     return Container(
//       width: _currentIndex == index ? 14.0 : 8,
//       height: 8.0,
//       margin: const EdgeInsets.symmetric(horizontal: 4.0),
//       decoration: BoxDecoration(
//         shape: _currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
//         borderRadius: _currentIndex == index ? const BorderRadius.all(Radius.circular(4)): null,
//         color: _currentIndex == index ? Colors.teal : Colors.grey,
//       ),
//     );
//   }
// }



