import 'package:flutter/cupertino.dart';
import 'package:fogsi/model/response/list_response.dart';
import 'package:fogsi/service/api/api_helper.dart';
import 'package:fogsi/view/widgets/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SubTopicListLayoutController extends GetxController{

  var records = <Records>[].obs;
  List<Records>? subTopics = [];
  var filteredProducts = <Records>[].obs;
  var countAll = 0.obs;
  var isLoading = false.obs;
  var pageIndex = 1.obs;

  ListResponse? subTopicListResponse;

  getSubTopics(int menuId) async {
    if (await checkConnection()){
      Get.to(NoInternetScreenScreen());
    }
    else{
        try {
          ListResponse? response = await APIHelper().getData(menuId);
          if (response != null) {
            records.value = response.records ?? [];
            countAll.value = records.length;
            subTopicListResponse = response;
            return subTopicListResponse;
          }
        } catch (e) {
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
}