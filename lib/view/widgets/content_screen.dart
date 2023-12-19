import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fogsi/view/widgets/custom_loading_indicator.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fogsi/controller/content/content_controller.dart';
import '../../model/response/content_response.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageCarousel extends StatefulWidget {
  final int listId;
  final int displayOrder;
  final int relationTypeId;

  const ImageCarousel({
    super.key,
    required this.listId,
    required this.displayOrder,
    required this.relationTypeId
  });

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;
  List<Records> contentList = <Records>[];
  var isLoading = false.obs;
  bool isLastSlide = false;

  final ContentController productController = Get.put(ContentController());
  final CarouselController _carouselController = CarouselController();

  @override
  void initState(){
    this._currentIndex = widget.displayOrder - 1 ;
    contentList = [];
    getAndPrefillData();
  }

  Future<void> getAndPrefillData() async {
    isLoading.value = true;
    await productController.getContent(widget.listId, widget.relationTypeId);
    List<Records> tList = [];
    for (int i = 0; i < productController.records.length; i++) {
      tList.add(productController.records[i]);
    }
    contentList.addAll(tList);
    // _carouselController.jumpToPage(_currentIndex);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.close_rounded, color: Colors.white, size: 40,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 45),
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
          color: Colors.black
        ),
       itemCount: contentList.length, builder: (BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
        imageProvider: NetworkImage(contentList[index].imageUrl ?? ''),
        heroAttributes: PhotoViewHeroAttributes(tag: index));
    },onPageChanged: (index){
    _currentIndex = index;
    isLastSlide = index == contentList.length - 1;
    },
    ),),
      bottomSheet: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height*0.04,
        child: buildIndicator(),
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        contentList.length,
            (index) => buildDot(index),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      width: _currentIndex == index ? 12.0 : 8,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: _currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: _currentIndex == index ? BorderRadius.all(Radius.circular(4)): null,
        color: _currentIndex == index ? Colors.white : Colors.grey,
      ),
    );
  }
}
