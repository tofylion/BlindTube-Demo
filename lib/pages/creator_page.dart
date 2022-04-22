import 'package:blindtube/components/sub_button.dart';
import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/components/video_card.dart';
import 'package:blindtube/hero_control.dart';
import 'package:blindtube/pages/video_page.dart';
import 'package:blindtube/structure/server.dart';
import 'package:blindtube/structure/video.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:blindtube/testing/database.dart';
import 'package:blindtube/testing/test_intialisers.dart';
import 'package:flutter/material.dart';
import 'package:blindtube/structure/creator.dart';

class CreatorPage extends StatefulWidget {
  const CreatorPage({required this.creatorId, this.heroIndex});

  final int? heroIndex;
  final int creatorId;

  @override
  State<CreatorPage> createState() => _CreatorPageState();
}

class _CreatorPageState extends State<CreatorPage> {
  @override
  Widget build(BuildContext context) {
    Creator creator = Server.getCreatorById(widget.creatorId);
    List<Video> videos = creator.uploads;
    videos.sort(
      ((Video a, Video b) {
        return b.publishDateTime.compareTo(a.publishDateTime);
      }),
    );
    // videos = videos.reversed.toList();
    int nonFinalHeroIndex = 0;
    if (widget.heroIndex != null) {
      nonFinalHeroIndex = widget.heroIndex as int;
    } else {
      nonFinalHeroIndex = -HeroControl.generateHeroIndex();
    }

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
                          tag: 'creator' + nonFinalHeroIndex.toString(),
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
                                subbed:
                                    Database.user.subbedTo.contains(creator),
                                height: 50,
                                onTap: () {
                                  bool subbed =
                                      Database.user.subbedTo.contains(creator);
                                  setState(() {
                                    if (subbed) {
                                      Server.unSubFromCreator(
                                          Database.user, creator);
                                    } else {
                                      Server.subToCreator(
                                        Database.user,
                                        creator,
                                      );
                                    }
                                  });
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
                    Video curVideo = videos[index];

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
                              videoId: curVideo.id,
                              heroIndex: heroIndex,
                            ));
                            var route = MaterialPageRoute(builder: (_) => page);

                            Navigator.push(context, route);
                          },
                          child: VideoCard(
                            videoId: curVideo.id,
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
                  childCount: videos.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
