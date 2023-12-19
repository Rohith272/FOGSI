import 'package:flutter/cupertino.dart';
import 'package:fogsi/model/response/events_response.dart';
import 'package:fogsi/service/api/api_helper.dart';
import 'package:fogsi/utils/constants.dart';
import 'package:get/get.dart';
import 'package:fogsi/view/widgets/no_internet_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../main-layout/main_layout_controller.dart';


class EventsController extends GetxController{

  var records = <EventRecords>[].obs;
  List<EventRecords>? contentList = [];
  var isLoading = false.obs;
  var hasOngoing = false.obs;
  EventsResponse? eventsResponse;
  var showGoToTopButton = false.obs;
  final MainLayoutController mainLayoutController = Get.put(MainLayoutController());

  getEvents() async {
    if (await checkConnection()){
      Get.to(NoInternetScreenScreen());
    } else {
      try {
        hasOngoing.value = false;
        EventsResponse? response = await APIHelper().getEvents();
        if (response != null) {
          records.value = response.records ?? [];
          eventsResponse = response;
          await hasOngoingEvent(records);
          return eventsResponse;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  hasOngoingEvent(List<EventRecords> records) async{
    for (EventRecords record in records) {
      if (isToday(record.eventStartDate ?? '')){
        hasOngoing.value = true;
      }
    }
    return null;
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