class SearchResultResponse {
  String? errorMessage;
  String? displaySearchCriteria;
  List<String>? resultColumnNames;
  bool? isSuccess;
  List<SearchRecords >? records;
  int? totalRecordCount;

  SearchResultResponse(
      {this.errorMessage,
        this.displaySearchCriteria,
        this.resultColumnNames,
        this.isSuccess,
        this.records,
        this.totalRecordCount});

  SearchResultResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
    displaySearchCriteria = json['displaySearchCriteria'];
    resultColumnNames = json['resultColumnNames'].cast<String>();
    isSuccess = json['isSuccess'];
    if (json['records'] != null) {
      records = <SearchRecords>[];
      json['records'].forEach((v) {
        records!.add(SearchRecords.fromJson(v));
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

class SearchRecords {
  int? recordId;
  String? iconUrl;
  String? contentTitle;
  int? displayOrder;
  int? relationTypeId;
  int? parentId;

  SearchRecords (
      {this.recordId,
        this.iconUrl,
        this.contentTitle,
        this.displayOrder,
        this.relationTypeId,
        this.parentId
      });

  SearchRecords .fromJson(Map<String, dynamic> json) {
    recordId = json['record_id'];
    iconUrl = json['ImageUrl'];
    contentTitle = json['ContentTitle'];
    displayOrder = json['DisplayOrder'];
    relationTypeId = json['RelationTypeId'];
    parentId = json['ParentTopicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['record_id'] = recordId;
    data['ImageUrl'] = iconUrl;
    data['ContentTitle'] = contentTitle;
    data['DisplayOrder'] = displayOrder;
    data['RelationTypeId'] = relationTypeId;
    data['ParentTopicId'] = parentId;
    return data;
  }
}