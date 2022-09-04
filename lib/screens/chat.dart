import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
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
          widget.user.name,
          style: const TextStyle(fontFamily: "PoppinsBold"),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Column(
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
                        ]),
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage('assets/images/kuri.jpeg'),
                        ),
                      ),
                      Container(
                        child: Container(
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
                          child: Text("A", style: TextStyle(fontSize: 15),),
                        ),
                      ),
                      Container(
                        child: const Text(
                          "12:30PM",
                          style: TextStyle(fontSize: 11, color: Colors.black54),
                        ),
                      )
                    ],
                  ),
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
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage('assets/images/kuri.jpeg'),
                        ),
                      ),
                      Container(
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
                          child: Text("Hello World!", style: const TextStyle(color: Colors.white, fontSize: 15),),
                        ),
                      ),
                      const Text(
                        "12:30PM",
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      )
                    ],
                  ),
                ],
              )
            ],
          )
          ),
    _sendMessageArea(),
        ],
      ),
    );
  }
}
