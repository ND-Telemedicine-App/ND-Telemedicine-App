import 'package:flutter/material.dart';

import '../models/messages_model.dart';

class ChatMenu extends StatefulWidget {
  const ChatMenu({Key? key}) : super(key: key);

  @override
  State<ChatMenu> createState() => _ChatMenuState();
}

class _ChatMenuState extends State<ChatMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(height: 20,),
                  Text("Chat", style: TextStyle(color: Color(0xff2B8D78), fontSize: 25, fontFamily: 'PoppinsBold')),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                elevation: 10.0,
                shadowColor: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(40)),
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
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                    prefixIcon: const Icon(Icons.search)
                  ),
                ),
              ),
            ),

            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: chats.length,
                itemBuilder: (BuildContext context,
                    int index){
                  final Message chat = chats[index];
                  return
                    Column(
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
                                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                                        border: Border.all(
                                            width: 2,
                                            color: Theme.of(context).primaryColor
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                          )
                                        ]
                                    ) ,
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: AssetImage(chat.sender.imageUrl),
                                    ),
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(chat.sender.name, style: TextStyle(fontSize: 15, fontFamily: "PoppinsSemiBold"),),
                                            Text(chat.time, style: TextStyle(fontSize: 11, color: Colors.black54),),
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            chat.text,
                                            style: TextStyle(fontSize: 13, color: Colors.black87),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,),)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ;
                }

            ),
          ],
        )
      ),
    );
  }
}
