import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.wasRead,
    required this.updatedAt,
    required this.createdAt,
  });

  Notification.empty({
    this.id = '',
    this.title = '',
    this.body = '',
    this.wasRead = false,
    DateTime? updatedAt,
    DateTime? createdAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  final String id;
  final String title;
  final String body;
  final bool wasRead;
  final DateTime updatedAt;
  final DateTime createdAt;

  Notification copyWith({
    String? id,
    String? title,
    String? body,
    bool? wasRead,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      wasRead: wasRead ?? this.wasRead,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        wasRead,
        updatedAt,
        createdAt,
      ];
}
