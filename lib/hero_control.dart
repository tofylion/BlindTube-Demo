class HeroControl {
  static int _globalHeroIndex = 0;

  static int generateHeroIndex() {
    return _globalHeroIndex++;
  }
}
