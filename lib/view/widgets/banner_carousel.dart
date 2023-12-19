import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fogsi/controller/main-layout/main_layout_controller.dart';
import 'package:fogsi/utils/posters.dart';
import 'package:fogsi/view/widgets/content_screen.dart';
import 'package:fogsi/view/widgets/custom_loading_indicator.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../model/response/banner_response.dart';

class BannerCarousel extends StatefulWidget {


  BannerCarousel({super.key, });

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;
  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());

  List<BannerRecords> contentList = <BannerRecords>[];
  bool isLoadingImages = true;
  bool isLoading = false;

  @override
  void initState(){
    contentList = [];
    getAndPrefillData();
  }

  Future<void> getAndPrefillData() async {
    isLoading = true;
    await mainLayoutController.getBanner(mainLayoutController.isDoctor.value ? 2 : 1);
    // await mainLayoutController.fetchImage("1");
    List<BannerRecords> tList = [];
    for (int i = 0; i < mainLayoutController.bannerRecords.length; i++) {
      tList.add(mainLayoutController.bannerRecords[i]);
    }
    contentList.addAll(tList);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(
      child: CustomLoadingIndicator(),
    ) :
    Column(
      children: [
        CarouselSlider(
          items: contentList.map((record) {
            return GestureDetector(
              onTap: (){
                if (record.relationTypeId == 1 ){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageCarousel(listId: record.listId ?? 0,displayOrder: 1,relationTypeId: record.relationTypeId ?? 0,),
                    ),
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: record.imageUrl ?? '',
                  placeholder: (context, url) => CustomLoadingIndicator(),
                ), // Replace with your placeholder widget
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 288,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            contentList.length,
                (index) => buildIndicator(index),
          ),
        ),
      ],
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: _currentIndex == index ? 14.0 : 8,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: _currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: _currentIndex == index
            ? const BorderRadius.all(Radius.circular(4))
            : null,
        color: _currentIndex == index ? Colors.teal : Colors.grey,
      ),
    );
  }

}


// CarouselSlider(
// items: preloadedImages.asMap().entries.map((entry) {
// int index = entry.key;
// Uint8List? imageBytes = entry.value;
// return GestureDetector(
// onTap: (){
// },
// child: Container(
// width: MediaQuery.of(context).size.width,
// child: imageBytes != null
// ? Image.memory(imageBytes, fit: BoxFit.fill)
//     : Placeholder(), // Replace with your placeholder widget
// ),
// );
// }).toList(),
// options: CarouselOptions(
// height: 288,
// autoPlay: true,
// enlargeCenterPage: true,
// aspectRatio: 16 / 9,
// enableInfiniteScroll: true,
// viewportFraction: 1,
// onPageChanged: (index, reason) {
// setState(() {
// _currentIndex = index;
// });
// },
// ),
// ),