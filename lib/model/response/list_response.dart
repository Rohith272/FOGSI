class ListResponse {
  String? errorMessage;
  String? displaySearchCriteria;
  List<String>? resultColumnNames;
  bool? isSuccess;
  List<Records>? records;
  int? totalRecordCount;

  ListResponse(
      {this.errorMessage,
        this.displaySearchCriteria,
        this.resultColumnNames,
        this.isSuccess,
        this.records,
        this.totalRecordCount});

  ListResponse.fromJson(Map<String, dynamic> json) {
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
  int? subTopicId;
  String? subTopicTitle;
  String? iconUrl;

  Records(
    {this.subTopicId,
      this.subTopicTitle,
      this.iconUrl
    });

  Records.fromJson(Map<String, dynamic> json) {
    subTopicId = json['record_id'];
    subTopicTitle = json['Title'];
    iconUrl = json['ImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['record_id'] = subTopicId;
    data['Title'] = subTopicTitle;
    data['ImageUrl'] = iconUrl;
    return data;
  }
}