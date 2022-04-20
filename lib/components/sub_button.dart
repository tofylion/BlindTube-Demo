<<<<<<< HEAD
version https://git-lfs.github.com/spec/v1
oid sha256:f097aa126666700fd2015574128e1d89abe10efd1beab1599e49aea06d72a40e
size 1445
=======
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
      fadeInDuration: Duration(seconds: 3),
      onTap: () {
        setState(() {});
        if (widget.onTap != null) {
          widget.onTap!();
        }
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
>>>>>>> 706e8ce (Finished video page and creator page)
