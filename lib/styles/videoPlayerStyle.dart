import 'package:blindtube/styles/palette.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

const videoControlsHide = const Duration(seconds: 4);
ChewieProgressColors videoPlayerTheme = ChewieProgressColors(
  playedColor: secondaryColor.withAlpha(200),
  handleColor: secondaryColor,
  bufferedColor: secondaryColor.withAlpha(100),
  backgroundColor: backgroundColor.withAlpha(100),
);

const double videoPlayerElevation = 4;
const BorderRadius videoPlayerBorderRadius = BorderRadius.vertical(
  bottom: Radius.circular(10),
);
const Color videoPlayerShadow = darkerBackground;
