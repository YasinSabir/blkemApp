



import 'package:colibri/core/common/animations.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/features/notifications/presentation/bloc/notification_cubit.dart';
import 'package:colibri/features/notifications/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:colibri/extensions.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationCubit _notificationCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationCubit=getIt<NotificationCubit>();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if(_notificationCubit.animatedListState.currentState != null)
    //
    //     // List<int>.generate(10, (i) => i + 1).forEach((element) {
    //     //   Future.delayed(Duration(milliseconds: 800),(){
    //     //     animatedListState.currentState.insertItem(element);
    //     //   });
    //     // });
    //
    // });
  }
  @override
  Widget build(BuildContext context) {

    return
        BlocProvider<NotificationCubit>(
          create: (_)=>_notificationCubit,
          child: StreamBuilder<List<String>>(
              initialData: [],
              stream: _notificationCubit.listItems,
              builder: (context, snapshot) {
                return ListView.builder(

                  itemBuilder: (c,index)=>NotificationItem(time:
                  snapshot.data[index],
                    index: index
                    ,).toContainer().makeBottomBorder,itemCount: snapshot.data.length,
                );
              }
          ),
        );
  }
}
