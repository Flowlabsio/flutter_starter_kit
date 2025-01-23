import 'package:app_initial/src/datasources/notification/notification.dart';
import 'package:app_initial/src/helpers/page_pointer.dart';
import 'package:app_initial/src/mappers/mappers.dart';
import 'package:app_initial/src/models/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationFirebaseDatasource implements NotificationDatasource {
  @override
  Future<void> deleteAllNotifications({required String userId}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users/$userId/notifications')
        .get();

    if (snapshot.docs.isEmpty) return;

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  @override
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users/$userId/notifications')
        .doc(notificationId)
        .delete();
  }

  @override
  Future<List<Notification>> getNotifications({
    required String userId,
    int limit = 20,
    PagePointer? page,
  }) async {
    var query = FirebaseFirestore.instance
        .collection('users/$userId/notifications')
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (page != null) {
      query = query.startAfter([page.pointer as Timestamp]);
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((e) => NotificationMapper().fromDocumentSnapshot(e))
        .toList();
  }

  @override
  Future<void> markAllAsRead({required String userId}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users/$userId/notifications')
        .where('wasRead', isEqualTo: false)
        .get();

    if (snapshot.docs.isEmpty) return;

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {
        'wasRead': true,
      });
    }

    await batch.commit();
  }

  @override
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) async {
    return FirebaseFirestore.instance
        .collection('users/$userId/notifications')
        .doc(notificationId)
        .update({'wasRead': true});
  }

  @override
  Future<int> unreadNotification({required String userId}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users/$userId/notifications')
        .where('wasRead', isEqualTo: false)
        .count()
        .get();

    if (snapshot.count == null) {
      throw Exception('Error getting unread notification');
    }

    return snapshot.count!;
  }
}
