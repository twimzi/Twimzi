import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/app_initializer.dart';

final splashProvider = FutureProvider<void>((ref) async {
  await AppInitializer.initialize();
});