import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nd_telemedicine_app/main.dart';
import 'package:nd_telemedicine_app/screens/chat.dart';
import 'package:nd_telemedicine_app/services/models/chat_model.dart';
import '../services/models/user_model.dart';
import '../widgets/global/globals.dart' as globals;

class ChatMenu extends StatefulWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  State<ChatMenu> createState() => _ChatMenuState();
}

class _ChatMenuState extends State<ChatMenu> {
  List receiverIdList = [];
  User? currentUser;

  List receiverList = [];
  List latestChat = [];

  Future<User> getUser(int id) async {
    var api =
        'https://telemedicine-user-service.herokuapp.com/user/$id';

    Response res = await get(Uri.parse(api));
    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      User newUser = User(
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
      );
      setState(() {
        currentUser = newUser;
      });
      return newUser;
    } else {
      throw "Cannot get appointment data";
    }
  }

  Future<ChatModel> getLatestChat(int id) async {
    var api = 'https://tele-chat-service.herokuapp.com/chat/latest/${globals.currentUserId}/$id';
    Response res = await get(Uri.parse(api));
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      ChatModel latestChat = ChatModel(
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        text: json['text'],
        time: json['time'],
      );
      return latestChat;
    } else {
      throw "Cannot get appointment data";
    }
  }

  Future<List> getReceiver() async {
    var api = 'https://tele-chat-service.herokuapp.com/chat/sender/${globals.currentUserId}';
    Response res = await get(Uri.parse(api));
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    } else {
      throw "Cannot get appointment data";
    }
  }

  void convertFutureListToList() async {
    Future<List> futureOfSender = getReceiver();
    receiverIdList = await futureOfSender;
    for (dynamic id in receiverIdList) {
      User user = await getUser(id);
      ChatModel chat = await getLatestChat(id);
      setState(() {
        receiverList.add(user);
        latestChat.add(chat);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convertFutureListToList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => currentUser?.role == "PATIENT"
                                  ? MyStatefulWidget()
                                  : DoctorNavBar()),
                        );
                      },
                      iconSize: 25,
                      highlightColor: Theme.of(context).primaryColor,
                      splashRadius: 20,
                    ),
                    Text("Chat",
                        style: TextStyle(
                            color: Color(0xff2B8D78),
                            fontSize: 25,
                            fontFamily: 'PoppinsBold')),
                    IconButton(
                      icon: Icon(Icons.more_horiz_rounded),
                      onPressed: () {},
                      iconSize: 25,
                      highlightColor: Theme.of(context).primaryColor,
                      splashRadius: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              elevation: 10.0,
              shadowColor: Colors.black45,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 15),
                    prefixIcon: const Icon(Icons.search)),
              ),
            ),
          ),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: receiverList.length,
                itemBuilder: (BuildContext context, int index) {
                  final User user = receiverList[index];
                  final ChatModel chat = latestChat[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatScreen(
                                  receiverId: user.id ?? 0,
                                ))),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                        border: Border.all(
                                            width: 2,
                                            color:
                                                Theme.of(context).primaryColor),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                          )
                                        ]),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: AssetImage(user.avatar ??
                                          "assets/images/mock_avatar.png"),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              user.fullName ?? "",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily:
                                                      "PoppinsSemiBold"),
                                            ),
                                            Text(
                                              chat.time ?? "",
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            chat.senderId ==
                                                    globals.currentUserId
                                                ? "You: ${chat.text}" ?? ""
                                                : chat.text ?? "",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
