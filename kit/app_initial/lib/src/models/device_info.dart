import 'package:app_initial/src/enums/enums.dart';
import 'package:equatable/equatable.dart';

class DeviceInfo extends Equatable {
  const DeviceInfo({
    required this.id,
    required this.model,
    required this.platform,
  });

  const DeviceInfo.empty({
    this.id = '',
    this.model = '',
    this.platform = PlatformType.unknown,
  });

  final String id;
  final String model;
  final PlatformType platform;

  DeviceInfo copyWith({
    String? id,
    String? model,
    PlatformType? platform,
  }) {
    return DeviceInfo(
      id: id ?? this.id,
      model: model ?? this.model,
      platform: platform ?? this.platform,
    );
  }

  @override
  List<Object?> get props => [
        id,
        model,
        platform,
      ];
}
