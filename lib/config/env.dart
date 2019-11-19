import 'package:meta/meta.dart';

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

  static BuildEnvironment initDev() {
    String appUrl = 'localhost:8080/woorinaru/api/';
    init(flavor: BuildFlavor.development, baseUrl: appUrl);
    return _env;
  }
}
