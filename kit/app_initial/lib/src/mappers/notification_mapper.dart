import 'package:app_initial/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationMapper {
  Notification fromDocumentSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return Notification(
      id: snapshot.id,
      title: data['title'] as String,
      body: data['body'] as String,
      wasRead: data['wasRead'] as bool? ?? false,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
