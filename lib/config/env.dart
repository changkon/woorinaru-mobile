import 'package:ansicolor/ansicolor.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:global_configuration/global_configuration.dart';

enum BuildFlavor { production, staging, development }

BuildEnvironment get env => _env;
BuildEnvironment _env;

class BuildEnvironment {
  final BuildFlavor flavor;
  final Map<String, dynamic> config;

  BuildEnvironment._init({this.flavor, this.config});

  static void init({@required BuildFlavor flavor, @required Map<String, dynamic> config}) {
    _env ??= BuildEnvironment._init(flavor: flavor, config: config);
  }

  static void _initLogger(Level level) {
    AnsiPen errorPen = new AnsiPen()..red(bold: true);
    AnsiPen warningPen = new AnsiPen()..yellow(bold: true);
    AnsiPen infoPen = new AnsiPen()..green(bold: true);
    AnsiPen finePen = new AnsiPen()..blue(bold: true);

    Logger.root.level = level;
    Logger.root.onRecord.listen((record) {
      AnsiPen pen;

      switch (record.level.name) {
        case "INFO":
          pen = infoPen;
          break;
        case "WARNING":
          pen = warningPen;
          break;
        case "ERROR":
          pen = errorPen;
          break;
        case "FINE":
          pen = finePen;
          break;
        default:
          pen = infoPen;
      }

      print(pen('${record.level.name}: ${record.time}: ${record.message}'));
    });
  }

  static Future<BuildEnvironment> initDev() async {
    await GlobalConfiguration().loadFromPath("assets/config/config.dev.json");
    Map<String, dynamic> config = GlobalConfiguration().appConfig;
    init(flavor: BuildFlavor.development, config: config);
    _initLogger(Level.ALL);
    return _env;
  }

  static Future<BuildEnvironment> initEmulator() async {
    await GlobalConfiguration().loadFromPath("assets/config/config.dev.emulator.json");
    Map<String, dynamic> config = GlobalConfiguration().appConfig;
    init(flavor: BuildFlavor.development, config: config);
    _initLogger(Level.ALL);
    return _env;
  }
}
