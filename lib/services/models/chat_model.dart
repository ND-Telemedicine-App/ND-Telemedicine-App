class ChatModel {
  int? id;
  int? senderId;
  int? receiverId;
  String? time;
  String? text;

  ChatModel(
      {this.id, this.senderId, this.receiverId, this.time, this.text});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    time = json['time'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['time'] = this.time;
    data['text'] = this.text;
    return data;
  }

  int? getSenderId() => senderId;
  int? getReceiverId() => receiverId;
  String? getTime() => time;
  String? gettext() => text;
}