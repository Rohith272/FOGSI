import 'package:flutter/cupertino.dart';
import 'package:fogsi/model/response/list_response.dart';
import 'package:fogsi/model/response/medication_response.dart';
import 'package:fogsi/service/api/api_helper.dart';
import 'package:fogsi/view/widgets/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MedicationReferenceController extends GetxController{

  var records = <MedicationRecords>[].obs;
  List<MedicationRecords>? subTopics = [];
  var countAll = 0.obs;
  var isLoading = false.obs;
  var pageIndex = 1.obs;

  MedicationListResponse? medicationListResponse;

  getMedicationReferences() async {
    if (await checkConnection()){
      Get.to(NoInternetScreenScreen());
    }
    else{
      try {
        MedicationListResponse? response = await APIHelper().getMedicationReference();
        if (response != null) {
          records.value = response.records ?? [];
          countAll.value = records.length;
          medicationListResponse = response;
          return medicationListResponse;
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