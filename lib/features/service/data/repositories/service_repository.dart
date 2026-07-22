import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/storage_repository.dart';
import '../models/create_service_request.dart';
import '../models/service.dart';

class ServiceRepository {
ServiceRepository({
SupabaseClient? client,
required StorageRepository storageRepository,
})  : _client = client ?? Supabase.instance.client,
_storage = storageRepository;

final SupabaseClient _client;
final StorageRepository _storage;

Future<List<ServiceModel>> getServices() async {
final response = await _client
.from('services')
.select()
.isFilter('deleted_at', null)
.order(
'service_name',
ascending: true,
);

return (response as List)
.map(
(e) => ServiceModel.fromJson(
e as Map<String, dynamic>,
),
)
.toList();
}

Future<List<ServiceModel>> getBusinessServices(
String businessId,
) async {
final response = await _client
.from('services')
.select()
.eq(
'business_id',
businessId,
)
.isFilter(
'deleted_at',
null,
)
.order(
'service_name',
ascending: true,
);

return (response as List)
.map(
(e) => ServiceModel.fromJson(
e as Map<String, dynamic>,
),
)
.toList();
}

Future<ServiceModel> getService(
String id,
) async {
final response = await _client
.from('services')
.select()
.eq(
'id',
id,
)
.single();

return ServiceModel.fromJson(response);
}

Future<String> createService(
CreateServiceRequest request,
) async {
final slug = request.serviceName
.trim()
.toLowerCase()
.replaceAll(
RegExp(r'[^a-z0-9]+'),
'-',
)
.replaceAll(
RegExp(r'-+'),
'-',
)
.replaceAll(
RegExp(r'^-|-$'),
'',
);

final inserted = await _client
.from('services')
.insert({
'business_id': request.businessId,
'category_id': request.categoryId,
'service_code': request.serviceCode,
'service_name': request.serviceName,
'slug': slug,
'short_description': request.shortDescription,
'description': request.description,
'duration_minutes': request.durationMinutes,
'starting_price': request.price,
'is_featured': request.isFeatured,
'is_active': request.isActive,
})
.select('id')
.single();

final serviceId = inserted['id'] as String;

final folder = _storage.getServiceFolder(
businessId: request.businessId,
serviceId: serviceId,
);

String? thumbnailMediaId;

if (request.hasThumbnail) {
thumbnailMediaId = await _uploadMedia(
file: request.thumbnail!,
folder: folder,
fileName: 'thumbnail',
isThumbnail: true,
serviceId: serviceId,
);
}

if (request.hasGalleryImages) {
for (var i = 0; i < request.galleryImages.length; i++) {
await _uploadMedia(
file: request.galleryImages[i],
folder: '$folder/gallery',
fileName: 'gallery_$i',
isThumbnail: false,
serviceId: serviceId,
displayOrder: i,
);
}
}

if (thumbnailMediaId != null) {
await _client
.from('services')
.update({
'thumbnail_media_id': thumbnailMediaId,
})
.eq(
'id',
serviceId,
);
}

await _client.from('service_pricing').insert({
'service_id': serviceId,
'pricing_type': request.pricingType,
'amount': request.price,
'visit_charge': 0,
'emergency_charge': 0,
'is_active': true,
});

return serviceId;
}

Future<String> _uploadMedia({
required File file,
required String folder,
required String fileName,
required bool isThumbnail,
required String serviceId,
int displayOrder = 0,
}) async {
final publicUrl = await _storage.uploadImage(
file: file,
folder: folder,
fileName: fileName,
);

final uri = Uri.parse(publicUrl);

final bucketIndex = uri.pathSegments.indexOf('product-images');

final objectPath = uri.pathSegments
.skip(bucketIndex + 1)
.join('/');

final media = await _client
.from('media')
.insert({
'uploaded_by': _client.auth.currentUser?.id,
'bucket_name': 'product-images',
'object_path': objectPath,
'file_name': path.basename(objectPath),
'original_name': path.basename(file.path),
'mime_type': _mimeType(file.path),
'extension': path.extension(file.path).replaceFirst('.', ''),
'file_size': await file.length(),
'is_public': true,
})
.select('id')
.single();

final mediaId = media['id'] as String;

await _client.from('service_images').insert({
'service_id': serviceId,
'media_id': mediaId,
'display_order': displayOrder,
'is_thumbnail': isThumbnail,
});

return mediaId;
}
Future<void> updateServiceData(
    ServiceModel service,
    ) async {
  await _client
      .from('services')
      .update(
    service.toJson(),
  )
      .eq(
    'id',
    service.id,
  );
}

Future<void> updateService({
  required ServiceModel service,
  required CreateServiceRequest request,
}) async {
  final slug = request.serviceName
      .trim()
      .toLowerCase()
      .replaceAll(
    RegExp(r'[^a-z0-9]+'),
    '-',
  )
      .replaceAll(
    RegExp(r'-+'),
    '-',
  )
      .replaceAll(
    RegExp(r'^-|-$'),
    '',
  );

  await _client
      .from('services')
      .update({
    'category_id': request.categoryId,
    'service_code': request.serviceCode,
    'service_name': request.serviceName,
    'slug': slug,
    'short_description': request.shortDescription,
    'description': request.description,
    'duration_minutes': request.durationMinutes,
    'starting_price': request.price,
    'is_featured': request.isFeatured,
    'is_active': request.isActive,
  })
      .eq(
    'id',
    service.id,
  );

  await _client
      .from('service_pricing')
      .update({
    'pricing_type': request.pricingType,
    'amount': request.price,
    'is_active': true,
  })
      .eq(
    'service_id',
    service.id,
  );
}

Future<void> deleteService(
    String id,
    ) async {
  await _client
      .from('services')
      .update({
    'deleted_at': DateTime.now().toIso8601String(),
    'is_active': false,
  })
      .eq(
    'id',
    id,
  );

  await _client
      .from('service_pricing')
      .update({
    'deleted_at': DateTime.now().toIso8601String(),
    'is_active': false,
  })
      .eq(
    'service_id',
    id,
  );
}

Future<bool> serviceExists(
    String id,
    ) async {
  final response = await _client
      .from('services')
      .select('id')
      .eq(
    'id',
    id,
  )
      .maybeSingle();

  return response != null;
}

Future<int> totalServices() async {
  final response = await _client
      .from('services')
      .select('id')
      .isFilter(
    'deleted_at',
    null,
  );

  return (response as List).length;
}

Stream<List<ServiceModel>> watchServices() {
  return _client
      .from('services')
      .stream(
    primaryKey: const ['id'],
  )
      .order(
    'service_name',
  )
      .map(
        (rows) => rows
        .where(
          (row) =>
      row['deleted_at'] == null,
    )
        .map(
          (row) => ServiceModel.fromJson(
        row,
      ),
    )
        .toList(),
  );
}

Stream<List<ServiceModel>> watchBusinessServices(
    String businessId,
    ) {
  return _client
      .from('services')
      .stream(
    primaryKey: const ['id'],
  )
      .eq(
    'business_id',
    businessId,
  )
      .order(
    'service_name',
  )
      .map(
        (rows) => rows
        .where(
          (row) =>
      row['deleted_at'] == null,
    )
        .map(
          (row) => ServiceModel.fromJson(
        row,
      ),
    )
        .toList(),
  );
}

String _mimeType(
    String filePath,
    ) {
  final extension =
  path.extension(filePath).toLowerCase();

  switch (extension) {
    case '.jpg':
    case '.jpeg':
      return 'image/jpeg';

    case '.png':
      return 'image/png';

    case '.webp':
      return 'image/webp';

    default:
      return 'application/octet-stream';
  }
}
}
