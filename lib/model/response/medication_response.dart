class MedicationListResponse {
  String? errorMessage;
  String? displaySearchCriteria;
  List<String>? resultColumnNames;
  bool? isSuccess;
  List<MedicationRecords>? records;
  int? totalRecordCount;

  MedicationListResponse(
      {this.errorMessage,
        this.displaySearchCriteria,
        this.resultColumnNames,
        this.isSuccess,
        this.records,
        this.totalRecordCount});

  MedicationListResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
    displaySearchCriteria = json['displaySearchCriteria'];
    resultColumnNames = json['resultColumnNames'].cast<String>();
    isSuccess = json['isSuccess'];
    if (json['records'] != null) {
      records = <MedicationRecords>[];
      json['records'].forEach((v) {
        records!.add(MedicationRecords.fromJson(v));
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

class MedicationRecords {
  int? medicationId;
  String? medicineName;
  String? medDescription;
  String? warnings;
  String? indication;
  String? contradiction;
  String? sideEffects;
  String? dosage;

  MedicationRecords(
      {this.medicationId,
        this.medicineName,
        this.medDescription,
        this.warnings,
        this.indication,
        this.contradiction,
        this.sideEffects,
        this.dosage
      });

  MedicationRecords.fromJson(Map<String, dynamic> json) {
    medicationId = json['record_id'];
    medicineName = json['MedicineName'];
    medDescription = json['MedDescription'];
    warnings = json['Warnings'];
    indication = json['Indications'];
    contradiction = json['Contraindication'];
    sideEffects = json['SideEffects'];
    dosage = json['dosage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['record_id'] = medicationId;
    data['MedicineName'] = medicineName;
    data['MedDescription'] = medDescription;
    data['Warnings'] = warnings;
    data['Indications'] = indication;
    data['Contraindication'] = contradiction;
    data['SideEffects'] = sideEffects;
    data['dosage'] = dosage;
    return data;
  }
}