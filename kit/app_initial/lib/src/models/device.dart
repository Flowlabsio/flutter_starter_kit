import 'package:app_initial/src/enums/enums.dart';
import 'package:equatable/equatable.dart';

class Device extends Equatable {
  const Device({
    required this.id,
    required this.model,
    required this.platform,
    required this.fcmToken,
    required this.lastActivityAt,
    required this.updatedAt,
    required this.createdAt,
  });

  Device.empty({
    this.id = '',
    this.model = '',
    this.platform = PlatformType.unknown,
    this.fcmToken,
    DateTime? lastActivityAt,
    DateTime? updatedAt,
    DateTime? createdAt,
  })  : lastActivityAt = lastActivityAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  final String id;
  final String model;
  final PlatformType platform;
  final String? fcmToken;
  final DateTime lastActivityAt;
  final DateTime updatedAt;
  final DateTime createdAt;

  Device copyWith({
    String? id,
    String? model,
    PlatformType? platform,
    String? fcmToken,
    DateTime? lastActivityAt,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Device(
      id: id ?? this.id,
      model: model ?? this.model,
      platform: platform ?? this.platform,
      fcmToken: fcmToken ?? this.fcmToken,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        model,
        platform,
        fcmToken,
        lastActivityAt,
        updatedAt,
        createdAt,
      ];
}
