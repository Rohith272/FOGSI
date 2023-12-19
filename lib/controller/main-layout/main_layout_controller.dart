
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fogsi/model/response/fetch_file_response.dart';
import 'package:fogsi/model/response/search_result_response.dart';
import 'package:fogsi/model/response/segment_response_list.dart';
import 'package:fogsi/service/api/api_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fogsi/utils/enum.dart';
import 'package:fogsi/view/screens/home/doctor_home.dart';
import 'package:fogsi/view/screens/home/regular_home.dart';
import 'package:fogsi/view/widgets/no_internet_screen.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../../model/response/banner_response.dart';

class MainLayoutController extends GetxController{
  var currentIndex = 0.obs;
  var title = "".obs;
  var menuId = 1.obs;
  var records = <Records>[].obs;
  var searchRecords = <SearchRecords>[].obs;
  var bannerRecords = <BannerRecords>[].obs;
  var countAll = 0.obs;
  var isLoading = false.obs;
  var pageIndex = 1.obs;
  var isDoctor = false.obs;
  var isSearch = true.obs;
  var indexStack = <int>[].obs;
  var stack = <Widget>[].obs;


  BannerResponse? bannerResponse;
  SegmentListResponse? segmentListResponse;
  SearchResultResponse? searchResultResponse;

  setIndex(int index, String title, int menuId){
    currentIndex.value = index;
    this.menuId.value = menuId;
    if (index > 2){
      this.title.value = title ?? "";
    }
  }

  // getSubTopics(int menuId) async {
  //   try{
  //     SegmentListResponse? response = await APIHelper().getSegment();
  //     if(response != null){
  //       records.value = response.records ?? [];
  //       countAll.value = records.length;
  //       segmentListResponse = response;
  //       return segmentListResponse;
  //     }
  //   } catch(e){
  //     debugPrint(e.toString());
  //   }
  // }

  removeScreen(){
    stack.removeLast();
    indexStack.removeLast();
    print(indexStack.last);
  }

  getBanner(int userTypeId) async {
    try{
      BannerResponse? response = await APIHelper().getBanner(userTypeId);
      if(response != null){
        bannerRecords.value = response.records ?? [];
        bannerResponse = response;
        return bannerResponse;
      }
    } catch(e){
      debugPrint(e.toString());
    }
  }

  addScreen(Widget screen){
    stack.add(screen);
    indexStack.add(5);
  }

  Future<Uint8List> fetchImage(String fileId) async {
    try {
      FetchFileResponse? response = await APIHelper().fetchFile(fileId);
      if (response != null && response.isSuccess == true) {
        Uint8List imageBytes = base64.decode(response.contents);
        return imageBytes;
      } else {
        throw Exception("Failed to fetch image");
      }
    } catch (e) {
      throw Exception("Failed to fetch image");
    }
  }

  getSearchResult(String searchKey) async{
    if (await checkConnection()){
      searchRecords.clear();
      Get.to(NoInternetScreenScreen());
    }else{
      searchRecords.value = [];
      try{
        SearchResultResponse? response = await APIHelper().getSearchResult(searchKey);
        if(response != null){
          searchRecords.value = response.records ?? [];
          countAll.value = records.length;
          searchResultResponse = response;
          return searchResultResponse;
        }
      } catch(e){
        debugPrint(e.toString());
      }
    }
  }

  checkConnection() async{
      final connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none){
        return true;
      }
      else{
        return false;
      }
  }

  toggleMode() async {
    if (isDoctor.value){
      isDoctor.value = false;
      indexStack.add(Screens.home);
      stack.add(HomeScreen());
    }else{
      isDoctor.value = true;
      indexStack.add(Screens.doctor);
      stack.add(DoctorHomeScreen());
    }
  }
}