import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/blocs/bloc_chatbot.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/message_type.dart';

class Chatbot extends StatefulWidget {
  Chatbot({
    Key key,
    @required this.suggestedMessageList,
    this.inputMessage,
  }) : super(key: key);

  final String inputMessage;
  final List<String> suggestedMessageList;

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = new ScrollController();
  String _message;

  ChatbotBloc bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.inputMessage != null) {
        bloc.sendMessage.add(widget.inputMessage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = ChatbotBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
        elevation: 3,
        toolbarHeight: media.height * .11,
        titleSpacing: 0.0,
        title: Container(
          width: media.width * .7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/avatars/arold_in_circle.svg',
                width: 45,
              ),
              SizedBox(
                height: media.height * .01,
              ),
              SizedBox(width: 10.0),
              Text('Arold',
                  style: TextStyle(
                      fontSize: 25, fontFamily: 'Gotham', color: Colors.white))
            ],
          ),
        ),
      ),
      body: Container(
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: media.height * 0.18), // PER I CONSIGLI, RIDIMENSIONARE
            child: StreamBuilder<List<Map>>(
                stream: bloc.getMessageList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Timer(
                      Duration(milliseconds: 500),
                      () => _scrollController
                          .jumpTo(_scrollController.position.minScrollExtent),
                    );

                    return ListView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return MessageTile(
                            message: snapshot.data[index]["message"].toString(),
                            sendByMe: snapshot.data[index]["data"],
                          );
                        });
                  } else
                    return Container();
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: media.height * 0.08),
              padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
              width: media.width,
              height: media.height * 0.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Colors.grey[350], width: 1))),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 5),
                scrollDirection: Axis.horizontal,
                itemCount: widget.suggestedMessageList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () =>
                      bloc.sendMessage.add(widget.suggestedMessageList[index]),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(left: 3, right: 3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Center(
                        child: Text(
                      widget.suggestedMessageList[index],
                      style: TextStyle(
                        fontSize: media.width * 0.04,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: media.height * 0.08,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 10,
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Container(
                            height: 40,
                            width: media.width * 0.8,
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: _messageController,
                              autofocus: false,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: false,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Chiedi a me',
                                filled: true,
                              ),
                              onChanged: (value) => _message = value,
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          bloc.sendMessage.add(_message);

                          _messageController.clear();
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        child: Container(
                          height: 33,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xFF415364),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Center(
                            child: Text('Invia',
                                style: TextStyle(
                                    fontSize: media.height > 600 ? 15 : 12,
                                    fontFamily: 'Gotham',
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ]),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final PrevengoMessageType sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe == PrevengoMessageType.USER ? 0 : 24,
          right: sendByMe == PrevengoMessageType.USER ? 24 : 0),
      alignment: sendByMe == PrevengoMessageType.USER
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: sendByMe == PrevengoMessageType.USER
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe == PrevengoMessageType.USER
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            // gradient: LinearGradient(
            //   colors: sendByMe
            //       ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
            //       : [const Color(0x1AFF00FF), const Color(0x1AFF0000)],
            // ),
            color: sendByMe == PrevengoMessageType.USER
                ? Color(0xFF4373B1)
                : Color(0xFFE8B21C)),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17.5,
                fontFamily: 'Book',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
