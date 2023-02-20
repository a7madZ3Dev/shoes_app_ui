import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.child,
    this.color,
    this.width = 50,
    this.height = 50,
    this.onTap,
    this.margin,
    this.padding,
    this.borderRadius,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final Color? color;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.white,
      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            margin: margin,
            padding: padding,
            height: height,
            width: width,
            child: child,
          )),
    );
  }
}
