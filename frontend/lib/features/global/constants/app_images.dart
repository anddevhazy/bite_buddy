// Paths to the illustrations in assets/images/. Originals at full size are in
// design/ai_art/ at the repo root.
class AppImages {
  static const String splashBackground = 'assets/images/splash_bg.jpg';
  static const String appBackground = 'assets/images/app_bg.jpg';
  static const String arenaBackground = 'assets/images/arena_bg.jpg';
  static const String logo = 'assets/images/logo.png';

  // One image per species key from the server's catalog
  static String pet(String speciesKey) => 'assets/images/pet_$speciesKey.png';

  // Animation sheets made from Google Flow clips (design/tools/
  // flow_to_sprites.py). Characters without them use their still picture.
  static String animations(String characterKey) =>
      'assets/images/anim/$characterKey.json';

  // One image per opponent key from the server's catalog
  static String opponent(String opponentKey) =>
      'assets/images/opp_$opponentKey.png';
}
