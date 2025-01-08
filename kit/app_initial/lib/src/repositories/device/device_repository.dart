import 'package:app_initial/src/enums/enums.dart';
import 'package:app_initial/src/models/models.dart';

abstract class DeviceRepository {
  Future<Device> findById({
    required String userId,
    required String id,
  });

  Future<Device> store({
    required String userId,
    required String id,
    required String model,
    required PlatformType platform,
    String? fcmToken,
  });

  Future<Device> update({
    required String userId,
    required String id,
    String? model,
    PlatformType? platform,
    DateTime? lastActivityAt,
    String? fcmToken,
  });
}

class DeviceNotFound implements Exception {}
