

import 'dart:convert';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/core/theme/app_theme.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/extensions.dart';
import 'package:azlistview/azlistview.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/feed/presentation/widgets/feed_widgets.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lpinyin/lpinyin.dart';

class GroupDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _GroupDetailState();
  }
}

class _GroupDetailState extends State<GroupDetail> {
  List<ContactInfo> _contacts = List();
  double susItemHeight = 40;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    List<ContactInfo> model=List();
    rootBundle.loadString('data/contacts.json').then((value) {
      List list = json.decode(value);
      list.forEach((v) {
        _contacts.add(ContactInfo.fromJson(v));
      });
      _handleList(_contacts);
    });
    // List.generate(50, (index) => model.add(ContactInfo(name: faker.person.firstName()+" "+faker.person.lastName())));
    // _handleList(model);

  }

  void _handleList(List<ContactInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(_contacts);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(_contacts);

    // add header.
    _contacts.insert(0, ContactInfo(name: 'header', tagIndex: '↑'));

    setState(() {});
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          "https://i.pravatar.cc/150?img=10".toNetWorkImage(borderRadius: 8,width: 60),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "远行",
              textScaleFactor: 1.2,
            ),
          ),
          Text("+86 182-286-44678"),
        ],
      ),
    );
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: susItemHeight,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          susTag.toSubTitle2(color: Colors.white,fontWeight: FontWeight.bold).toContainer(
            alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.colorPrimary)),
          Expanded(
              child: Divider(
                height: 1,
                indent: 10.0,
              ))
        ],
      ),
    );
  }

  Widget _buildListItem(ContactInfo model,int index) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        10.toSizedBox,
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        10.toSizedBox,
        [
          Stack(
          children: [
            "https://i.pravatar.cc/150?img=$index}"
                .toNetWorkImage(borderRadius: 8, height: 60, width: 60)
                .toContainer(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8))),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,width: 2),
                      shape: BoxShape.circle, color: Colors.green),
                )),
          ],
        ),
          [
            faker.person.name().toSubTitle2(fontWeight: FontWeight.bold),
            "@${faker.person.firstName().toLowerCase()}".toCaption()
          ].toColumn(mainAxisAlignment: MainAxisAlignment.center).toHorizontalPadding(12).toExpanded()
        ].toRow(crossAxisAlignment: CrossAxisAlignment.center).toHorizontalPadding(12)
      ],
    ).toHorizontalPadding(16);
  }

  Decoration getIndexBarDecoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey[300], width: .5));
  }

  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: BackButton(onPressed: (){
            BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.groups());
          },color: Colors.black,),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.colorPrimary),
          centerTitle: true,
          title: "Financial Development".toSubTitle1(fontWeight: FontWeight.bold),
          actions: [
            ["Invite","New Activity","Recent Post","Leave Group","Report Group"].toPopUpMenuButton((value) { },icon: RotatedBox(
                quarterTurns: 45,
                child: Icon(FontAwesomeIcons.ellipsisV,color: Colors.grey,)))
          ],
          bottom: PreferredSize(preferredSize: Size(context.getScreenWidth, 120.toHeight),
            child: [
              "Search group content".toSearchBarField(fieldValidator: FieldValidators(null, null)).toPadding(12),
              TabBar(
                isScrollable: true,
                // indicatorColor: AppColors.colorPrimary,
                  indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.colorPrimary,width: 3),insets: EdgeInsets.only(left:20,right: 20)),
                labelColor:  Colors.black,
                  unselectedLabelColor: Colors.black.withOpacity(.5),
                  tabs: [
                    Tab(text: "Post",),
                    Tab(text: "Members",),
                    Tab(text: "About",),

                    // "Post".toTab(),
                    // "Members".toTab(),
                    // "About".toTab(),
                  ]),

            ].toColumn(),

          ),
        ),
        body: TabBarView(
          children: [
            Container(child: [PostItem(),Divider(thickness: 1,)].toColumn(),),
            AzListView(
              data: _contacts,
              itemCount: _contacts.length,

              itemBuilder: (BuildContext context, int index) {
                if (index == 0) return Container();
                ContactInfo model = _contacts[index];
                return _buildListItem(model,index);
              },
              physics: BouncingScrollPhysics(),
              indexBarData: SuspensionUtil.getTagIndexList(_contacts),
              indexHintBuilder: (context, hint) {
                return Container(
                  alignment: Alignment.center,
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: AppColors.colorPrimary,
                    shape: BoxShape.circle,
                  ),
                  child:
                  Text(hint, style: TextStyle(color: Colors.white, fontSize: 30.0)),
                );
              },
              indexBarMargin: EdgeInsets.all(10),
              indexBarOptions: IndexBarOptions(
                needRebuild: true,
                selectItemDecoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.colorPrimary),
                selectTextStyle: AppTheme.subTitle2.copyWith(color: Colors.white),
                decoration: getIndexBarDecoration(Colors.grey[50]),
                downDecoration: getIndexBarDecoration(Colors.grey[200]),
              ),
            ),
            Container(child: [PostItem(),Divider(thickness: 1,)].toColumn(),),
          ],
        ),
      ),
    );
  }
}

class ContactInfo extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;

  Color bgColor;
  IconData iconData;

  String img;
  String id;
  String firstletter;

  ContactInfo({
    this.name,
    this.tagIndex,
    this.namePinyin,
    this.bgColor,
    this.iconData,
    this.img,
    this.id,
    this.firstletter,
  });

  ContactInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        img = json['img'],
        id = json['id']?.toString(),
        firstletter = json['firstletter'];

  Map<String, dynamic> toJson() => {
//        'id': id,
    'name': name,
    'img': img,
//        'firstletter': firstletter,
//        'tagIndex': tagIndex,
//        'namePinyin': namePinyin,
//        'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => json.encode(this);
}