import 'creator.dart';

class Comment {
  Comment({
    required this.content,
    required this.postDate,
    required this.commenter,
  });

  String content;
  DateTime postDate;
  Creator commenter;

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

  String getPostDateAsString() {
    String day = postDate.day.toString();
    String month = _getMonthFromInt(postDate.month);
    String year = postDate.year.toString();

    return month + ' ' + day + ', ' + year;
  }
}
