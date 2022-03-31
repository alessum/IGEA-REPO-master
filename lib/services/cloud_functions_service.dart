import 'package:cloud_functions/cloud_functions.dart';
import 'package:igea_app/models/constants/constants.dart';

class CloudFunctionsService {
  static final CloudFunctionsService _cloudFunctionsService =
      CloudFunctionsService._internal();
  CloudFunctionsService._internal();
  factory CloudFunctionsService.instance() {
    return _cloudFunctionsService;
  }

  factory CloudFunctionsService(userID) {
    _cloudFunctionsService._userID = userID;
    return _cloudFunctionsService;
  }

  String _userID;

  final HttpsCallable callableNextMammographyDate =
      FirebaseFunctions.instanceFor(region: 'us-central1')
          .httpsCallable('calcNextMammographyDate');

  final HttpsCallable callableNextColonScreening =
      FirebaseFunctions.instanceFor(region: 'us-central1')
          .httpsCallable('calcNextColonDate');

  final HttpsCallable callableNextUterusScreening =
      FirebaseFunctions.instanceFor(region: 'us-central1')
          .httpsCallable('calcNextUterusDate');

  Future<Map<String, String>> calcNextMammographyDate(
      Map<String, dynamic> input) async {
    var result = await callableNextMammographyDate(input);
    return Map<String, String>.from(result.data);
  }

  Future<Map<String, String>> calcNextColonScreening(
      Map<String, dynamic> input) async {
    var result = await callableNextColonScreening(input);
    return Map<String, String>.from(result.data);
  }

  Future<Map<String, String>> calcNextUterusScreening(
      Map<String, dynamic> input) async {
    var result = await callableNextUterusScreening(input);
    return Map<String, String>.from(result.data);
  }

  Future<Map<String, String>> calcNextTestDate(Map<String, dynamic> input) {
    Map<String, dynamic> data = Map();

    switch (input[Constants.ORGAN_KEY]) {
      case '001':
        data.addAll({
          Constants.USER_ID_KEY: _userID,
          'last_test_date': input['reservation']['date'].toDate().toString(),
        });
        return calcNextMammographyDate(data);
        break;
      case '002':
        data.addAll({
          Constants.USER_ID_KEY: _userID,
          'last_test_date': input['reservation']['date'].toDate().toString(),
        });
        return calcNextColonScreening(data);
        break;
      case '003':
        data.addAll({
          Constants.USER_ID_KEY: _userID,
          'test_type': input[Constants.TEST_TYPE_KEY],
          'last_test_date': input['reservation']['date'].toDate().toString(),
        });
        return calcNextUterusScreening(data);
        break;
      default:
        return null;
    }
  }
}
