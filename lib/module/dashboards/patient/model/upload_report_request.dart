import 'package:http/http.dart' as http;

class UploadReportRequest {
  String? files;

  UploadReportRequest({this.files});

  UploadReportRequest.fromJson(Map<String, dynamic> json) {
    files = json['files'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (files != null && files?.isNotEmpty == true) {
      data['files'] = await http.MultipartFile.fromPath("files", files.toString());
    }
    return data;
  }
}
