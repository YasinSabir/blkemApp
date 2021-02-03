import 'package:bloc/bloc.dart';
import 'package:colibri/features/notifications/presentation/widgets/notification_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'notification_state.dart';
@injectable
class NotificationCubit extends Cubit<NotificationState> {
  final GlobalKey<AnimatedListState> animatedListState=GlobalKey<AnimatedListState>();
  final items= List<String>.generate(10, (i) => "${i + 1} Hours ago");
  final removedItemsIndex=<int>[];
  NotificationCubit() : super(NotificationInitial());
  
  

 final itemsController=BehaviorSubject<List<String>>.seeded(List<String>.generate(10, (i) => "${i + 1} Hours ago"));
 Function(List<String>) get changeItems=>itemsController.sink.add;
 Stream<List<String>> get listItems=>itemsController.stream;

  final removeItemCounterNotifications=BehaviorSubject<int>();
  Function(int) get changeNotificationRemovedCounter=>removeItemCounterNotifications.sink.add;
  Stream<int> get notificationRemovedCounter=>removeItemCounterNotifications.stream;
  removeItem(){
  var newList=<String>[];
   items.forEach((element) {
     if(!removedItemsIndex.contains(element))
      newList.add(element) ;
   });
   // items.
    // changeItems(items);
    // removedItemsIndex.clear();
  }

  addItemForDelete(int position){
    removedItemsIndex.add(position);
    // changeNotificationRemovedCounter(removedItemsIndex.length);
  }
  removeItemForDelete(int position){
    removedItemsIndex.remove(position);
    changeNotificationRemovedCounter(removedItemsIndex.length);
    print("positions: $position");
    // items.removeAt(position);
    // animatedListState?.currentState?.removeItem(position, (context, animation) =>
    //     SizeTransition(sizeFactor: animation,child: NotificationItem(time: items[position],index: position),));
  }
}
