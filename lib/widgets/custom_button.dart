import 'package:face_detection/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isPrimary;
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final Color textcColor;
  const CustomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.isPrimary = false,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
    this.color,
    this.textcColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeMode = Provider.of<ThemeProvider>(context, listen: false).mode;
    return Material(
      // type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
      clipBehavior: Clip.antiAlias,
      color: color ??
          (isPrimary ? Theme.of(context).accentColor : Colors.transparent),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: color ??
                  (!isPrimary
                      ? Theme.of(context).accentColor.withOpacity(.2)
                      : Colors.transparent),
            ),
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
          ),
          child: Padding(
            padding: padding,
            child: Center(
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (child != null) child,
                    if (child != null)
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                        fontWeight: FontWeight.bold,
                        color: textcColor ??
                            (isPrimary
                                ? themeMode == ThemeStateMode.DarkMode
                                ? Colors.black
                                : Colors.white
                                : Theme.of(context)
                                .accentColor
                                .withOpacity(.9)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
