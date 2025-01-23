import 'package:app_initial/src/datasources/device/device.dart';
import 'package:app_initial/src/enums/platform_type.dart';
import 'package:app_initial/src/models/device.dart';
import 'package:app_initial/src/repositories/device/device.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl({required this.deviceDatasource});

  final DeviceDatasource deviceDatasource;

  @override
  Future<Device> findById({
    required String userId,
    required String id,
  }) {
    return deviceDatasource.findById(
      userId: userId,
      id: id,
    );
  }

  @override
  Future<Device> store({
    required String userId,
    required String id,
    required String model,
    required PlatformType platform,
    String? fcmToken,
  }) {
    return deviceDatasource.store(
      userId: userId,
      id: id,
      model: model,
      platform: platform,
      fcmToken: fcmToken,
    );
  }

  @override
  Future<Device> update({
    required String userId,
    required String id,
    String? model,
    PlatformType? platform,
    DateTime? lastActivityAt,
    String? fcmToken,
  }) {
    return deviceDatasource.update(
      userId: userId,
      id: id,
      model: model,
      platform: platform,
      lastActivityAt: lastActivityAt,
      fcmToken: fcmToken,
    );
  }
}
