import 'dart:io';

import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/core/common/widget/custom_input_field.dart';
import 'package:colibri/core/extensions/string_extensions.dart';
import 'package:colibri/core/extensions/widget_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_compress/video_compress.dart';

import 'core/theme/app_theme.dart';

export 'package:colibri/core/extensions/context_exrensions.dart';
export 'package:colibri/core/extensions/string_extensions.dart';
export 'package:colibri/core/extensions/text_extensions.dart';
export 'package:colibri/core/extensions/widget_extensions.dart';

extension DioExtension on DioError {
  String get handleError {
    String errorDescription = "";
    try {
      switch (this.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription = "Request failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout";
          break;
        case DioErrorType.RESPONSE:
          errorDescription = "${response.data["error"]["error"][0]}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout";
          break;
      }
    } catch (e) {
      errorDescription = "Something went wrong";
    }
//      } else {
//        errorDescription = "Unexpected error occured";
//      }
    return errorDescription;
  }
}

extension ScreenUtilExtension on num {
  num get toSp => ScreenUtil().setSp(this, allowFontScalingSelf: true);

  num get toWidth => ScreenUtil().setWidth(this);

  num get toHeight => ScreenUtil().setHeight(this);

  num get toHorizontal => ScreenUtil().setWidth(this);

  num get toVertical => ScreenUtil().setHeight(this);

  SizedBox get toSizedBox => SizedBox(
        height: this.h,
        width: this.w,
      );

  SizedBox get toSizedBoxVertical => SizedBox(height: this.h);

  SizedBox get toSizedBoxHorizontal => SizedBox(
        width: this.w,
      );

  Widget toContainer({num height, num width, Color color}) => Container(
        color: color,
        width: width.w,
        height: height.h,
      );
}

extension ExtensionContainer on Container {
  Container get autoScale => Container(
        width: this.constraints.maxWidth.w,
        height: this.constraints.maxHeight.h,
      );
}

extension ListWidgetExtension on List<Widget> {
  Column toColumn(
          {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
          CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
          MainAxisSize mainAxisSize = MainAxisSize.min}) =>
      Column(
        children: this,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
      );

  Row toRow(
          {MainAxisSize mainAxisSize = MainAxisSize.max,
          MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
          CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) =>
      Row(
        children: this,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
      );

  Wrap toWrap() => Wrap(
        children: this,
    textDirection: TextDirection.rtl,
        runAlignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
      );
}

extension ColmnExtension on Column {
  SingleChildScrollView makeScrollable({ScrollController scrollController}) => SingleChildScrollView(
    controller: scrollController,
        child: this,
      );
}

extension TextFieldExtension on TextField {
  Widget toStreamBuilder<T>({@required StreamValidators<T> validators}) =>
      CustomInputField<T>(
        decoration: this.decoration,
        maxLength: this.maxLength,
        maxLines: this.maxLines,
        onSubmit: this.onSubmitted,
        validators: validators,
      );
  Widget toPostBuilder<T>({@required StreamValidators<T> validators}) =>
      StreamBuilder<T>(
        stream: validators.stream,
        builder: (context, snapshot) => TextField(
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLength: 600,
          maxLines: this.maxLines,
          style: AppTheme.button.copyWith(fontWeight: FontWeight.w500),
          obscureText: validators.obsecureTextBool,
          focusNode: validators.focusNode,
          controller: validators.textController,
          decoration: this.decoration.copyWith(errorText: snapshot?.error),
          onChanged: (value){
            if(validators.text.length<601)validators.onChange(value);
          },
          onSubmitted: (value) {
            this.onSubmitted(value);
            if (validators.nextFocusNode != null)
              FocusScope.of(context).requestFocus(validators.nextFocusNode);
          },
        ),
      );
}

//extension CustomButtonExtension on CustomButton{
//  Widget toStreamBuilderButton<bool>(Stream<bool> stream)=>StreamBuilder(stream: stream,builder: (context,snapshot)=>CustomButton(text: text,fullWidth: fullWidth,onTap: snapshot.error?null:onTap,),);
//}
extension BoolExtension on bool {
  bool get not => this == false;
}

extension ListStringExtension on List<String> {
  Widget toPopUpMenuButton(StringToVoidFunc fun, {Widget icon}) =>
      PopupMenuButton<String>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        icon: icon != null ? icon : Icon(
                FontAwesomeIcons.arrowDown,
                size: 20,
                color: Colors.grey,
              ),
        onSelected: fun,
        padding: EdgeInsets.zero,
        itemBuilder: (context) {
          return this
              .map((choice) => PopupMenuItem<String>(
                    height: 25.h,
                    value: choice,
                    child: choice.toCaption(),
                  ))
              .toList();
        },
      ).toContainer();
}

typedef StringToVoidFunc = void Function(String);
typedef IntToVoidFunc = void Function(int);
typedef PaginationFunc<T> = Future<List<T>> Function<T>({@required int pageKey,@required int pageSize});
typedef CustomWidget<T> = Container Function(T item);

extension FileExtension on File{
  Future<MediaInfo> get compressVideo async => await VideoCompress.compressVideo(
    this.path,
    quality: VideoQuality.LowQuality,
    deleteOrigin: false, // It's false by default
  );

  Future<File> get getThumbnail async => await   VideoCompress.getFileThumbnail(
  this.path,
  quality: 50, // default(100)
  position: -1 // default(-1)
  );
}