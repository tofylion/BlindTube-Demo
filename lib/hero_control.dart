import 'package:blindtube/structure/video.dart';
import 'package:flutter/material.dart';

class HeroControl {
  static int _globalHeroIndex = 0;

  static int generateHeroIndex() {
    return _globalHeroIndex++;
  }

  static Future<Widget> buildPageAsync(Widget page) async {
    return Future.microtask(() {
      return page;
    });
  }
}
