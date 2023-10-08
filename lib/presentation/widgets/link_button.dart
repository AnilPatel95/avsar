import 'package:avsar/core/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:avsar/core/ui.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;

  const LinkButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Text(text, style:TextStyles.body3),
    );
  }
}