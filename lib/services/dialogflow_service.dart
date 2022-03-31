import 'package:dialog_flowtter/dialog_flowtter.dart';

class DialogFlowService {
  String _apiPath = 'assets/igea-app-project-dfee65c301f2.json';

  static final DialogFlowService _dialogFlowService = DialogFlowService._internal();
  DialogFlowService._internal();

  factory DialogFlowService.instance(){
    return _dialogFlowService;
  }

  factory DialogFlowService(apiPath) {
    _dialogFlowService._apiPath = apiPath;
    return _dialogFlowService;
  }

  Future<DetectIntentResponse> response(query) async {
    DialogAuthCredentials credentials =
        await DialogAuthCredentials.fromFile(_apiPath);
    DialogFlowtter dialogFlowInstance =
        DialogFlowtter(credentials: credentials);

    final QueryInput queryInput = QueryInput(
      text: TextInput(
        text: query.replaceAll('\'', ' '),
        languageCode: 'it',
      ),
    );

    return await dialogFlowInstance.detectIntent(queryInput: queryInput);
  }
}
