import 'comment.dart';
import 'creator.dart';
import 'defaults.dart';

class Video {
  Video({
    required this.id,
    required this.title,
    required this.videoPath,
    required this.publishDateTime,
    required this.length,
    required this.creator,
    this.picPath = defaultVidPic,
    this.description = '',
    this.views = 0,
    this.likes = 0,
    this.tags = const {},
  });

  int id;
  String title;
  String videoPath;
  DateTime publishDateTime;
  Duration length;
  String picPath;
  String description;
  int views;
  Creator creator;
  int likes;
  Set<String> tags;
  List<Comment> comments = [];

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
    Duration rawVideoLength = length;
    String videoLength = rawVideoLength.toString();
    if (rawVideoLength.inHours == 0) {
      videoLength = videoLength.substring(2);
    }
    videoLength = videoLength.substring(0, videoLength.length - 7);

    return videoLength;
  }

  String getPublishDateAsString() {
    String day = publishDateTime.day.toString();
    String month = _getMonthFromInt(publishDateTime.month);
    String year = publishDateTime.year.toString();

    return month + ' ' + day + ', ' + year;
  }

  String _getMonthFromInt(int month) {
    assert(month >= 1 && month <= 12);
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Dec';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'None';
    }
  }
}
