import 'package:blindtube/structure/creator.dart';
import 'package:blindtube/structure/server.dart';
import 'package:blindtube/structure/video.dart';
import 'package:tuple/tuple.dart';

class VideoRecommender {
  static List<Video> recommendOnUser(Map<int, Video> allVids, Creator user) {
    ///Recommend videos to a user based on 3 parameters:
    ///
    ///liked videos
    ///subbed creators
    ///whether the video has been already watched or not

    List<Tuple2<Video, int>> vidsWithRecommendedScore = [];
    allVids.forEach((id, vid) {
      //Each video has a score to be more recommended. If the score is higher, it's more recommended
      int score = 0;
      //Parse liked videos and see common tags and common creators to award score
      user.likedVideos.forEach((vid2) {
        score += compareTags(vid.tags, vid2.tags);
        if (vid2.creator == vid.creator) {
          score++;
        }
      });
      //See if the video's creator is in the subbed list
      if (user.subbedTo.contains(vid.creator)) {
        score++;
      }
      //Only add the video if it hasn't been watched yet
      if (!(user.watchedVideos.containsKey(id))) {
        vidsWithRecommendedScore.add(Tuple2<Video, int>(vid, score));
      }
    });
    vidsWithRecommendedScore.sort((a, b) {
      return a.item2.compareTo(b.item2);
    });
    vidsWithRecommendedScore = List.from(vidsWithRecommendedScore.reversed);
    List<Video> res = [];
    for (int i = 0; i < vidsWithRecommendedScore.length; i++) {
      res.add(vidsWithRecommendedScore[i].item1);
    }
    return res;
  }

  static List<Video> recommendOnTags(
      Map<int, Video> allVids, Set<String> tags) {
    // for (Video vid in allVids) {}
    List<Tuple2<Video, int>> allVidsList = [];
    allVids.forEach((key, vid) {
      int score = compareTags(vid.tags, tags);
      allVidsList.add(Tuple2(vid, score));
    });
    allVidsList.sort((vid1, vid2) {
      return vid1.item2.compareTo(vid2.item2);
    });
    allVidsList = List.from(allVidsList.reversed);
    List<Video> res = [];
    for (int i = 0; i < allVidsList.length; i++) {
      res.add(allVidsList[i].item1);
    }
    return res;
  }

  static int compareTags(Set<String> tags1, Set<String> tags2) {
    int score = 0;
    tags1.forEach((tag) {
      if (tags2.contains(tag)) {
        score++;
      }
    });
    return score;
  }

  static List<Video> continueWatching(Creator creator) {
    List<Video> res = [];
    creator.watchedVideos.forEach((vidID, time) {
      Video vid = Server.getVideoById(vidID);
      if (time != vid.length) {
        res.add(vid);
      }
    });

    return res;
  }

  static List<Video> watchAgain(Creator creator) {
    List<Video> res = [];
    creator.watchedVideos.forEach((vidID, time) {
      Video vid = Server.getVideoById(vidID);
      if (time == vid.length) {
        res.add(vid);
      }
    });

    return res;
  }
}
