import 'dart:async';
import 'dart:convert';
import 'package:fogsi/model/response/events_response.dart';
import 'package:fogsi/model/response/fetch_file_response.dart';
import 'package:fogsi/model/response/medication_response.dart';
import 'package:fogsi/model/response/search_result_response.dart';
import 'package:fogsi/service/api/exception_handler.dart';
import 'package:http/http.dart';
import 'package:fogsi/model/response/content_response.dart';
import 'package:fogsi/model/response/segment_response_list.dart';
import 'package:fogsi/model/response/list_response.dart';
import 'package:fogsi/service/api/api_service.dart';
import 'package:fogsi/service/api/api_urls.dart';

import '../../model/response/banner_response.dart';

class APIHelper{
  String baseUrl = APIUrls.devURL;
  final Map<String, String> headers = {'Content-Type':'application/json'};

  Future<ListResponse?> getData(int menuId) async{
    try {
      final String url = baseUrl + APIUrls.search;
      String body = json.encode({
        "conditions": [
          {
            "andOrParentheses": "AND",
            "isParentheses": false,
            "fieldID": 3,
            "fieldName": "ParentTopicId",
            "displayName": "",
            "displayValue":"",
            "fieldValue": menuId.toString(),
            "operator": "=",
            "useValueAsField": false,
            "toggleValue": false
          },
        ],
        "generateDisplaySearchCriteria": true,
        "includeRecordId": true,
        "isAdvancedSearch": false,
        "isAscendingSort": true,
        "pageIndex": 1,
        "pageSize": 20,
        "quickSearchFieldNameList": [],
        "quickSearchText": "",
        "recordKeyFieldNames": [],
        "resultFieldNameList": [],
        "returnOnlyRecordCount": false,
        "searchTypeID": 1,
        "sortFieldName": ""
      });

      headers['Authorization'] = "c1eb523b-e917-4595-a661-000076c9fb09";
      Response? response = await APIService().postAPICall(url,body, headers);
      var responseData = json.decode(response!.body);

      if (response.statusCode == 200) {
        return ListResponse.fromJson(responseData);
      } else if (responseData != null &&
          responseData.contains("errorMessage")) {
        // showToast(message: responseData["errorMessage"]);
        return null;
      } else {
        // showToast(message: "Something went wrong!");
      }
      return null;
    } catch(e){
      print("Error type: ${e.runtimeType..toString()}");
      // String errorMessage = ExceptionHandlers().getExceptionString(e);
      // showToast(message: errorMessage);
      // print("API error: $errorMessage");
      // if (e is FormatException) {
      //   goToLogin();
      // }
    }
    return null;
  }

  Future<SegmentListResponse?> getSegment() async{
    try {
      final String url = baseUrl + APIUrls.search;
      String body = json.encode({
        "conditions": [],
        "generateDisplaySearchCriteria": true,
        "includeRecordId": true,
        "isAdvancedSearch": false,
        "isAscendingSort": true,
        "kanbanMode": false,
        "pageIndex": 1,
        "pageSize": 20,
        "quickSearchFieldNameList": [],
        "quickSearchText": "",
        "recordKeyFieldNames": [],
        "resultFieldNameList": [],
        "returnOnlyRecordCount": false,
        "searchTypeID": 66,
        "sortFieldName": ""
      });

      headers['Authorization'] = "c1eb523b-e917-4595-a661-000076c9fb09";
      Response? response = await APIService().postAPICall(url,body, headers);
      var responseData = json.decode(response!.body);

      if (response.statusCode == 200) {
        return SegmentListResponse.fromJson(responseData);
      } else if (responseData != null &&
          responseData.contains("errorMessage")) {
        // showToast(message: responseData["errorMessage"]);
        return null;
      } else {
        // showToast(message: "Something went wrong!");
      }
      return null;
    } catch(e){
      print("Error type: ${e.runtimeType..toString()}");
      // String errorMessage = ExceptionHandlers().getExceptionString(e);
      // showToast(message: errorMessage);
      // print("API error: $errorMessage");
      // if (e is FormatException) {
      //   goToLogin();
      // }
    }
    return null;
  }

