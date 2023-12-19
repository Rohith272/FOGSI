class BannerResponse {
  String? errorMessage;
  String? displaySearchCriteria;
  List<String>? resultColumnNames;
  bool? isSuccess;
  List< BannerRecords>? records;
  int? totalRecordCount;

  BannerResponse(
      {this.errorMessage,
        this.displaySearchCriteria,
        this.resultColumnNames,
        this.isSuccess,
        this.records,
        this.totalRecordCount});

  BannerResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
    displaySearchCriteria = json['displaySearchCriteria'];
    resultColumnNames = json['resultColumnNames'].cast<String>();
    isSuccess = json['isSuccess'];
    if (json['records'] != null) {
      records = < BannerRecords>[];
      json['records'].forEach((v) {
        records!.add(BannerRecords.fromJson(v));
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

class BannerRecords {
  int? bannerId;
  String? bannerTitle;
  String? imageUrl;
  int? fileId;
  int? relationTypeId;
  int? listId;


  BannerRecords(
      {this.bannerId,
        this.imageUrl,
        this.bannerTitle,
        this.fileId,
        this.listId,
        this.relationTypeId
      });

  BannerRecords.fromJson(Map<String, dynamic> json) {
    bannerId = json['record_id'];
    bannerTitle = json['Title'];
    imageUrl = json['ImageUrl'];
    fileId = json['FileId'];
    listId = json['ListId'];
    relationTypeId = json['RelationTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['record_id'] = bannerId;
    data['Title'] = bannerTitle;
    data['ImageUrl'] = imageUrl;
    data['FileId'] = fileId;
    data['RelationTypeId'] = relationTypeId;
    data['ListId'] = listId;
    return data;
  }
}