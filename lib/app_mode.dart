enum AppMode {
  DEBUG,
  RELEASE
}

class App {
  AppMode mode;

  App({required this.mode});

  bool get isReleaseMode => mode == AppMode.RELEASE;
}