import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/business_model.dart';
import '../../data/repositories/business_repository.dart';

final businessRepositoryProvider = Provider<BusinessRepository>(
      (ref) => BusinessRepository(),
);

final businessesProvider =
FutureProvider<List<BusinessModel>>((ref) async {
  return ref
      .read(businessRepositoryProvider)
      .getBusinesses();
});

final myBusinessesProvider =
FutureProvider<List<BusinessModel>>((ref) async {
  return ref
      .read(businessRepositoryProvider)
      .getMyBusinesses();
});

final businessProvider =
FutureProvider.family<BusinessModel, String>(
      (ref, id) async {
    return ref
        .read(businessRepositoryProvider)
        .getBusiness(id);
  },
);