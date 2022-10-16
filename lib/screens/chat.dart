import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nd_telemedicine_app/screens/chat_menu.dart';

import '../services/models/chat_model.dart';
import '../services/models/user_model.dart';
import '../widgets/global/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'dart:ui' as ui;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.receiverId}) : super(key: key);

  final int receiverId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List chatListSender = [];
  List chatListReceiver = [];

  List messagesList = [];

  User? currentUser;
  User? receiver;

  String sendMessage = "";


  Future<ChatModel> createChat(
    int senderId,
    int receiverId,
    String text,
    String time,
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:9090/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
        'time': time
      }),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return ChatModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("");
    }
  }

  Future<List> getChatsFromSender() async {
    var api = 'http://localhost:9090/chat/${globals.currentUserId}/${widget.receiverId}';
    Response res = await get(Uri.parse(api));

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    } else {
      throw "Cannot get appointment data";
    }
  }

  Future<List> getChatsFromReceiver() async {
    var api = 'http://localhost:9090/chat/${widget.receiverId}/${globals.currentUserId}';
    Response res = await get(Uri.parse(api));

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    } else {
      throw "Cannot get appointment data";
    }
  }

  void convertFutureListToList() async {
    Future<List> futureOfSender = getChatsFromReceiver();
    chatListSender = await futureOfSender;
    messagesList = [];
    for (dynamic chat in chatListSender) {
      ChatModel newChat = ChatModel(
          id: chat['id'],
          senderId: chat['senderId'],
          receiverId: chat['receiverId'],
          time: chat['time'],
          text: chat['text']);
      setState(() {
        messagesList.add(newChat);
      });
    }
    Future<List> futureOfReceiver = getChatsFromSender();
    chatListReceiver = await futureOfReceiver;
    for (dynamic chat in chatListReceiver) {
      ChatModel newChat = ChatModel(
          id: chat['id'],
          senderId: chat['senderId'],
          receiverId: chat['receiverId'],
          time: chat['time'],
          text: chat['text']);
      setState(() {
        messagesList.add(newChat);
      });
    }

    messagesList.sort((a, b) => b.id.compareTo(a.id));
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    Response res = await get(
        Uri.parse("https://telemedicine-user-service.herokuapp.com/user/${globals.currentUserId}"));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      User thisUser = User(
        id: obj['id'],
        role: obj['role'],
        email: obj['email'],
        password: obj['password'],
        fullName: obj['fullName'],
        avatar: obj['avatar'],
        address: obj['address'],
        phoneNumber: obj['phoneNumber'],
        gender: obj['gender'],
        dateOfBirth: obj['dateOfBirth'],
        allergies: obj['allergies'],
        diseases: obj['diseases'],
        medication: obj['medication'],
        bio: obj['bio'],
        speciality: obj['speciality'],
        status: obj['userStatus'],
      );
      setState(() {
        currentUser = thisUser;
      });
      return obj;
    } else {
      throw "Unable to retrieve users data.";
    }
  }

  Future<Map<String, dynamic>> getReceiver() async {
    Response res =
        await get(Uri.parse("https://telemedicine-user-service.herokuapp.com/user/${widget.receiverId}"));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      User thisUser = User(
        id: obj['id'],
        role: obj['role'],
        email: obj['email'],
        password: obj['password'],
        fullName: obj['fullName'],
        avatar: obj['avatar'],
        address: obj['address'],
        phoneNumber: obj['phoneNumber'],
        gender: obj['gender'],
        dateOfBirth: obj['dateOfBirth'],
        allergies: obj['allergies'],
        diseases: obj['diseases'],
        medication: obj['medication'],
        bio: obj['bio'],
        speciality: obj['speciality'],
        status: obj['userStatus'],
      );
      setState(() {
        receiver = thisUser;
      });
      return obj;
    } else {
      throw "Unable to retrieve users data.";
    }
  }

  final _controller = TextEditingController();

  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => convertFutureListToList());
    getCurrentUser();
    getReceiver();
  }

  _chatBubble(messagesList, bool isMe) {
    if (!isMe) {
      return Column(
        children: <Widget>[
          Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(
                          receiver?.avatar ?? "assets/images/mock_avatar.png"),
                    ),
                  ),
                  IntrinsicWidth(
                    child: Container(
                      alignment: Alignment.topLeft,
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                      ),
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffEFF0F0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Text(
                        messagesList.text,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Text(
                    messagesList.time,
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  )
                ],
              ),
            ],
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Column(
            children: [
              Row(
                textDirection: ui.TextDirection.rtl,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                      )
                    ]),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage(currentUser?.avatar ??
                          "assets/images/mock_avatar.png"),
                    ),
                  ),
                  IntrinsicWidth(
                    child: Container(
                      alignment: Alignment.topRight,
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xff38B69A),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.zero,
                            bottomLeft: Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Text(
                        messagesList.text,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  Text(
                    messagesList.time,
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  )
                ],
              ),
            ],
          )
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                setState(() {
                  sendMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: () {
              createChat(globals.currentUserId, widget.receiverId, sendMessage,
                  DateFormat.jm().format(DateTime.now()));
              _controller.clear();
              setState(() {
                convertFutureListToList();
              });
            },
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => {
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
          builder: (context) => ChatMenu()),
          )
          },
        ),
        centerTitle: true,
        title: Text(
          receiver?.fullName ?? "",
          style: const TextStyle(fontFamily: "PoppinsBold"),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(20),
              itemCount: messagesList.length,
              itemBuilder: (BuildContext context, int index) {
                final bool isMe =
                    messagesList[index].senderId == globals.currentUserId;
                return _chatBubble(messagesList[index], isMe);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
