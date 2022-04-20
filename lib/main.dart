import 'package:blindtube/pages/home_page.dart';
import 'package:blindtube/pages/landing.dart';
import 'package:blindtube/pages/video_list_page.dart';
import 'package:blindtube/pages/video_page.dart';
import 'package:blindtube/structure/video.dart';
import 'package:blindtube/testing/test_intialisers.dart';
import 'package:flutter/material.dart';
import '/styles/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData.dark();

    return MaterialApp(
      theme: theme.copyWith(
        platform: TargetPlatform.iOS,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: theme.textTheme.copyWith(
          displayMedium: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w300,
            color: whiteTextColor,
          ),
          headlineLarge: theme.textTheme.headlineLarge?.copyWith(
            color: whiteTextColor,
            fontSize: 35,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: navBarColor,
                // offset: Offset(5.0, 5.0),
              ),
              Shadow(
                blurRadius: 1,
                color: mainTextColor,
              )
            ],
          ),
          headlineMedium: theme.textTheme.headlineMedium?.copyWith(
            color: whiteTextColor,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w300,
            color: mainTextColor,
          ),
          titleLarge: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 19,
          ),
          titleMedium: theme.textTheme.titleMedium?.copyWith(
            color: whiteTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w200,
          ),
          titleSmall: theme.textTheme.titleSmall?.copyWith(
            color: fadedTextColor,
          ),
          bodyLarge: theme.textTheme.bodyLarge?.copyWith(
            color: fadedTextColor,
            fontWeight: FontWeight.w300,
            fontSize: 15,
          ),
          bodyMedium: theme.textTheme.bodyMedium?.copyWith(
            color: whiteTextColor,
            fontWeight: FontWeight.w300,
          ),
          bodySmall: theme.textTheme.bodySmall?.copyWith(
            color: fadedTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        cardColor: cardColor,
        colorScheme: theme.colorScheme.copyWith(
          primary: foregroundColor,
          secondary: secondaryColor,
        ),
        dividerColor: fadedTextColor,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{},
    );
  }
}
