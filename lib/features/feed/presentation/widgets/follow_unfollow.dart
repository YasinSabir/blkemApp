import 'package:colibri/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
class FollowUnFollowBtn extends StatefulWidget {
  @override
  _FollowUnFollowBtnState createState() => _FollowUnFollowBtnState();
}

class _FollowUnFollowBtnState extends State<FollowUnFollowBtn> {
  bool isFollowed=true;
  @override
  Widget build(BuildContext context) {
    return Container(child: isFollowed?followedButton():unFollowedButton(),).toContainer(height: 27);
  }

  Widget followedButton(){
    return "Follow".toCaption(color: AppColors.colorPrimary,fontWeight: FontWeight.bold).toOutlinedBorder(() {
      setState(() {
        isFollowed=false;
      });
    });
  }

  Widget unFollowedButton(){
    return "Unfollow".toCaption(
        color: Colors.white, fontWeight: FontWeight.bold).toMaterialButton(() {
      setState(() {
        isFollowed=true;
      });
    });
  }
}
