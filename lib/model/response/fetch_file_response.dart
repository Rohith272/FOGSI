class FetchFileResponse {
  dynamic fileId;
  dynamic isSuccess;
  dynamic errorMessage;
  dynamic fileName;
  dynamic contentType;
  dynamic contents;

  FetchFileResponse({this.fileId, this.isSuccess, this.errorMessage, this.fileName, this.contentType, this.contents});

  FetchFileResponse.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    isSuccess = json['isSuccess'];
    errorMessage = json['errorMessage'];
    fileName = json['fileName'];
    contentType = json['contentType'];
    contents = json['contents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileId'] = fileId;
    data['isSuccess'] = isSuccess;
    data['errorMessage'] = errorMessage;
    data['fileName'] = fileName;
    data['contentType'] = contentType;
    data['contents'] = contents;
    return data;
  }
}
