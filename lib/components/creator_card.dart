import 'package:auto_size_text/auto_size_text.dart';
import 'package:blindtube/hero_control.dart';
import 'package:blindtube/structure/creator.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:flutter/material.dart';

class CreatorCard extends StatelessWidget {
  CreatorCard({
    required this.creator,
    this.heroIndex,
  });

  final Creator creator;
  final int? heroIndex;
  double maxWidth = 225;
  double minWidth = 110;
  double maxHeight = 300;
  double minHeight = 155;
  BorderRadius cardBorderRadius = BorderRadius.all(Radius.circular(10));
  @override
  Widget build(BuildContext context) {
    int nonFinalHeroIndex = 0;
    if (heroIndex != null) {
      nonFinalHeroIndex = heroIndex as int;
    } else {
      nonFinalHeroIndex = -HeroControl.generateHeroIndex();
    }
    final String creatorSubs = creator.getSubsAsString();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          minWidth: minWidth,
          minHeight: minHeight,
        ),
        child: Material(
          elevation: 2,
          borderRadius: cardBorderRadius,
          child: Container(
            width: 110,
            height: 155,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  cardColor,
                  lighterCardColor,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
              borderRadius: cardBorderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 18,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'pic' + nonFinalHeroIndex.toString(),
                      child: ClipOval(
                        child: Image.asset(
                          creator.picPath,
                          height: 225 / 1.8,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Expanded(
                    flex: 6,
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'name' + nonFinalHeroIndex.toString(),
                      child: AutoSizeText(
                        creator.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 23,
                              color: whiteTextColor,
                            ),
                        softWrap: true,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'subs' + nonFinalHeroIndex.toString(),
                      child: Text(
                        creatorSubs,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
