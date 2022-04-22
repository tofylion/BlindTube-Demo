import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blindtube/components/comment_card.dart';
import 'package:blindtube/components/sub_button.dart';
import 'package:blindtube/components/tappable.dart';
import 'package:blindtube/components/video_card.dart';
import 'package:blindtube/engines/videoRecommender.dart';
import 'package:blindtube/hero_control.dart';
import 'package:blindtube/pages/creator_page.dart';
import 'package:blindtube/structure/creator.dart';
import 'package:blindtube/structure/server.dart';
import 'package:blindtube/structure/video.dart';
import 'package:blindtube/styles/constants.dart';
import 'package:blindtube/styles/palette.dart';
import 'package:blindtube/styles/videoPlayerStyle.dart';
import 'package:blindtube/testing/database.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sprung/sprung.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    required this.videoId,
    this.heroIndex,
  });

  final int videoId;
  final int? heroIndex;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  TargetPlatform? _platform;
  late VideoPlayerController videoPlayerController;
  ChewieController? _chewieController;

  late List<int> recommendedVideos;

  @override
  void initState() {
    super.initState();
    initialisePlayer();
    recommendedVideos = VideoRecommender.recommendOnUser(
      Server.videos,
      Database.user,
    );
  }

  @override
  void dispose() async {
    videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
    Duration checkpoint = Server.checkPointVideo(
      Database.user,
      Server.getVideoById(widget.videoId),
      (await videoPlayerController.position) as Duration,
    );
    // super.dispose();
  }

  Future<void> initialisePlayer() async {
    Duration checkpoint = Server.resumeVideo(
      Database.user,
      Server.getVideoById(widget.videoId),
    );

    videoPlayerController = VideoPlayerController.asset(
        Server.getVideoById(widget.videoId).videoPath);

    await Future.wait([
      videoPlayerController.initialize(),
    ]);
    _createChewieController();
    _chewieController!.seekTo(checkpoint);
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      allowedScreenSleep: false,
      placeholder: Container(
        color: Colors.transparent,
      ),
      showOptions: false,
      zoomAndPan: false,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft
      ],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      hideControlsTimer: videoControlsHide,
      cupertinoProgressColors: videoPlayerTheme,
    );
  }

  bool descCollapsed = true;
  bool commentsShown = false;
  final PanelController _panelController = PanelController();

  int? nonFinalHeroIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.heroIndex == null) {
      nonFinalHeroIndex = -HeroControl.generateHeroIndex();
    } else {
      nonFinalHeroIndex = widget.heroIndex;
    }

    final Video video = Server.getVideoById(widget.videoId);
    bool videoLiked = Database.user.likedVideos.contains(video);
    Creator creator = Server.getCreatorById(video.creator.id);
    bool subbed = Database.user.subbedTo.contains(creator);
    Image placeholderImage = Image.asset(video.picPath);
    Widget playerWidget = _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? Chewie(controller: _chewieController!)
        : Center(
            child: placeholderImage,
          );

    double width = MediaQuery.of(context).size.width;
    double scale = width / videoPlayerController.value.size.width;
    double vidHeight = scale * videoPlayerController.value.size.height;

    final String videoLength = video.getLengthAsString();
    final String desc = video.description;
    final String videoViews = video.getViewsAsString();
    final Creator videoCreator = video.creator;
    final String creatorSubs = videoCreator.getSubsAsString();

    final double _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Scaffold(
      // backgroundColor: foregroundColor,
      body: SlidingUpPanel(
        controller: _panelController,
        parallaxEnabled: true,
        parallaxOffset: 0.25,
        backdropEnabled: true,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        maxHeight: _panelHeightOpen,
        panelSnapping: true,
        minHeight: 0,
        onPanelClosed: () {
          setState(() {
            commentsShown = false;
          });
        },
        onPanelOpened: () {
          setState(() {
            commentsShown = true;
          });
        },
        panelBuilder: (sc) => _panel(sc),
        color: foregroundColor,
        body: SafeArea(
          top: true,
          left: false,
          right: false,
          child: Column(
            children: [
              AnimatedContainer(
                // clipBehavior: Clip.antiAlias,
                duration: const Duration(
                  milliseconds: 1000,
                ),

                height: !vidHeight.isNaN ? vidHeight : 300,
                // constraints: BoxConstraints(
                //   maxHeight: !vidHeight.isNaN ? vidHeight : 500,
                // ),
                curve: Sprung.overDamped.flipped,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'video' + nonFinalHeroIndex.toString(),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onScaleUpdate: (details) {
                      // print(details.scale);
                      if (details.scale > 1.3) {
                        _chewieController!.enterFullScreen();
                      }
                    },
                    onVerticalDragUpdate: (details) {
                      if (details.primaryDelta! <= -10) {
                        _chewieController!.enterFullScreen();
                      } else if (details.primaryDelta! >= 10) {
                        Navigator.pop(context);
                      }
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: videoPlayerElevation,
                      borderRadius: videoPlayerBorderRadius,
                      clipBehavior: Clip.hardEdge,
                      shadowColor: videoPlayerShadow,
                      child: playerWidget,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  shrinkWrap: true,
                  clipBehavior: Clip.antiAlias,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            child: Hero(
                              transitionOnUserGestures: true,
                              tag: 'title' + nonFinalHeroIndex.toString(),
                              child: AutoSizeText(
                                video.title,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                                softWrap: true,
                                textScaleFactor: 0.8,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: 'info' + nonFinalHeroIndex.toString(),
                                child: Row(
                                  children: [
                                    Text(
                                      videoLength,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const VerticalDivider(),
                                    Text(
                                      videoViews + ' views',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const VerticalDivider(),
                                    Text(
                                      video.getPublishDateAsString(),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 30,
                                    ),
                                    child: CustomLikeButton(
                                      isLiked: videoLiked,
                                      onTap: (isLiked) {
                                        setState(() {
                                          if (videoLiked) {
                                            Server.unlikeVideo(
                                              Database.user,
                                              video,
                                            );
                                          } else {
                                            Server.likeVideo(
                                              Database.user,
                                              video,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Tappable(
                                    behavior: HitTestBehavior.deferToChild,
                                    fadeInDuration:
                                        const Duration(milliseconds: 2000),
                                    child: Container(
                                      // width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: navBarColor,
                                        border: Border.all(
                                          width: 0.5,
                                          color: mainTextColor,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.message,
                                          color: mainTextColor,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        commentsShown = !commentsShown;
                                      });
                                      return _panelController.open();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Tappable(
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: 'desc' + nonFinalHeroIndex.toString(),
                                child: Text(
                                  desc,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  maxLines: descCollapsed ? 3 : 100,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              onTap: () {
                                // print(descCollapsed);
                                setState(() {
                                  descCollapsed = !descCollapsed;
                                });
                              },
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Tappable(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return CreatorPage(
                                                creatorId: creator.id,
                                                heroIndex: nonFinalHeroIndex,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Hero(
                                            transitionOnUserGestures: true,
                                            tag: 'creatorPic' +
                                                nonFinalHeroIndex.toString(),
                                            child: Container(
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
                                                      videoCreator.picPath,
                                                      // width: 60,
                                                      isAntiAlias: true,
                                                    ).image,
                                                    width: 135,
                                                    allowUpscaling: true,
                                                  ),
                                                  width: 60,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5,
                                                  ),
                                                  child: Text(
                                                    videoCreator.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5,
                                                  ),
                                                  child: Text(
                                                    creatorSubs +
                                                        ' subscribers',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SubButton(
                                      subbed: subbed,
                                      onTap: () {
                                        setState(() {
                                          if (subbed) {
                                            Server.unSubFromCreator(
                                              Database.user,
                                              creator,
                                            );
                                          } else {
                                            Server.subToCreator(
                                              Database.user,
                                              creator,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    // SliverList(
                    //   delegate: SliverChildListDelegate([
                    //     Text('Watch next'),
                    //   ]),
                    // ),
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      excludeHeaderSemantics: true,
                      pinned: true,
                      backgroundColor: navBarColor.withOpacity(0.8),
                      elevation: 0,
                      expandedHeight: 150,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          color: backgroundColor,
                        ),
                        titlePadding: EdgeInsets.zero,
                        expandedTitleScale: 1.2,
                        centerTitle: false,
                        title: Stack(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: blurRadius,
                                sigmaY: blurRadius,
                              ),
                              child: Container(
                                color: backgroundColor.withOpacity(0.3),
                              ),
                            ),
                            Center(
                              heightFactor: 7,
                              widthFactor: 2.5,
                              child: Text(
                                'Watch Next',
                                textAlign: TextAlign.left,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          //TODO: build recommended videos based on current video
                          int heroIndex = HeroControl.generateHeroIndex();
                          int curVideoId = recommendedVideos[index];
                          return Column(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 20,
                              ),
                              child: Tappable(
                                onTap: () async {
                                  var page = await HeroControl.buildPageAsync(
                                      VideoPage(
                                    videoId: curVideoId,
                                    heroIndex: heroIndex,
                                  ));
                                  var route =
                                      MaterialPageRoute(builder: (_) => page);

                                  Navigator.pushReplacement(context, route);
                                },
                                child: VideoCard(
                                  videoId: curVideoId,
                                  heroIndex: heroIndex,
                                ),
                              ),
                            ),
                            const Divider(
                              indent: 50,
                              endIndent: 50,
                            ),
                          ]);
                        },
                        childCount: recommendedVideos.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController inputFieldController = TextEditingController();
  FocusNode textFieldFocused = FocusNode();
  Widget _panel(ScrollController sc) {
    Video video = Server.getVideoById(widget.videoId);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onVerticalDragUpdate: (update) {
          // print(update.primaryDelta);
          if (update.primaryDelta! > 4) {
            // FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Column(
          children: [
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: const BoxDecoration(
                      color: dividerColor,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                // physics: BouncingScrollPhysics(),
                scrollBehavior: const ScrollBehavior(
                  androidOverscrollIndicator:
                      AndroidOverscrollIndicator.stretch,
                ),
                controller: sc,
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    // excludeHeaderSemantics: true,
                    // pinned: true,
                    floating: true,
                    snap: true,
                    backgroundColor: foregroundColor.withOpacity(0.8),
                    elevation: 0,
                    expandedHeight: 100,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: foregroundColor,
                      ),
                      titlePadding: EdgeInsets.zero,
                      expandedTitleScale: 1.2,
                      centerTitle: false,
                      title: Stack(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: blurRadius,
                              sigmaY: blurRadius,
                            ),
                            child: Container(
                              color: foregroundColor.withOpacity(0.3),
                            ),
                          ),
                          Center(
                            heightFactor: 7,
                            widthFactor: 3,
                            child: Text(
                              'Comments',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                      top: buttonBorderRadius,
                                    ),
                                    color: navBarColor),
                                height: 60,
                                child: TextField(
                                  onChanged: (value) {
                                    if (value.length <= 1) {
                                      setState(() {});
                                    }
                                  },
                                  // focusNode: textFieldFocused,
                                  controller: inputFieldController,

                                  decoration: InputDecoration(
                                    hintText: 'Leave a Comment',
                                    hintStyle:
                                        Theme.of(context).textTheme.titleSmall,
                                    border: const OutlineInputBorder().copyWith(
                                      borderRadius: const BorderRadius.vertical(
                                        top: buttonBorderRadius,
                                      ),
                                    ),
                                    focusedBorder:
                                        const OutlineInputBorder().copyWith(
                                      borderRadius: const BorderRadius.vertical(
                                        top: buttonBorderRadius,
                                      ),
                                      borderSide: const BorderSide(
                                        color: secondaryColor,
                                      ),
                                    ),
                                    enabledBorder:
                                        const OutlineInputBorder().copyWith(
                                      borderRadius: const BorderRadius.vertical(
                                        top: buttonBorderRadius,
                                      ),
                                      borderSide: const BorderSide(
                                        color: navBarColor,
                                      ),
                                    ),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  expands: true,
                                  maxLines: null,
                                  minLines: null,
                                  maxLength: null,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.none,
                                  cursorColor: secondaryColor,
                                ),
                              ),
                              Tappable(
                                onTap: () {
                                  setState(
                                    () {
                                      video.addComment(
                                        content: inputFieldController.text,
                                        commenter: Database.user,
                                        postDate: DateTime.now(),
                                      );
                                      inputFieldController.clear();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(
                                    milliseconds: 1000,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  curve: Sprung.overDamped,
                                  height:
                                      inputFieldController.text != '' ? 50 : 0,
                                  decoration: const BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.vertical(
                                      bottom: buttonBorderRadius,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      inputFieldController.text != ''
                                          ? 'Post Comment'
                                          : '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: secondaryTextColor,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      //TODO: implement building the comments from the video list
                      ((context, index) {
                        return CommentCard(
                          comment: video.comments[index],
                          canDelete: true,
                          onDelete: () {
                            video.deleteComment(video.comments[index]);
                            setState(() {});
                          },
                        );
                      }),
                      childCount: video.comments.length,
                    ),
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

class CustomLikeButton extends StatefulWidget {
  CustomLikeButton({required this.isLiked, required this.onTap});
  bool isLiked;
  Function(bool isLiked) onTap;

  @override
  State<CustomLikeButton> createState() => _CustomLikeButtonState();
}

class _CustomLikeButtonState extends State<CustomLikeButton> {
  @override
  Widget build(BuildContext context) {
    bool isLiked = widget.isLiked;
    return Tappable(
      behavior: HitTestBehavior.deferToChild,
      fadeInDuration: const Duration(milliseconds: 2000),
      child: Container(
        // width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: navBarColor,
          border: Border.all(
            width: 0.5,
            color: isLiked ? secondaryColor : mainTextColor,
          ),
        ),
        child: Center(
          child: LikeButton(
            onTap: (like) async {
              isLiked = !isLiked;
              widget.isLiked = like;
              setState(() {});
              widget.onTap(isLiked);

              return !like;
            },
            size: 40,
            padding: const EdgeInsets.only(left: 2.5, top: 3),
            circleColor: const CircleColor(
              start: darkerBackground,
              end: secondaryColor,
            ),
            isLiked: isLiked,
            animationDuration: const Duration(milliseconds: 800),
            likeCountAnimationType: LikeCountAnimationType.none,
            likeBuilder: (bool isLiked) {
              return Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 40,
                color: isLiked ? secondaryColor : mainTextColor,
              );
            },
            bubblesColor: const BubblesColor(
              dotPrimaryColor: secondaryColor,
              dotSecondaryColor: darkerBackground,
            ),
          ),
        ),
      ),
    );
  }
}
