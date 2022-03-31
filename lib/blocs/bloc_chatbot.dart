import 'package:flutter/material.dart';
import 'package:igea_app/models/enums/message_type.dart';
import 'package:igea_app/services/dialogflow_service.dart';
import 'package:rxdart/rxdart.dart';

class ChatbotBlocProvider extends InheritedWidget {
  final ChatbotBloc bloc;

  ChatbotBlocProvider({Key key, Widget child})
      : bloc = ChatbotBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ChatbotBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChatbotBlocProvider>()
        .bloc;
  }
}

class ChatbotBloc {
  DialogFlowService _dialogFlowService = DialogFlowService.instance();

  final _fetchMessageListSubject = BehaviorSubject<List<Map>>();
  final _sendMessageSubject = BehaviorSubject<String>();

  Stream<List<Map>> get getMessageList => _fetchMessageListSubject.stream;
  Sink<String> get sendMessage => _sendMessageSubject.sink;

  List<Map> _messageList = [];

  ChatbotBloc() {
    _sendMessageSubject.stream.listen((event) async {
      _messageList
          .insert(0, {"data": PrevengoMessageType.USER, "message": event});
      _fetchMessageListSubject.sink.add(_messageList);

      var response = await _dialogFlowService.response(event);
      _messageList.insert(
          0, {"data": PrevengoMessageType.CHATBOT, "message": response.text});

      _fetchMessageListSubject.sink.add(_messageList);
    });
  }

  dispose() {
    _fetchMessageListSubject.close();
    _sendMessageSubject.close();
  }
}
