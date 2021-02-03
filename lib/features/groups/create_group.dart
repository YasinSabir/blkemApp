import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  bool inviteOnly = false;
  bool privateGroup = false;
  bool adminOnly = false;
  bool automaticMember = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: [
        10.toSizedBox,
        Icon(Icons.close).toContainer(alignment: Alignment.centerRight).toHorizontalPadding(12).onTap(() {
          ExtendedNavigator.root.pop();
        }),
        "Group Name".toTextField(icon: Images.user).toThemeTextField,
        // ListTile(
        //   title: "Group Name".toSubTitle2(fontWeight: FontWeight.bold),
        //   subtitle: "Black Gamers Rock".toSubTitle2(),
        // ),
        // Divider(
        //   thickness: 1,
        // ),
        10.toSizedBox,
        "About Group ".toTextField(icon: Images.groups).toThemeTextField,

        // ListTile(
        //   title: "About Group".toSubTitle2(fontWeight: FontWeight.bold),
        //   subtitle: "Black Gamers Rock is for gamers that".toSubTitle2(),
        // ),
        Divider(
          thickness: 1,
        ),
        40.toSizedBox,
        [
          Checkbox(value: inviteOnly, onChanged: (v){
            setState(() {
              inviteOnly=v;
            });
          }),
          [
            "Invite Only".toSubTitle2(fontWeight: FontWeight.bold),
            "Members can be only be invited".toCaption(),
          ].toColumn()
        ].toRow(crossAxisAlignment: CrossAxisAlignment.center).toHorizontalPadding(12),
        10.toSizedBox,
        [
          Checkbox(value: privateGroup, onChanged: (v){
            setState(() {
              privateGroup=v;
            });
          }),
          [
            "Private Group".toSubTitle2(fontWeight: FontWeight.bold),
            "Group are public unless checked".toCaption(),
          ].toColumn()
        ].toRow(crossAxisAlignment: CrossAxisAlignment.center).toHorizontalPadding(12),
        10.toSizedBox,
        [
          Checkbox(value: adminOnly, onChanged: (v){
            setState(() {
              adminOnly=v;
            });
          }),
          [
            "Admin Only".toSubTitle2(fontWeight: FontWeight.bold),
            "Only admin can post".toCaption(),
          ].toColumn()
        ].toRow(crossAxisAlignment: CrossAxisAlignment.center).toHorizontalPadding(12),
        10.toSizedBox,
        [
          Checkbox(value: automaticMember, onChanged: (v){
            setState(() {
              automaticMember=v;
            });
          }),
          [
            "Automatic Member Approval".toSubTitle2(fontWeight: FontWeight.bold),
            "Admin have to approve invite unless checked".toCaption(),
          ].toColumn()
        ].toRow(crossAxisAlignment: CrossAxisAlignment.center).toHorizontalPadding(12),
        20.toSizedBox,
        "Create"
            .toButton()
            .toCustomButton(() {}, fullWidth: false)
            .toContainer(width: context.getScreenWidth / 2),
        10.toSizedBox
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.center)
          .makeScrollable(),
    );
  }
  Widget createOptionTile(String s, String t,bool checkboxValue) {
    return    [
      Checkbox(value: checkboxValue, onChanged: (v){
        setState(() {
          checkboxValue=v;
        });
      }),
      [
        s.toSubTitle2(fontWeight: FontWeight.bold),
        t.toCaption(),
      ].toColumn()
    ].toRow(crossAxisAlignment: CrossAxisAlignment.center);
  }
}


