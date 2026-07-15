import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/storage_repository.dart';
import '../services/storage_service.dart';

final storageRepositoryProvider =
Provider<StorageRepository>(
      (ref) => StorageService(),
);