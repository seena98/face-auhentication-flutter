import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomTextField extends StatelessWidget {
  final Function onChange;
  final String text;
  final TextInputType type;
  final bool isPassword;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int maxLines;
  final bool isLable;
  final EdgeInsetsGeometry customContentPadding;
  const CustomTextField({
    this.maxLines = 1,
    this.isLable = false,
    this.customContentPadding,
    Key key, this.onChange, this.text, this.type = TextInputType.text, this.isPassword = false,this.prefixIcon,this.suffixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) => onChange(text),
      keyboardType: type,
      obscureText: isPassword,
      maxLines: maxLines,
      decoration: customContentPadding != null?
      InputDecoration(
        labelText: isLable ? text:null,
        contentPadding: customContentPadding,//this line is added
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(
          color: Theme.of(context).accentColor.withOpacity(.7),
          fontSize: ScreenUtil().setSp(24),
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).accentColor.withOpacity(.7),
          fontSize: ScreenUtil().setSp(24),
        ),
        hintText: !isLable ? text:null,
        enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        border: Theme.of(context).inputDecorationTheme.border,
      ):
      InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          color: Theme.of(context).accentColor.withOpacity(.7),
          fontSize: ScreenUtil().setSp(24),
        ),
        hintText: text,
        enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        border: Theme.of(context).inputDecorationTheme.border,
      ),
    );
  }
}
