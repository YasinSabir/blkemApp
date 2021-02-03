

import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/core/theme/app_theme.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  final FieldValidators validators;
  SearchBar(this.hintText, this.validators);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>  {
  final  icons=[1.toSizedBoxVertical,Icon(Icons.close,size: 17,key: ValueKey(1),color: AppColors.colorPrimary,)];
  Widget currentIcons;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIcons=icons[0];
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget?.validators?.stream,
      builder: (context, snapshot) {
        return TextField(
          controller: widget.validators.textController,
          style: AppTheme.button.copyWith(fontWeight: FontWeight.w500),
          onChanged: (value){
            widget?.validators?.onChange(value);
            // setState(() {
            //   if(value.isNotEmpty){
            //     currentIcons=icons[1];
            //   }
            //   else currentIcons=icons[0];
            // });
          },
          decoration: InputDecoration(
              // contentPadding: const EdgeInsets.only(ri: 8),
            contentPadding: const EdgeInsets.all(8),
              // fillColor: Colors.black12,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: context.subTitle2.copyWith(fontWeight: FontWeight.bold),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left:16.0,top: 12,bottom: 12,right: 16),
                child: SvgPicture.asset(Images.search,height: 20,width: 20,),
              ),
              suffix: AnimatedSwitcher(
                transitionBuilder: (c,animation)=>ScaleTransition(
                  scale: animation,
                  child: c,
                ),
                child:currentIcons.onTap(() {
                  widget.validators.onChange(null);
                  widget.validators.textController.clear();
                  FocusManager.instance.primaryFocus.unfocus();
                },),duration: Duration(milliseconds: 200),
              ),
              labelStyle: AppTheme.caption.copyWith(fontWeight: FontWeight.bold)
          ),
        )
            .toContainer(
          height: 42,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(6)),);
            // .toPadding(12);
      }
    );
  }
}
