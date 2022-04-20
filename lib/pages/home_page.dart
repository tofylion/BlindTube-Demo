import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/components/creator_card.dart';
import 'package:blindtube/components/video_card.dart';
import 'package:blindtube/hero_control.dart';
import 'package:blindtube/pages/creator_page.dart';
import 'package:blindtube/pages/video_list_page.dart';
import 'package:blindtube/pages/video_page.dart';
import 'package:blindtube/structure/creator.dart';
import 'package:blindtube/structure/server.dart';
import 'package:blindtube/structure/video.dart';
import 'package:blindtube/styles/constants.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:blindtube/testing/test_intialisers.dart';
import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

              // snap: true,
              // floating: true,
              stretch: true,

              onStretchTrigger: () async {
                print("Stretched");
              },
              stretchTriggerOffset: 200,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.symmetric(vertical: 8),
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
                        child: SpringButton(
                          SpringButtonType.OnlyScale,
                          Image.asset('assets/images/BlindTubeLogo.png'),
                          useCache: false,
                          onTap: () {},
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CarouselTopBar(barName: 'Continue Watching'),
                      SizedBox(
                        height: 350,
                        child: InfiniteCarousel.builder(
                          itemCount: 5,
                          itemExtent: 320,
                          loop: false,
                          physics: const BouncingScrollPhysics(),
                          axisDirection: Axis.horizontal,
                          itemBuilder: (context, itemIndex, realIndex) {
                            int heroIndex = HeroControl.generateHeroIndex();
                            return Tappable(
                              onTap: () async {
                                var page = await HeroControl.buildPageAsync(
                                  VideoPage(
                                    video: appleAtWorkHome,
                                    heroIndex: heroIndex,
                                  ),
                                );
                                var route =
                                    MaterialPageRoute(builder: (_) => page);

                                Navigator.push(context, route);
                              },
                              child: VideoCard(
                                video: appleAtWorkHome,
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
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CarouselTopBar(barName: 'Recommened'),
                      SizedBox(
                        height: 350,
                        child: InfiniteCarousel.builder(
                          itemCount: 5,
                          itemExtent: 320,
                          loop: false,
                          physics: const BouncingScrollPhysics(),
                          axisDirection: Axis.horizontal,
                          itemBuilder: (context, itemIndex, realIndex) {
                            //TODO: implement building the videos from the recommender
                            int heroIndex = HeroControl.generateHeroIndex();
                            return Tappable(
                              onTap: () async {
                                var page =
                                    await HeroControl.buildPageAsync(VideoPage(
                                  video: appleAtWorkHome,
                                  heroIndex: heroIndex,
                                ));
                                var route =
                                    MaterialPageRoute(builder: (_) => page);

                                Navigator.push(context, route);
                              },
                              child: VideoCard(
                                video: appleAtWorkHome,
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
                  ),
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
                            itemCount: 5,
                            itemExtent: 130,
                            velocityFactor: 0.2,
                            loop: false,
                            center: false,
                            physics: const BouncingScrollPhysics(),
                            axisDirection: Axis.horizontal,
                            itemBuilder: (context, itemIndex, realIndex) {
                              int heroIndex = HeroControl.generateHeroIndex();
                              return Tappable(
                                child: CreatorCard(
                                  creator: appleCreator,
                                  heroIndex: heroIndex,
                                ),
                                onTap: () async {
                                  var page = await HeroControl.buildPageAsync(
                                    CreatorPage(
                                      creator: appleCreator,
                                      heroIndex: heroIndex,
                                    ),
                                  );
                                  var route =
                                      MaterialPageRoute(builder: (_) => page);
                                  Navigator.push(context, route);
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
  const CarouselTopBar({required this.barName});

  final String barName;
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
                    );
                  }));
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
