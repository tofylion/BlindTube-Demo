import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/structure/comment.dart';
import 'package:blindtube/structure/creator.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class CommentCard extends StatefulWidget {
  const CommentCard(
      {required this.comment, this.canDelete = false, this.onDelete});

  final Comment comment;
  final bool canDelete;
  final Function()? onDelete;
  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool commentExpanded = false;
  double picSize = 40;
  bool deleteTriggered = false;

  @override
  Widget build(BuildContext context) {
    Creator commentCreator = widget.comment.commenter;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: secondaryColor,
                    width: 0.5,
                  ),
                  shape: BoxShape.circle,
                  color: cardColor,
                ),
                child: ClipOval(
                  child: Image(
                    image: ResizeImage(
                      Image.asset(
                        commentCreator.picPath,
                        isAntiAlias: true,
                      ).image,
                      width: 110,
                      allowUpscaling: true,
                    ),
                    width: picSize,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              commentCreator.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: whiteTextColor,
                                  ),
                            ),
                            VerticalDivider(),
                            Text(
                              widget.comment.getPostDateAsString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      Tappable(
                        onTap: () {
                          setState(() {
                            commentExpanded = !commentExpanded;
                          });
                        },
                        onLongPress: widget.canDelete
                            ? () {
                                setState(() {
                                  deleteTriggered = !deleteTriggered;
                                });
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            widget.comment.content,
                            maxLines: commentExpanded ? 15 : 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Tappable(
          onTap: widget.onDelete,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Sprung.overDamped,
            height: deleteTriggered ? 40 : 0,
            decoration: const BoxDecoration(
              color: wariningColor,
              borderRadius: BorderRadius.zero,
            ),
            child: Center(
              child: Text(
                'Delete Comment',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: secondaryTextColor,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
