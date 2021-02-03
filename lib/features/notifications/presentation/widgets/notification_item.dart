import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/widgets/follow_unfollow.dart';
import 'package:colibri/features/notifications/presentation/bloc/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationItem extends StatefulWidget {
  final String time;
  final int index;

  const NotificationItem({Key key, this.time, this.index}) : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  var isSelected = false;
  NotificationCubit _notificationCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationCubit = BlocProvider.of<NotificationCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    // return CheckboxListTile(onChanged: (bool value) {
    //   setState(() {
    //     isSelected=value;
    //   });
    //   isSelected?_notificationCubit.addItemForDelete(widget.index):_notificationCubit.removeItemForDelete(widget.index);
    // }, value: isSelected,title: notificationItem(),).toContainer().makeBottomBorder;
    return Dismissible(
      key: ValueKey(widget.index),
      child: notificationItem(widget.index).toSwipeToDelete(key: ValueKey(widget.index)),
    );
  }

  Widget notificationItem(int index) {
    return [
      10.toSizedBox,
      "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
          .toRoundNetworkImage(radius: 10),
      20.toSizedBox,
      [
        5.toSizedBox,
        "John Doe commented on your photo : Nice"
            .toSubTitle2(fontWeight: FontWeight.bold, fontSize: 13),
        "${widget.time}".toCaption(maxLines: 2, fontSize: 11),
      ].toColumn().toExpanded(),
      if(index==0)
        FollowUnFollowBtn(),
      if(index==4)
      FollowUnFollowBtn(),
      if(index==2||index==5||index==6)
        "https://i.pravatar.cc/150?img=$index".toNetWorkImage(borderRadius: 4,width: 60)
    ].toRow(crossAxisAlignment: CrossAxisAlignment.center).toPadding(
        12).toContainer();
  }
}
