import 'package:ansicolor/ansicolor.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

enum BuildFlavor { production, staging, development }

BuildEnvironment get env => _env;
BuildEnvironment _env;

class BuildEnvironment {
  final String baseUrl;
  final BuildFlavor flavor;

  BuildEnvironment._init({this.baseUrl, this.flavor});

  static void init({@required flavor, @required baseUrl}) {
    _env ??= BuildEnvironment._init(flavor: flavor, baseUrl: baseUrl);
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

  static BuildEnvironment initDev() {
    String appUrl = 'http://localhost:8080/woorinaru/api';
    init(flavor: BuildFlavor.development, baseUrl: appUrl);
    _initLogger(Level.ALL);
    return _env;
  }

  static BuildEnvironment initEmulator() {
    String appUrl = 'http://10.0.2.2:8080/woorinaru/api';
    init(flavor: BuildFlavor.development, baseUrl: appUrl);
    _initLogger(Level.ALL);
    return _env;
  }
}
