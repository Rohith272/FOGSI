class SegmentListResponse {
  String? errorMessage;
  String? displaySearchCriteria;
  List<String>? resultColumnNames;
  bool? isSuccess;
  List<Records>? records;
  int? totalRecordCount;

  SegmentListResponse(
      {this.errorMessage,
        this.displaySearchCriteria,
        this.resultColumnNames,
        this.isSuccess,
        this.records,
        this.totalRecordCount});

  SegmentListResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
    displaySearchCriteria = json['displaySearchCriteria'];
    resultColumnNames = json['resultColumnNames'].cast<String>();
    isSuccess = json['isSuccess'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
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

class Records {
  int? segmentId;
  String? title;
  String? iconUrl;

  Records(
      {this.segmentId,
        this.title,
        this.iconUrl
      });

  Records.fromJson(Map<String, dynamic> json) {
    segmentId = json['record_id'];
    title = json['name'];
    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['record_id'] = segmentId;
    data['name'] = title;
    data['icon_url'] = iconUrl;
    return data;
  }
}