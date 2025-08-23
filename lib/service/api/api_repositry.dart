import 'package:medizii/service/api/api_caller.dart';


import 'api_constants.dart';

class ApiRepository extends ApiCaller {
  Future requestSongForm(dynamic apiReqData, {required Function(String errorRes) onApiError}) async {
    var data = await executeApiCall(
      endPoint: ApiEndPoint.songRequest,
      reqData: apiReqData,
      onApiError: onApiError,
      method: MethodEnum.post,
    );
    return data;
  }
}
