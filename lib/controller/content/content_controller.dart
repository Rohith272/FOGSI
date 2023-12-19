import 'package:flutter/cupertino.dart';
import 'package:fogsi/service/api/api_helper.dart';
import 'package:get/get.dart';

import '../../model/response/content_response.dart';

class ContentController extends GetxController{

  var records = <Records>[].obs;
  List<Records>? contentList = [];
  var isLoading = true.obs;

  ContentResponse? contentResponse;

  getContent(int listId, int relationTypeId) async {
    try{
      ContentResponse? response;
      if(relationTypeId == 1){
        response = await APIHelper().getContent(listId);
      }else{
        response = await APIHelper().getTopicContent(1);
      }
      if(response != null){
        records.value = response.records ?? [];
        contentResponse = response;
        return contentResponse;
      }
    } catch(e){
      debugPrint(e.toString());
    }
  }
}