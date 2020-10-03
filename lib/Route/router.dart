import 'package:auto_route/auto_route_annotations.dart';

import 'package:wisata/ui/SplassScreen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplassScreen, initial: true),
  ],
)
class $Router {}
