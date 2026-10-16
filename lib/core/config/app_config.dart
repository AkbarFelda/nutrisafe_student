abstract final class AppConfig {
  static const demoMode = bool.fromEnvironment(
    'DEMO_MODE',
    defaultValue: false,
  );
}
