import 'package:flutter/cupertino.dart';

import 'creator.dart';
import 'video.dart';
import 'defaults.dart';

class Server {
  ///The Server class is the one responsible for storing the data
  ///and handling all the requests to add, remove and fetch data.
  ///Data can be creators or videos stored in [creators] and [videos]
  ///The server is a dummy server representation of what might
  ///be the functionality of a real server and how it
  ///stores and manipulates the data
  ///
  ///When a creator or a video is removed from the server,
  ///the key is stored in the [removedCreatorKeys] or [removedVideoKeys]
  ///lists. This would make for efficient storage inside the maps
  ///where the deleted keys would be reassigned if more videos
  ///or creators are added.
  ///Comments are always fetched along with the videos as they
  ///are an attribute list
  ///

  Server();

  static Map<int, Creator> creators = <int, Creator>{};
  static List<int> removedCreatorKeys = [];
  static Map<int, Video> videos = <int, Video>{};
  static List<int> removedVideoKeys = [];

  static Video getVideoById(int id) {
    return videos[id]!;
  }

  static int uploadVideo({
    required videoPath,
    required DateTime publishDateTime,
    required DateTime length,
    required String title,
    required Creator creator,
    picPath = defaultVidPic,
    String description = '',
    int views = 0,
    int likes = 0,
  }) {
    ///Uploading a video would take all the video data to create
    ///a video and store it in the list.
    ///The video can then be fetched from this list again
    ///by the [getVideoById] method.
    ///
    ///When there is an empty space in the videos map,
    ///the empty indices are stored in the [removedVideos]
    ///list. They are then used here to fill the gaps.
    ///If there are no gaps, then the new ID is determined
    ///normally by adding a new entry in the map.
    ///
    ///The return value is the id of the newly uploaded video
    int id = 0;
    if (removedVideoKeys.isNotEmpty) {
      id = removedVideoKeys.removeLast();
    } else {
      id = videos.length;
    }
    Video newVid = Video(
      id: id,
      videoPath: videoPath,
      publishDateTime: publishDateTime,
      length: length,
      title: title,
      creator: creator,
      picPath: picPath,
      description: description,
      likes: likes,
      views: views,
    );

    videos[id] = newVid;
    creator.uploadVid(vid: newVid);

    return newVid.id;
  }

  static Video removeVideo(int id) {
    Video removed = videos.remove(id)!;
    removedVideoKeys.add(id);

    removed.creator.uploads.remove(removed);

    return removed;
  }

  static Creator getCreatorById(int id) {
    return creators[id]!;
  }

  static int addCreator({
    required name,
    picPath = defaultCreatorPic,
    subscribers = 0,
  }) {
    int id = 0;
    if (removedCreatorKeys.isNotEmpty) {
      id = removedCreatorKeys.removeLast();
    } else {
      id = creators.length;
    }
    Creator creator = Creator(
      id: id,
      name: name,
      picPath: picPath,
      subscribers: subscribers,
    );
    creators[id] = creator;

    return id;
  }

  static Creator removeCreator(int id) {
    Creator removed = creators.remove(id)!;
    removedCreatorKeys.add(id);
    for (int i = 0; i < removed.uploads.length; i++) {
      removeVideo(removed.uploads[i].id);
    }
    return removed;
  }

  static void likeVideo(Creator liker, Video video) {
    liker.likedVideos.add(video);
    video.likes++;
  }

  static void unlikeVideo(Creator unliker, Video video) {
    unliker.likedVideos.remove(video);
    video.likes--;
  }

  static void subToCreator(Creator subber, Creator creator) {
    subber.subscribeTo(creator);
  }

  static void unSubFromCreator(Creator unSubber, Creator creator) {
    unSubber.unSubFrom(creator);
  }

  static DateTime resumeVideo(Creator viewer, Video video) {
    int id = video.id;
    Map<int, DateTime> watched = viewer.watchedVideos;

    DateTime resumePoint;

    if (watched.containsKey(id)) {
      resumePoint = watched[id]!;
    } else {
      resumePoint = DateTime(0);
      watched[id] = resumePoint;
    }

    return resumePoint;
  }

  static void checkPointVideo(
    Creator viewer,
    Video video,
    DateTime checkPointTime,
  ) {
    int id = video.id;
    Map<int, DateTime> watched = viewer.watchedVideos;

    watched[id] = checkPointTime;
  }
}
