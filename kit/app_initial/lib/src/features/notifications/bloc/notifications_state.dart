import 'package:app_initial/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class NotificationsState extends Equatable {
  NotificationsState({
    required this.isLoadingNextPage,
    required this.hasNextPage,
    required this.notifications,
    required this.pointerLastDocument,
    required this.isRefreshing,
  });

  NotificationsState.initial({
    this.isLoadingNextPage = false,
    this.hasNextPage = true,
    this.notifications = const [],
    this.pointerLastDocument,
    this.isRefreshing = false,
  });

  final bool isLoadingNextPage;
  final bool hasNextPage;
  final List<Notification> notifications;
  Timestamp? pointerLastDocument;
  final bool isRefreshing;

  NotificationsState copyWith({
    bool? isLoadingNextPage,
    bool? hasNextPage,
    List<Notification>? notifications,
    Timestamp? pointerLastDocument,
    bool? isRefreshing,
  }) {
    return NotificationsState(
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      notifications: notifications ?? this.notifications,
      pointerLastDocument: pointerLastDocument ?? this.pointerLastDocument,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        isLoadingNextPage,
        hasNextPage,
        notifications,
        pointerLastDocument,
        isRefreshing,
      ];
}
