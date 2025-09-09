class UploadDocumentResponse {
  bool? error;
  String? message;
  SavedReport? savedReport;
  int? successfulUploads;
  int? failedUploads;
  UploadResults? uploadResults;

  UploadDocumentResponse({this.error, this.message, this.savedReport, this.successfulUploads, this.failedUploads, this.uploadResults});

  UploadDocumentResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    savedReport = json['savedReport'] != null ? new SavedReport.fromJson(json['savedReport']) : null;
    successfulUploads = json['successfulUploads'];
    failedUploads = json['failedUploads'];
    uploadResults = json['uploadResults'] != null ? new UploadResults.fromJson(json['uploadResults']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (savedReport != null) {
      data['savedReport'] = savedReport!.toJson();
    }
    data['successfulUploads'] = successfulUploads;
    data['failedUploads'] = failedUploads;
    if (uploadResults != null) {
      data['uploadResults'] = uploadResults!.toJson();
    }
    return data;
  }
}

class SavedReport {
  String? patientId;
  List<Reports>? reports;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SavedReport({this.patientId, this.reports, this.sId, this.createdAt, this.updatedAt, this.iV});

  SavedReport.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    if (json['reports'] != null) {
      reports = <Reports>[];
      json['reports'].forEach((v) {
        reports!.add(new Reports.fromJson(v));
      });
    }
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientId'] = patientId;
    if (reports != null) {
      data['reports'] = reports!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Reports {
  String? url;
  String? filename;
  String? extractedText;
  String? sId;

  Reports({this.url, this.filename, this.extractedText, this.sId});

  Reports.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    filename = json['filename'];
    extractedText = json['extractedText'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['filename'] = filename;
    data['extractedText'] = extractedText;
    data['_id'] = sId;
    return data;
  }
}

class UploadResults {
  List<Successful>? successful;

  UploadResults({this.successful});

  UploadResults.fromJson(Map<String, dynamic> json) {
    if (json['successful'] != null) {
      successful = <Successful>[];
      json['successful'].forEach((v) {
        successful!.add(new Successful.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (successful != null) {
      data['successful'] = successful!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Successful {
  bool? success;
  bool? error;
  String? url;
  String? extractedText;
  String? filename;

  Successful({this.success, this.error, this.url, this.extractedText, this.filename});

  Successful.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    url = json['url'];
    extractedText = json['extractedText'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    data['url'] = url;
    data['extractedText'] = extractedText;
    data['filename'] = filename;
    return data;
  }
}
