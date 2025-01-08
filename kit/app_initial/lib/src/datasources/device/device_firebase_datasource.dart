import 'package:app_initial/src/datasources/device/device.dart';
import 'package:app_initial/src/enums/enums.dart';
import 'package:app_initial/src/mappers/mappers.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:app_initial/src/repositories/device/device.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceFirebaseDatasource extends DeviceDatasource {
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<Device> findById({
    required String userId,
    required String id,
  }) async {
    final ref = _usersCollection.doc(userId).collection('devices').doc(id);

    final snapshot = await ref.get();

    if (!snapshot.exists) {
      throw DeviceNotFound();
    }

    return DeviceMapper().fromDocumentSnapshot(snapshot);
  }

  @override
  Future<Device> store({
    required String userId,
    required String id,
    required String model,
    required PlatformType platform,
    String? fcmToken,
  }) async {
    final ref = _usersCollection.doc(userId).collection('devices').doc(id);

    await ref.set({
      'id': id,
      'model': model,
      'platform': platform.value,
      'fcmToken': fcmToken,
      'lastActivityAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    final snapshot = await ref.get();

    if (!snapshot.exists) {
      throw Exception('Device not created');
    }

    return DeviceMapper().fromDocumentSnapshot(snapshot);
  }

  @override
  Future<Device> update({
    required String userId,
    required String id,
    String? model,
    PlatformType? platform,
    DateTime? lastActivityAt,
    String? fcmToken,
  }) async {
    final updates = <String, dynamic>{};

    if (model != null) {
      updates['model'] = model;
    }

    if (platform != null) {
      updates['platform'] = platform.value;
    }

    if (fcmToken != null) {
      updates['fcmToken'] = fcmToken;
    }

    if (lastActivityAt != null) {
      updates['lastActivityAt'] = lastActivityAt;
    }

    updates['updatedAt'] = FieldValue.serverTimestamp();

    final ref = _usersCollection.doc(userId).collection('devices').doc(id);

    await ref.update(updates);

    final snapshot = await ref.get();

    if (!snapshot.exists) {
      throw Exception('Device not updated');
    }

    return DeviceMapper().fromDocumentSnapshot(snapshot);
  }
}
