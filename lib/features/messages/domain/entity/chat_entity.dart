import 'package:flutter/material.dart';

class ChatEntity{
  final String time;
  final String message;
  final bool isSender;

  ChatEntity({
    @required this.time,
    @required this.message,
    this.isSender=true
});

  static List<ChatEntity> getDummyData(){
    var items=List<ChatEntity>();
    items.add(ChatEntity(time: "test", message: "test"));
    items.add(ChatEntity(time: "20 Aug, 2020 5:58pm", message: "Hello how are you ?\nthis is a test message",isSender: false));
    items.add(ChatEntity(time: "20 Aug, 2020 5:58pm", message: "Hello how are you ?\nthis is a test message",isSender: false));
    items.add(ChatEntity(time: "20 Aug, 2020 5:58pm", message: "test"));
    items.add(ChatEntity(time: "20 Aug, 2020 5:58pm", message: "test"));
    items.add(ChatEntity(time: "20 Aug, 2020 5:58pm", message: "test"));
    items.add(ChatEntity(time: "20 Aug, 2020 5:58pm", message: "test"));
    items.add(ChatEntity(time: "20 Aug, 2020 5:58pm", message: "test"));
    items.add(ChatEntity(time: "20 Aug, 2020 5:58pm", message: "test"));
    items.add(ChatEntity(time: "20 Aug, 2020 5:58pm", message: "test"));
    return items;
  }
}