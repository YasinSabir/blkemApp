import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class CustomInputField<T> extends StatefulWidget {
  final StreamValidators<T> validators;
  final int maxLines;
  final int maxLength;
  final InputDecoration decoration;
  final StringToVoidFunc onSubmit;
  const CustomInputField({Key key, this.validators, this.maxLines, this.maxLength, this.decoration, this.onSubmit}) : super(key: key);
  @override
  _CustomInputFieldState createState() => _CustomInputFieldState<T>();
}

class _CustomInputFieldState<T> extends State<CustomInputField> {
  bool _visibility=false;
  @override
  Widget build(BuildContext context) {
    return _builder();
  }
  Widget _builder()=>StreamBuilder<T>(
  stream: widget.validators.stream,
  builder: (context, snapshot) => TextField(
  keyboardType: TextInputType.multiline,
  maxLength: widget.maxLength,
  maxLines: widget.maxLines,
  style: AppTheme.button.copyWith(fontWeight: FontWeight.w500),
  obscureText: widget.validators.obsecureTextBool,
  focusNode: widget.validators.focusNode,
  textInputAction: widget.validators.nextFocusNode == null
  ? TextInputAction.done
      : TextInputAction.next,
  controller: widget.validators.textController,
  decoration: widget.decoration.copyWith(
    suffixIcon: Icon(_visibility?FontAwesomeIcons.eye:FontAwesomeIcons.eyeSlash,size: 12,).onTap(() {
      setState(() {
        _visibility=!widget.validators.obsecureTextBool;
        widget.validators.changeObsecure(!widget.validators.obsecureTextBool);
      });
    }).toVisibility(widget.validators.isPasswordField)
  ),
  onChanged: widget.validators.onChange,
  onSubmitted: (value) {
  widget.onSubmit(value);
  if (widget.validators.nextFocusNode != null)
  FocusScope.of(context).requestFocus(widget.validators.nextFocusNode);
  },
  ).toThemeTextField,
  );
}
