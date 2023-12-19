class EventsResponse {
  String? errorMessage;
  String? displaySearchCriteria;
  List<String>? resultColumnNames;
  bool? isSuccess;
  List<EventRecords>? records;
  int? totalRecordCount;

  EventsResponse(
      {this.errorMessage,
        this.displaySearchCriteria,
        this.resultColumnNames,
        this.isSuccess,
        this.records,
        this.totalRecordCount});

  EventsResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
    displaySearchCriteria = json['displaySearchCriteria'];
    resultColumnNames = json['resultColumnNames'].cast<String>();
    isSuccess = json['isSuccess'];
    if (json['records'] != null) {
      records = <EventRecords>[];
      json['records'].forEach((v) {
        records!.add(EventRecords.fromJson(v));
      });
    }
    totalRecordCount = json['totalRecordCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorMessage'] = errorMessage;
    data['displaySearchCriteria'] = displaySearchCriteria;
    data['resultColumnNames'] = resultColumnNames;
    data['isSuccess'] = isSuccess;
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['totalRecordCount'] = totalRecordCount;
    return data;
  }
}

class EventRecords {
  int? eventId;
  String? eventTitle;
  String? eventStartDate;
  String? eventEndDate;

  EventRecords(
      {this.eventId,
        this.eventStartDate,
        this.eventTitle,
        this.eventEndDate
      });

  EventRecords.fromJson(Map<String, dynamic> json) {
    eventId = json['record_id'];
    eventTitle = json['EventTitle'];
    eventStartDate = json['EventStartDate'];
    eventEndDate = json['EventEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['record_id'] = eventId;
    data['EventTitle'] = eventTitle;
    data['EventDate'] = eventStartDate;
    data['EventEndDate'] = eventEndDate;
    return data;
  }
}