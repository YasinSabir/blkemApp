import 'package:colibri/core/common/buttons/custom_button.dart';
import 'package:colibri/core/theme/app_theme.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
extension TextExtension on Text {
  Widget toCustomButton(VoidCallback callBack, {bool fullWidth = true,Color color=AppColors.colorPrimary}) =>
      CustomButton(
        text: this.data,
        color: color,
        fullWidth: fullWidth,
        onTap: () {
          FocusManager.instance.primaryFocus.unfocus();
          callBack.call();
        },
      );

  StreamBuilder toStreamBuilderButton(
          Stream<bool> stream, VoidCallback callBack,
          {bool fullWidth = true}) =>
      StreamBuilder<bool>(
        stream: stream,
        initialData: false,
        builder: (c, snapshot) => CustomButton(
          color: snapshot.data != null && snapshot.data
              ? AppColors.colorPrimary
              : AppColors.colorPrimary.withOpacity(.5),
          text: this.data,
          fullWidth: fullWidth,
          onTap:(){
            // if(snapshot.data != null && snapshot.data )
              callBack.call();
            FocusManager.instance.primaryFocus.unfocus();
          },
        ),
      );

  FlatButton toFlatButton(VoidCallback callback, {Color color,RoundedRectangleBorder border}) => FlatButton(
        child: this,
    shape: border,
        color: color,
        onPressed: () {
          FocusManager.instance.primaryFocus.unfocus();
          callback.call();
        },
      );

  Text toAlign(TextAlign align) => Text(
        this.data,
        textAlign: align,
        style: this.style,
      );

  Text toUnderLine() => Text(
        this.data,
        style: this.style.copyWith(decoration: TextDecoration.underline),
        textAlign: textAlign,
      );

  StreamBuilder toTextStreamBuilder(Stream<String> stream) => StreamBuilder(
        builder: (_, sndapshot) => Text(
          sndapshot.data,
          style: this.style.copyWith(decoration: TextDecoration.underline),
          textAlign: textAlign,
        ),
        stream: stream,
      );

  StreamBuilder toVisibilityStreamBuilder(Stream<bool> stream) => StreamBuilder(
        initialData: false,
        builder: (_, sndapshot) => Visibility(
          visible: sndapshot.data,
          child: Text(
            this.data,
            style: this.style,
            textAlign: textAlign,
          ),
        ),
        stream: stream,
      );

  Widget toNoBorderTextField() => TextField(
        decoration:
            InputDecoration(border: InputBorder.none, hintText: this.data,labelStyle: AppTheme.caption.copyWith(fontWeight: FontWeight.bold)),
      );

  Widget toOutlinedBorder(VoidCallback callback,{double borderRadius=20})=> OutlineButton(
    padding: EdgeInsets.zero,
    child: this,
    onPressed: callback,
    borderSide: BorderSide(color: AppColors.colorPrimary, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
  ).toContainer(height: 25);
}