  Future<ContentResponse?> getContent(int menuId) async{
    try {
      final String url = baseUrl + APIUrls.search;

      String body = json.encode({
        "conditions": [
          {
            "andOrParentheses": "AND",
            "isParentheses": false,
            "fieldID": 9,
            "fieldName": "ListId",
            "displayName": "",
            "displayValue":"",
            "fieldValue": menuId.toString(),
            "operator": "=",
            "useValueAsField": false,
            "toggleValue": false
          },
        ],
        "generateDisplaySearchCriteria": true,
        "includeRecordId": true,
        "isAdvancedSearch": false,
        "isAscendingSort": true,
        "pageIndex": 1,
        "pageSize": 50,
        "quickSearchFieldNameList": [],
        "quickSearchText": "",
        "recordKeyFieldNames": [],
        "resultFieldNameList": [],
        "returnOnlyRecordCount": false,
        "searchTypeID": 2,
        "sortFieldName": ""
      });

      headers['Authorization'] = "c1eb523b-e917-4595-a661-000076c9fb09";
      Response? response = await APIService().postAPICall(url,body, headers);
      var responseData = json.decode(response!.body);

      if (response.statusCode == 200) {
        return ContentResponse.fromJson(responseData);
      } else if (responseData != null &&
          responseData.contains("errorMessage")) {
        // showToast(message: responseData["errorMessage"]);
        return null;
      } else {
        // showToast(message: "Something went wrong!");
      }
      return null;
    } catch(e){
      print("Error type: ${e.runtimeType..toString()}");
      // String errorMessage = ExceptionHandlers().getExceptionString(e);
      // showToast(message: errorMessage);
      // print("API error: $errorMessage");
      // if (e is FormatException) {
      //   goToLogin();
      // }
    }
    return null;
  }

  Future<ContentResponse?> getTopicContent(int menuId) async{
    try {
      final String url = baseUrl + APIUrls.search;

      String body = json.encode({
        "conditions": [
          {
            "andOrParentheses": "AND",
            "isParentheses": false,
            "fieldID": 18,
            "fieldName": "",
            "displayName": "",
            "displayValue":"",
            "fieldValue": menuId.toString(),
            "operator": "=",
            "useValueAsField": false,
            "toggleValue": false
          },
        ],
        "generateDisplaySearchCriteria": true,
        "includeRecordId": true,
        "isAdvancedSearch": false,
        "isAscendingSort": true,
        "pageIndex": 1,
        "pageSize": 50,
        "quickSearchFieldNameList": [],
        "quickSearchText": "",
        "recordKeyFieldNames": [],
        "resultFieldNameList": [],
        "returnOnlyRecordCount": false,
        "searchTypeID": 6,
        "sortFieldName": ""
      });

      headers['Authorization'] = "c1eb523b-e917-4595-a661-000076c9fb09";
      Response? response = await APIService().postAPICall(url,body, headers);
      var responseData = json.decode(response!.body);

      if (response.statusCode == 200) {
        return ContentResponse.fromJson(responseData);
      } else if (responseData != null &&
          responseData.contains("errorMessage")) {
        // showToast(message: responseData["errorMessage"]);
        return null;
      } else {
        // showToast(message: "Something went wrong!");
      }
      return null;
    } catch(e){
      print("Error type: ${e.runtimeType..toString()}");
      // String errorMessage = ExceptionHandlers().getExceptionString(e);
      // showToast(message: errorMessage);
      // print("API error: $errorMessage");
      // if (e is FormatException) {
      //   goToLogin();
      // }
    }
    return null;
  }

  Future<BannerResponse?> getBanner(int userTypeId) async{
    try {
      final String url = baseUrl + APIUrls.search;
      String body = json.encode({
        "conditions": [
          {
            "andOrParentheses": "AND",
            "isParentheses": false,
            "fieldID":11,
            "fieldName": "UserTypeId",
            "displayName": "",
            "displayValue":"",
            "fieldValue": userTypeId.toString(),
            "operator": "=",
            "useValueAsField": false,
            "toggleValue": false
          },
        ],
        "generateDisplaySearchCriteria": true,
        "includeRecordId": true,
        "isAdvancedSearch": false,
        "isAscendingSort": true,
        "pageIndex": 1,
        "pageSize": 50,
        "quickSearchFieldNameList": [],
        "quickSearchText": "",
        "recordKeyFieldNames": [],
        "resultFieldNameList": [],
        "returnOnlyRecordCount": false,
        "searchTypeID": 3,
        "sortFieldName": ""
      });

      headers['Authorization'] = "c1eb523b-e917-4595-a661-000076c9fb09";
      Response? response = await APIService().postAPICall(url,body, headers);
      var responseData = json.decode(response!.body);

      if (response.statusCode == 200) {
        return BannerResponse.fromJson(responseData);
      } else if (responseData != null &&
          responseData.contains("errorMessage")) {
        // showToast(message: responseData["errorMessage"]);
        return null;
      } else {
        // showToast(message: "Something went wrong!");
      }
      return null;
    } catch(e){
      print("Error type: ${e.runtimeType..toString()}");
      // String errorMessage = ExceptionHandlers().getExceptionString(e);
      // showToast(message: errorMessage);
      // print("API error: $errorMessage");
      // if (e is FormatException) {
      //   goToLogin();
      // }
    }
    return null;
  }

