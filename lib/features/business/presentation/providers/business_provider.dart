import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/business_model.dart';
import '../../data/repositories/business_repository.dart';

/// Repository
final businessRepositoryProvider = Provider<BusinessRepository>(
      (ref) => BusinessRepository(),
);

/// ---------------------------------------------------------------------------
/// ALL BUSINESSES
/// ---------------------------------------------------------------------------

final businessesProvider =
FutureProvider<List<BusinessModel>>((ref) async {
  return ref.read(businessRepositoryProvider).getBusinesses();
});

/// ---------------------------------------------------------------------------
/// MY BUSINESSES
/// ---------------------------------------------------------------------------

final myBusinessesProvider =
FutureProvider<List<BusinessModel>>((ref) async {
  return ref.read(businessRepositoryProvider).getMyBusinesses();
});

/// ---------------------------------------------------------------------------
/// SINGLE BUSINESS
/// ---------------------------------------------------------------------------

final businessProvider =
FutureProvider.family<BusinessModel, String>(
      (ref, id) async {
    return ref
        .read(businessRepositoryProvider)
        .getBusiness(id);
  },
);

/// ---------------------------------------------------------------------------
/// BUSINESS BY HANDLE
/// ---------------------------------------------------------------------------

final businessByHandleProvider =
FutureProvider.family<BusinessModel?, String>(
      (ref, handle) async {
    return ref
        .read(businessRepositoryProvider)
        .getBusinessByHandle(handle);
  },
);

/// ---------------------------------------------------------------------------
/// HANDLE AVAILABLE
/// ---------------------------------------------------------------------------

final handleAvailableProvider =
FutureProvider.family<bool, String>(
      (ref, handle) async {
    if (handle.trim().isEmpty) {
      return false;
    }

    return !(await ref
        .read(businessRepositoryProvider)
        .handleExists(handle));
  },
);

/// ---------------------------------------------------------------------------
/// SEARCH
/// ---------------------------------------------------------------------------

final businessSearchProvider =
FutureProvider.family<List<BusinessModel>, String>(
      (ref, keyword) async {
    return ref
        .read(businessRepositoryProvider)
        .searchBusinesses(keyword);
  },
);

/// ---------------------------------------------------------------------------
/// TOTAL BUSINESSES
/// ---------------------------------------------------------------------------

final totalBusinessesProvider =
FutureProvider<int>((ref) async {
  return ref
      .read(businessRepositoryProvider)
      .totalBusinesses();
});

/// ---------------------------------------------------------------------------
/// LIVE STREAM
/// ---------------------------------------------------------------------------

final businessStreamProvider =
StreamProvider<List<BusinessModel>>(
      (ref) {
    return ref
        .read(businessRepositoryProvider)
        .watchBusinesses();
  },
);

/// ---------------------------------------------------------------------------
/// MY LIVE STREAM
/// ---------------------------------------------------------------------------

final myBusinessStreamProvider =
StreamProvider<List<BusinessModel>>(
      (ref) {
    return ref
        .read(businessRepositoryProvider)
        .watchMyBusinesses();
  },
);