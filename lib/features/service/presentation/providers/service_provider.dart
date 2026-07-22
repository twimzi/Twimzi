import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/storage_service.dart';
import '../../data/repositories/service_repository.dart';

final serviceRepositoryProvider =
Provider<ServiceRepository>((ref) {
  return ServiceRepository(
    client: Supabase.instance.client,
    storageRepository: StorageService(),
  );
});