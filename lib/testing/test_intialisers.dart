import 'package:blindtube/structure/creator.dart';
import 'package:blindtube/structure/server.dart';
import 'package:blindtube/structure/video.dart';

int appleId = Server.addCreator(
  name: 'Apple',
  picPath: 'assets/images/apple.jpg',
  subscribers: 15600000,
);
Creator appleCreator = Server.getCreatorById(appleId);
Video appleAtWorkHome = Video(
  id: 1,
  videoPath: 'assets/videos/apple-at-work.mp4',
  publishDateTime: DateTime(2019, 4, 3),
  length: DateTime.parse('1970-01-01 00:03:00'),
  creator: appleCreator,
  title: 'Apple at Work — The Underdogs',
  picPath: 'assets/images/apple at work.jpg',
  description:
      'Four colleagues. Two days. One chance.\n\nLearn how Apple products help employees do their best work at https://apple.com/business\n\nSong: “Nature Fights Back” by Hauschka https://apple.co/2TTLqdi',
  views: 9421318,
  likes: 172000,
  tags: {'Culture', 'Apple', 'Work', 'Short'},
);
