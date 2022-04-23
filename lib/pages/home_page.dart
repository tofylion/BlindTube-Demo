import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/components/creator_card.dart';
import 'package:blindtube/components/video_card.dart';
import 'package:blindtube/engines/videoRecommender.dart';
import 'package:blindtube/hero_control.dart';
import 'package:blindtube/pages/creator_page.dart';
import 'package:blindtube/pages/video_list_page.dart';
import 'package:blindtube/pages/video_page.dart';
import 'package:blindtube/structure/creator.dart';
import 'package:blindtube/structure/server.dart';
import 'package:blindtube/structure/video.dart';
import 'package:blindtube/styles/constants.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:blindtube/testing/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spring_button/spring_button.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

List<Video> videosList = Server.getVideosAsList();
List<Creator> creatorsList = Server.getCreatorsAsList();

class HomePage extends StatefulWidget {
  const HomePage({this.heroIndex});

  final int? heroIndex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int nonFinalHeroIndex;
  @override
  Widget build(BuildContext context) {
    if (widget.heroIndex != null) {
      nonFinalHeroIndex = widget.heroIndex!;
    } else {
      nonFinalHeroIndex = -HeroControl.generateHeroIndex();
    }
    List<int> watchedVideosList = Database.user.getWatchedVideosAsList();
    List<int> recommendedVideos =
        VideoRecommender.recommendOnUser(Server.videos, Database.user);
    List<int> heroIndices1 = [];
    for (var _ in watchedVideosList) {
      heroIndices1.add(HeroControl.generateHeroIndex());
    }
    List<int> heroIndices2 = [];
    for (var _ in recommendedVideos) {
      heroIndices2.add(HeroControl.generateHeroIndex());
    }
    return Scaffold(
      // backgroundColor: navBarColor,
      body: SafeArea(
        top: true,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          // scrollBehavior: ScrollBehavior(
          //   androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
          // ),
          clipBehavior: Clip.antiAlias,
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 300,
              pinned: true,
              automaticallyImplyLeading: false,
              excludeHeaderSemantics: true,
              // snap: true,
              // floating: true,
              stretch: true,
              stretchTriggerOffset: 100,
              onStretchTrigger: () async {
                SchedulerBinding.instance?.addPostFrameCallback((_) {
                  setState(() {});
                });
                return;
              },

              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(vertical: 8),
                centerTitle: true,
                stretchModes: const [
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                collapseMode: CollapseMode.pin,
                title: Center(
                  heightFactor: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 100,
                          maxWidth: 80,
                        ),
                        child: Hero(
                          tag: 'logo' + nonFinalHeroIndex.toString(),
                          child: SpringButton(
                            SpringButtonType.OnlyScale,
                            Image(
                              image: ResizeImage(
                                Image.asset('assets/images/BlindTubeLogo.png')
                                    .image,
                                width: 240,
                              ),
                            ),
                            useCache: true,
                            onTap: () {},
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'BLIND',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            'TUBE',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: darkerBackground,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  watchedVideosList.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CarouselTopBar(
                              barName: 'Continue Watching',
                              refresh: () {
                                setState(() {});
                              },
                              videoIds: watchedVideosList,
                              heroIndices: heroIndices1,
                            ),
                            SizedBox(
                              height: carouselHeight,
                              child: InfiniteCarousel.builder(
                                itemCount: watchedVideosList.length,
                                itemExtent: carouselItemWidth,
                                loop: false,
                                physics: const BouncingScrollPhysics(),
                                axisDirection: Axis.horizontal,
                                itemBuilder: (context, itemIndex, realIndex) {
                                  int heroIndex = heroIndices1[realIndex];
                                  int curVideo = watchedVideosList[realIndex];
                                  return Tappable(
                                    onTap: () async {
                                      var page =
                                          await HeroControl.buildPageAsync(
                                        VideoPage(
                                          videoId: curVideo,
                                          heroIndex: heroIndex,
                                        ),
                                      );
                                      var route = MaterialPageRoute(
                                          builder: (_) => page);

                                      Navigator.push(context, route);
                                      SchedulerBinding.instance
                                          ?.addPostFrameCallback((_) {
                                        setState(() {});
                                      });
                                    },
                                    child: VideoCard(
                                      videoId: curVideo,
                                      heroIndex: heroIndex,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Divider(
                              indent: dividerIndent,
                              endIndent: dividerIndent,
                            ),
                          ],
                        )
                      : SizedBox(),
                  recommendedVideos.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CarouselTopBar(
                              barName: 'Watch Next',
                              refresh: () {
                                setState(() {});
                              },
                              videoIds: recommendedVideos,
                              heroIndices: heroIndices2,
                            ),
                            SizedBox(
                              height: carouselHeight,
                              child: InfiniteCarousel.builder(
                                itemCount: recommendedVideos.length,
                                itemExtent: carouselItemWidth,
                                loop: false,
                                physics: const BouncingScrollPhysics(),
                                axisDirection: Axis.horizontal,
                                itemBuilder: (context, itemIndex, realIndex) {
                                  //TODO: implement building the videos from the recommender
                                  int curVideoId = recommendedVideos[realIndex];
                                  int heroIndex = heroIndices2[realIndex];
                                  return Tappable(
                                    onTap: () async {
                                      var page =
                                          await HeroControl.buildPageAsync(
                                              VideoPage(
                                        videoId: curVideoId,
                                        heroIndex: heroIndex,
                                      ));
                                      var route = MaterialPageRoute(
                                          builder: (_) => page);

                                      Navigator.push(context, route);
                                      SchedulerBinding.instance
                                          ?.addPostFrameCallback((_) {
                                        setState(() {});
                                      });
                                    },
                                    child: VideoCard(
                                      videoId: curVideoId,
                                      heroIndex: heroIndex,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Divider(
                              indent: dividerIndent,
                              endIndent: dividerIndent,
                            ),
                          ],
                        )
                      : SizedBox(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Creators',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: SizedBox(
                          height: 180,
                          child: InfiniteCarousel.builder(
                            itemCount: creatorsList.length,
                            itemExtent: 130,
                            velocityFactor: 0.2,
                            loop: false,
                            center: false,
                            physics: const BouncingScrollPhysics(),
                            axisDirection: Axis.horizontal,
                            itemBuilder: (context, itemIndex, realIndex) {
                              int heroIndex = HeroControl.generateHeroIndex();
                              Creator curCreator = creatorsList[realIndex];
                              return Tappable(
                                child: CreatorCard(
                                  creator: curCreator,
                                  heroIndex: heroIndex,
                                ),
                                onTap: () async {
                                  var page = await HeroControl.buildPageAsync(
                                    CreatorPage(
                                      creatorId: curCreator.id,
                                      heroIndex: heroIndex,
                                    ),
                                  );
                                  var route =
                                      MaterialPageRoute(builder: (_) => page);
                                  Navigator.push(context, route).then((_) {
                                    SchedulerBinding.instance
                                        ?.addPostFrameCallback((_) {
                                      setState(() {});
                                    });
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselTopBar extends StatelessWidget {
  CarouselTopBar(
      {required this.barName,
      this.refresh,
      required this.videoIds,
      this.heroIndices});

  final String barName;
  Function()? refresh;
  final List<int> videoIds;
  final List<int>? heroIndices;
  @override
  Widget build(BuildContext context) {
    int heroIndex = HeroControl.generateHeroIndex();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Hero(
                transitionOnUserGestures: true,
                tag: heroIndex,
                child: Text(
                  barName,
                  style: Theme.of(context).textTheme.headlineMedium,
                  softWrap: true,
                ),
              ),
            ),
            Expanded(
              child: Tappable(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VideoListPage(
                      comingFrom: barName,
                      heroIndex: heroIndex,
                      videoIds: videoIds,
                      videoHeroIndices: heroIndices,
                    );
                  })).then((_) {
                    if (refresh != null) {
                      SchedulerBinding.instance?.addPostFrameCallback((_) {
                        refresh!();
                      });
                    }
                  });
                },
                child: Center(
                  child: Text(
                    'View All',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
