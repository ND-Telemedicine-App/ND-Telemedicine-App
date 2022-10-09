import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../services/models/chat_model.dart';
import '../services/models/user_model.dart';
import '../widgets/global/globals.dart' as globals;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  List chatListSender = [];
  List chatListReceiver = [];

  List messagesList = [];

  User? currentUser;

  Future<List> getChatsFromSender() async {
    var api =
        'http://localhost:9090/chat/${globals.currentUserId}/1';
    Response res = await get(Uri.parse(api));

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    } else {
      throw "Cannot get appointment data";
    }
  }

  Future<List> getChatsFromReceiver() async {
    var api =
        'http://localhost:9090/chat/1/${globals.currentUserId}';
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
    for (dynamic chat in chatListSender) {
      ChatModel newChat = ChatModel(id: chat['id'], senderId: chat['senderId'], receiverId: chat['receiverId'], time: chat['time'], text: chat['text']);
      setState(() {
        messagesList.add(newChat);
      });
    }
    Future<List> futureOfReceiver = getChatsFromSender();
    chatListReceiver = await futureOfReceiver;
    for (dynamic chat in chatListReceiver) {
      ChatModel newChat = ChatModel(id: chat['id'], senderId: chat['senderId'], receiverId: chat['receiverId'], time: chat['time'], text: chat['text']);
      setState(() {
        messagesList.add(newChat);
      });
    }

    messagesList.sort((a, b) => b.id.compareTo(a.id));
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    Response res = await get(
        Uri.parse("http://localhost:8080/user/${globals.currentUserId}"));

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convertFutureListToList();
    getCurrentUser();
  }


  _chatBubble(messagesList, bool isMe){
    if(!isMe){
      return Column(
        children: <Widget>[
          Column(
            children: [
              Row(
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
                    ],),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage:
                      AssetImage("assets/images/mock_avatar.png"),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5,
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffEFF0F0),
                        borderRadius: const BorderRadius.only(
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
                    child: Text(messagesList.text, style: TextStyle(fontSize: 15),),
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
    }else{
      return Column(
        children: <Widget>[
          Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
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
                      backgroundImage:
                      AssetImage(currentUser?.avatar??"assets/images/mock_avatar.png"),
                    ),
                  ),
                  Container(
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
                    child: Text(messagesList.text, style: const TextStyle(color: Colors.white, fontSize: 15),),
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


  _sendMessageArea(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.photo), iconSize: 25, color: Theme.of(context).primaryColor,),
          const Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.send), iconSize: 25, color: Theme.of(context).primaryColor,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User",
          style: const TextStyle(fontFamily: "PoppinsBold"),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child:
              ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(20),
                itemCount: messagesList.length,
                itemBuilder: (BuildContext context, int index) {
                  final bool isMe = messagesList[index].senderId == globals.currentUserId;
                  return _chatBubble(messagesList[index], isMe);
                },
              ),),
          _sendMessageArea(),
          ],
      ),
    );
  }
}
