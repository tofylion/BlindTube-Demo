import 'comment.dart';
import 'creator.dart';
import 'defaults.dart';

class Video {
  Video({
    required this.id,
    required this.videoPath,
    required this.publishDateTime,
    required this.length,
    required this.creator,
    required this.title,
    this.picPath = defaultVidPic,
    this.description = '',
    this.views = 0,
    this.likes = 0,
    this.tags = const {},
  });

  int id;
  String videoPath;
  String picPath;
  String title;
  String description;
  DateTime publishDateTime;
  int views;
  DateTime length;
  Creator creator;
  List<Comment> comments = [];
  int likes;
  Set<String> tags;

  Comment addComment({
    required String content,
    required Creator commenter,
    required DateTime postDate,
  }) {
    Comment comment = Comment(
      content: content,
      commenter: commenter,
      postDate: postDate,
    );
    comments.add(comment);
    return comment;
  }

  bool deleteComment(Comment comment) {
    return comments.remove(comment);
  }

  String getViewsAsString() {
    int videoViewsInt = views;
    String videoViews = '';
    if (videoViewsInt >= 1000000000) {
      videoViews = (videoViewsInt / 1000000000.0).toStringAsFixed(1) + 'B';
    } else if (videoViewsInt >= 1000000) {
      videoViews = (videoViewsInt / 1000000.0).toStringAsFixed(1) + 'M';
    } else if (videoViewsInt >= 1000) {
      videoViews = (videoViewsInt / 1000.0).toStringAsFixed(1) + 'K';
    } else {
      videoViews = videoViewsInt.toString();
    }
    return videoViews;
  }

  String getTagsAsCollapsedString() {
    Set<String> allTags = tags;
    String tagString = '#' +
        allTags.elementAt(0) +
        ' (' +
        (allTags.length - 1).toString() +
        ')';
    return tagString;
  }

  String getLengthAsString() {
    DateTime rawVideoLength = length;
    String videoLength = '';
    if (rawVideoLength.hour != 0) {
      videoLength += rawVideoLength.hour.toString() + ':';
    }
    if (rawVideoLength.minute < 10) {
      videoLength += '0';
    }
    videoLength += rawVideoLength.minute.toStringAsFixed(0) + ':';
    if (rawVideoLength.second < 10) {
      videoLength += '0';
    }
    videoLength += rawVideoLength.second.toStringAsFixed(0);
    return videoLength;
  }
}
