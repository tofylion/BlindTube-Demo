import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/components/video_card.dart';
import 'package:blindtube/hero_control.dart';
import 'package:blindtube/pages/video_page.dart';
import 'package:blindtube/styles/constants.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:blindtube/testing/test_intialisers.dart';
import 'package:flutter/material.dart';

class VideoListPage extends StatelessWidget {
  const VideoListPage({required this.comingFrom, this.heroIndex});
  //TODO: have as input a list or map of videos render

  final String comingFrom;
  final int? heroIndex;

  @override
  Widget build(BuildContext context) {
    int nonFinalHeroIndex = 0;
    if (heroIndex != null) {
      nonFinalHeroIndex = heroIndex as int;
    } else {
      nonFinalHeroIndex = -HeroControl.generateHeroIndex();
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: darkerBackground.withOpacity(0.5),
              // floating: true,
              // snap: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                expandedTitleScale: 1,
                centerTitle: true,
                title: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: blurRadius,
                        sigmaY: blurRadius,
                      ),
                      child: Container(
                        color: darkerBackground.withOpacity(0.5),
                      ),
                    ),
                    Center(
                      child: Hero(
                        transitionOnUserGestures: true,
                        tag: nonFinalHeroIndex,
                        child: Text(
                          comingFrom,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, itemCount) {
                int heroIndex = HeroControl.generateHeroIndex();
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 20,
                    ),
                    child: Tappable(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return VideoPage(
                                video: appleWorkHome,
                                heroIndex: heroIndex,
                              );
                            },
                          ),
                        );
                      },
                      child: VideoCard(
                        video: appleWorkHome,
                        heroIndex: heroIndex,
                      ),
                    ),
                  ),
                  Divider(
                    indent: 50,
                    endIndent: 50,
                  ),
                ]);
              }, childCount: 5),
            ),
          ],
        ),
      ),
    );
  }
}