  Future<EventsResponse?> getEvents() async{
    try {
      final String url = baseUrl + APIUrls.search;
      String body = json.encode({
        "conditions": [],
        "generateDisplaySearchCriteria": true,
        "includeRecordId": true,
        "isAdvancedSearch": false,
        "isAscendingSort": true,
        "pageIndex": 1,
        "pageSize": 500,
        "quickSearchFieldNameList": [],
        "quickSearchText": "",
        "recordKeyFieldNames": [],
        "resultFieldNameList": [],
        "returnOnlyRecordCount": false,
        "searchTypeID": 4,
        "sortFieldName": "EventStartDate"
      });

      headers['Authorization'] = "c1eb523b-e917-4595-a661-000076c9fb09";
      Response? response = await APIService().postAPICall(url,body, headers);
      var responseData = json.decode(response!.body);

      if (response.statusCode == 200) {
        return EventsResponse.fromJson(responseData);
      } else if (responseData != null &&
          responseData.contains("errorMessage")) {
        // showToast(message: responseData["errorMessage"]);
        return null;
      } else {
        // showToast(message: "Something went wrong!");
      }
      return null;
    } catch(e){
      print("Error type: ${e.runtimeType..toString()}");
      String errorMessage = ExceptionHandlers().getExceptionString(e);
      // showToast(message: errorMessage);
      print("API error: $errorMessage");
      // if (e is FormatException) {
      //   goToLogin();
      // }
    }
    return null;
  }

  Future<MedicationListResponse?> getMedicationReference() async{
    try {
      final String url = baseUrl + APIUrls.search;

      String body = json.encode({
        "conditions": [],
        "generateDisplaySearchCriteria": true,
        "includeRecordId": true,
        "isAdvancedSearch": false,
        "isAscendingSort": true,
        "pageIndex": 1,
        "pageSize": 50,
        "quickSearchFieldNameList": [],
        "quickSearchText": "",
        "recordKeyFieldNames": [],
        "resultFieldNameList": [],
        "returnOnlyRecordCount": false,
        "searchTypeID": 7,
        "sortFieldName": "MedicineName"
      });

      headers['Authorization'] = "c1eb523b-e917-4595-a661-000076c9fb09";
      Response? response = await APIService().postAPICall(url,body, headers);
      var responseData = json.decode(response!.body);

      if (response.statusCode == 200) {
        return MedicationListResponse.fromJson(responseData);
      } else if (responseData != null &&
          responseData.contains("errorMessage")) {
        // showToast(message: responseData["errorMessage"]);
        return null;
      } else {
        // showToast(message: "Something went wrong!");
      }
      return null;
    } catch(e){
      print("Error type: ${e.runtimeType..toString()}");
      // String errorMessage = ExceptionHandlers().getExceptionString(e);
      // showToast(message: errorMessage);
      // print("API error: $errorMessage");
      // if (e is FormatException) {
      //   goToLogin();
      // }
    }
    return null;
  }

  Future<FetchFileResponse?> fetchFile(String id) async {
    final String url = baseUrl + APIUrls.fetchFile + id;

    try {
      headers['Authorization'] = "c1eb523b-e917-4595-a661-000076c9fb09";
      Response? response = await APIService().getAPICall(url, headers);

      if (response?.statusCode == 200) {
        var responseData = json.decode(response!.body);
        return FetchFileResponse.fromJson(responseData);
        // return responseData;
      } else {
        return null;
      }
    } catch (e) {
    }
  }

  Future<SearchResultResponse?> getSearchResult(String searchKey) async{
    try {
      final String url = baseUrl + APIUrls.search;
      String body = json.encode({
        "conditions": [
          {
            "andOrParentheses": "OR",
            "isParentheses": false,
            "fieldID": 16,
            "fieldName": "ContentSearchTag",
            "displayName": "",
            "displayValue":"",
            "fieldValue": searchKey,
            "operator": "Contains",
            "useValueAsField": false,
            "toggleValue": false
          },
        ],
        "generateDisplaySearchCriteria": true,
        "includeRecordId": true,
        "isAdvancedSearch": false,
        "isAscendingSort": true,
        "pageIndex": 1,
        "pageSize": 1000,
        "quickSearchFieldNameList": [],
        "quickSearchText": "",
        "recordKeyFieldNames": [],
        "resultFieldNameList": [],
        "returnOnlyRecordCount": false,
        "searchTypeID": 5,
        "sortFieldName": ""
      });

      headers['Authorization'] = "c1eb523b-e917-4595-a661-000076c9fb09";
      Response? response = await APIService().postAPICall(url,body, headers);
      var responseData = json.decode(response!.body);

      if (response.statusCode == 200) {
        return SearchResultResponse.fromJson(responseData);
      } else if (responseData != null &&
          responseData.contains("errorMessage")) {
        // showToast(message: responseData["errorMessage"]);
        return null;
      } else {
        // showToast(message: "Something went wrong!");
      }
      return null;
    } catch(e){
      print("Error type: ${e.runtimeType..toString()}");
      // String errorMessage = ExceptionHandlers().getExceptionString(e);
      // showToast(message: errorMessage);
      // print("API error: $errorMessage");
      // if (e is FormatException) {
      //   goToLogin();
      // }
    }
    return null;
  }
}