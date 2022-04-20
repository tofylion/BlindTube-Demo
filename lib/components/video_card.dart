import 'package:blindtube/hero_control.dart';
import 'package:blindtube/structure/video.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  VideoCard({
    required this.video,
    this.elevation = 2,
    this.thumbnailBorderRadius = const BorderRadius.all(Radius.circular(15)),
    this.creatorBorder,
    this.heroIndex,
  });
  final Video video;
  final double elevation;
  final BorderRadius thumbnailBorderRadius;
  final int? heroIndex;
  BoxBorder? creatorBorder;

  double maxWidth = 500;
  double maxHeight = 300;
  @override
  Widget build(BuildContext context) {
    creatorBorder ??= Border.all(
      color: secondaryColor,
      width: 0.5,
    );
    final String thumbnail = video.picPath;
    final String creatorPic = video.creator.picPath;
    final String videoTitle = video.title;

    final String videoLength = video.getLengthAsString();
    final String desc = video.description;
    final String tagString = video.getTagsAsCollapsedString();
    final String videoViews = video.getViewsAsString();

    int? nonFinalHeroIndex;

    if (heroIndex == null) {
      nonFinalHeroIndex = HeroControl.generateHeroIndex();
    } else {
      nonFinalHeroIndex = heroIndex;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxHeight,
              maxWidth: maxWidth,
            ),
            child: Material(
              elevation: elevation,
              clipBehavior: Clip.antiAlias,
              borderRadius: thumbnailBorderRadius,
              child: ClipRRect(
                borderRadius: thumbnailBorderRadius,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'video' + nonFinalHeroIndex.toString(),
                  child: Image(
                    image: ResizeImage(
                      Image.asset(
                        thumbnail,
                        // width: 60,
                        isAntiAlias: true,
                      ).image,
                      width: 1002,
                      allowUpscaling: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 300,
              maxWidth: 500,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  transitionOnUserGestures: true,
                  tag: 'creatorPic' + nonFinalHeroIndex.toString(),
                  child: Container(
                    decoration: BoxDecoration(
                      border: creatorBorder,
                      shape: BoxShape.circle,
                      color: cardColor,
                    ),
                    child: ClipOval(
                      child: Image(
                        image: ResizeImage(
                          Image.asset(
                            creatorPic,
                            // width: 60,
                            isAntiAlias: true,
                          ).image,
                          width: 135,
                          allowUpscaling: true,
                        ),
                        width: 45,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'title' + nonFinalHeroIndex.toString(),
                      child: Text(
                        videoTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: IntrinsicHeight(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight,
                maxWidth: maxWidth,
              ),
              child: Hero(
                transitionOnUserGestures: true,
                tag: 'info' + nonFinalHeroIndex.toString(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      videoLength,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const VerticalDivider(),
                    ),
                    Text(
                      videoViews + ' views',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const VerticalDivider(),
                    ),
                    Text(
                      tagString,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 10,
            left: 10,
            top: 10,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxHeight,
              maxWidth: maxWidth,
            ),
            child: Hero(
              transitionOnUserGestures: true,
              tag: 'desc' + nonFinalHeroIndex.toString(),
              child: Text(
                desc,
                softWrap: true,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
