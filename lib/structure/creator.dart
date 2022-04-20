import 'video.dart';
import 'defaults.dart';

class Creator {
  Creator({
    required this.id,
    required this.name,
    this.subscribers = 0,
    this.picPath = defaultCreatorPic,
  });
  final id;
  String name;
  int subscribers;
  Set<Creator> subbedTo = {};
  String picPath;

  List<Video> uploads = [];

  Set<Video> likedVideos = {};

  ///Watched videos for each creator
  ///modeled as a map as follows: Video Id, time of video watched.
  ///This would make it so that the creator can resume
  ///a video that they watched before if they'd like to
  Map<int, DateTime> watchedVideos = {};

  int uploadVid({
    required Video vid,
  }) {
    uploads.add(vid);
    return vid.id;
  }

  void subscribeTo(Creator creator) {
    subbedTo.add(creator);
    creator.subscribers++;
  }

  void unSubFrom(Creator creator) {
    subbedTo.remove(creator);
    creator.subscribers--;
  }

  String getSubsAsString() {
    int creatorSubsInt = subscribers;
    String creatorSubs = '';
    if (creatorSubsInt >= 1000000000) {
      creatorSubs = (creatorSubsInt / 1000000000.0).toStringAsFixed(1) + 'B';
    } else if (creatorSubsInt >= 1000000) {
      creatorSubs = (creatorSubsInt / 1000000.0).toStringAsFixed(1) + 'M';
    } else if (creatorSubsInt >= 1000) {
      creatorSubs = (creatorSubsInt / 1000.0).toStringAsFixed(1) + 'K';
    } else {
      creatorSubs = creatorSubsInt.toString();
    }

    return creatorSubs;
  }
}
