import 'package:flutter/widgets.dart';

import 'flavor_config.dart';
import 'main_common.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppFlavor.setupEnv(Env.dev);
  mainCommon();
}
