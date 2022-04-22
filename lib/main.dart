import 'package:blindtube/engines/videoRecommender.dart';
import 'package:blindtube/pages/home_page.dart';
import 'package:blindtube/structure/server.dart';
import 'package:blindtube/structure/video.dart';

import 'package:blindtube/testing/database.dart';
import 'package:flutter/material.dart';
import '/styles/palette.dart';

void main() {
  Paint.enableDithering = true;
  runApp(const MyApp());
}

bool databaseBuilt = false;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!databaseBuilt) {
      Database.populateDatabase();
      databaseBuilt = true;
    }
    ThemeData theme = ThemeData.dark();

    return MaterialApp(
      theme: theme.copyWith(
        platform: TargetPlatform.iOS,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: theme.textTheme.copyWith(
          displayMedium: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w300,
            color: whiteTextColor,
            fontFamily: 'Hind',
          ),
          displaySmall: theme.textTheme.displaySmall?.copyWith(
            color: fadedTextColor,
            fontSize: 40,
            fontWeight: FontWeight.w300,
            fontFamily: 'Hind',
          ),
          headlineLarge: theme.textTheme.headlineLarge?.copyWith(
            color: whiteTextColor,
            fontSize: 35,
            fontFamily: 'Hind',
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
            fontFamily: 'Hind',
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w300,
            fontFamily: 'Hind',
            color: mainTextColor,
          ),
          titleLarge: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w300,
            fontFamily: 'Hind',
            fontSize: 19,
          ),
          titleMedium: theme.textTheme.titleMedium?.copyWith(
            color: whiteTextColor,
            fontFamily: 'Hind',
            fontSize: 18,
            fontWeight: FontWeight.w200,
          ),
          titleSmall: theme.textTheme.titleSmall?.copyWith(
            color: fadedTextColor,
            fontFamily: 'Hind',
          ),
          bodyLarge: theme.textTheme.bodyLarge?.copyWith(
            color: fadedTextColor,
            fontFamily: 'Hind',
            fontWeight: FontWeight.w300,
            fontSize: 15,
          ),
          bodyMedium: theme.textTheme.bodyMedium?.copyWith(
            color: whiteTextColor,
            fontFamily: 'Hind',
            fontWeight: FontWeight.w300,
          ),
          bodySmall: theme.textTheme.bodySmall?.copyWith(
            color: fadedTextColor,
            fontSize: 13,
            fontFamily: 'Hind',
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
    );
  }
}
