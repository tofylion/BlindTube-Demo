<<<<<<< HEAD
version https://git-lfs.github.com/spec/v1
oid sha256:e387316043e7b97c00bdf063a1319c4c51310485781a7fd5167da5c5e147a51a
size 8516
=======
import 'package:blindtube/components/sub_button.dart';
import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/components/video_card.dart';
import 'package:blindtube/hero_control.dart';
import 'package:blindtube/pages/video_page.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:blindtube/testing/test_intialisers.dart';
import 'package:flutter/material.dart';
import 'package:blindtube/structure/creator.dart';

class CreatorPage extends StatelessWidget {
  const CreatorPage({required this.creator, this.heroIndex});

  final int? heroIndex;
  final Creator creator;
  @override
  Widget build(BuildContext context) {
    int nonFinalHeroIndex = 0;
    if (heroIndex != null) {
      nonFinalHeroIndex = heroIndex as int;
    } else {
      nonFinalHeroIndex = -HeroControl.generateHeroIndex();
    }
    bool subbed = true;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragUpdate: ((details) {
            if (details.primaryDelta! > 10) {
              Navigator.pop(context);
            }
          }),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                excludeHeaderSemantics: true,
                elevation: 0,
                expandedHeight: 200,
                collapsedHeight: 90,
                pinned: true,
                stretch: true,
                backgroundColor: navBarColor,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    // StretchMode.fadeTitle,
                  ],
                  expandedTitleScale: 1.8,
                  centerTitle: true,
                  background: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        backgroundColor,
                        navBarColor,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    )),
                  ),
                  title: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
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
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: 'pic' + nonFinalHeroIndex.toString(),
                          child: ClipOval(
                            child: Image(
                              image: ResizeImage(
                                Image.asset(
                                  creator.picPath,
                                  // width: 60,
                                  isAntiAlias: true,
                                ).image,
                                width: (180 * 1.8).toInt(),
                                allowUpscaling: true,
                              ),
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 0,
                        bottom: 20,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Hero(
                              transitionOnUserGestures: true,
                              tag: 'name' + nonFinalHeroIndex.toString(),
                              child: Text(
                                creator.name,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            Hero(
                              transitionOnUserGestures: true,
                              tag: 'subs' + nonFinalHeroIndex.toString(),
                              child: Text(
                                creator.getSubsAsString() + ' subscribers',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SubButton(
                                subbed: subbed,
                                height: 50,
                                onTap: () {
                                  //TODO: handle subbing and unsubbing
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  ((context, index) {
                    //TODO: build the videos for a creator sorted by the upload date: latest first
                    int heroIndex = HeroControl.generateHeroIndex();
                    return Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 20,
                        ),
                        child: Tappable(
                          onTap: () async {
                            var page =
                                await HeroControl.buildPageAsync(VideoPage(
                              video: appleAtWorkHome,
                              heroIndex: heroIndex,
                            ));
                            var route = MaterialPageRoute(builder: (_) => page);

                            Navigator.push(context, route);
                          },
                          child: VideoCard(
                            video: appleAtWorkHome,
                            heroIndex: heroIndex,
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 50,
                        endIndent: 50,
                      ),
                    ]);
                  }),
                  childCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
>>>>>>> 706e8ce (Finished video page and creator page)
