import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/styles/constants.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:flutter/material.dart';

class SubButton extends StatefulWidget {
  const SubButton({
    required this.subbed,
    this.onTap,
    this.height,
    this.width,
  });

  final bool subbed;
  final Function()? onTap;
  final double? height;
  final double? width;

  @override
  State<SubButton> createState() => _SubButtonState();
}

class _SubButtonState extends State<SubButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
        setState(() {});
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.subbed ? darkerBackground : secondaryColor,
          borderRadius: BorderRadius.all(
            buttonBorderRadius,
          ),
        ),
        child: Center(
          child: Text(
            'Subscribe' + (widget.subbed ? 'd' : ''),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: widget.subbed ? secondaryColor : secondaryTextColor,
                ),
          ),
        ),
      ),
    );
  }
}
