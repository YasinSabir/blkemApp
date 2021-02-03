import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/features/feed/presentation/widgets/follow_unfollow.dart';
import 'package:colibri/features/search/presentation/widgets/hasttag_item.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
class WhereToFollow extends StatefulWidget {
  @override
  _WhereToFollowState createState() => _WhereToFollowState();
}

class _WhereToFollowState extends State<WhereToFollow> {
  @override
  Widget build(BuildContext context) {
    return Container(child: [
      10.toSizedBox,
      [
        20.toSizedBox,
        "Who to Follow".toSubTitle1(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)].toRow(),
     notificationItem(0),
     Divider(thickness: 1,),
     notificationItem(2),
      Divider(thickness: 1,),
     notificationItem(4),
    ].toColumn(),);
  }
  Widget notificationItem(int index) {
    return [
      10.toSizedBox,
      "https://i.pravatar.cc/150?img=$index"
          .toNetWorkImage(borderRadius: 4),
      20.toSizedBox,
      [
        5.toSizedBox,
        faker.person.firstName()
            .toSubTitle2(fontWeight: FontWeight.bold,),
        "@${faker.person.lastName().toLowerCase()}"
            .toCaption(),
        // "${widget.time}".toCaption(maxLines: 2, fontSize: 11),
       [
         "1.5m".toCaption(color: AppColors.colorPrimary,fontWeight: FontWeight.bold),
         " Followers".toCaption()
       ].toRow(),
      ].toColumn().toExpanded(),
      // if(index==0)
      FollowUnFollowBtn()
      //   "Follow".toCaption(color: Colors.white,fontWeight: FontWeight.bold).toMaterialButton(() { }).toContainer(height: 25),
      // if(index==4)
      //   "Following".toCaption(color: AppColors.colorPrimary,fontWeight: FontWeight.bold).toOutlinedBorder(() { }),
      // if(index==2||index==5||index==6)
      //   "https://i.pravatar.cc/150?img=$index".toNetWorkImage(borderRadius: 8,width: 60)
    ].toRow(crossAxisAlignment: CrossAxisAlignment.center).toSymmetricPadding(12,8).toContainer();
  }
}
