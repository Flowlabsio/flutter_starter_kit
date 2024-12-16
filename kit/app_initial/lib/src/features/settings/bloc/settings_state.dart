import 'package:app_initial/src/enums/enums.dart';
import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.isDeletingAccount,
    required this.isFetchingProviders,
    required this.userProviders,
  });

  const SettingsState.initial({
    this.isDeletingAccount = false,
    this.isFetchingProviders = false,
    this.userProviders = const [],
  });

  final bool isDeletingAccount;
  final bool isFetchingProviders;
  final List<AuthProvider> userProviders;

  SettingsState copyWith({
    bool? isDeletingAccount,
    bool? isFetchingProviders,
    List<AuthProvider>? userProviders,
  }) {
    return SettingsState(
      isDeletingAccount: isDeletingAccount ?? this.isDeletingAccount,
      isFetchingProviders: isFetchingProviders ?? this.isFetchingProviders,
      userProviders: userProviders ?? this.userProviders,
    );
  }

  @override
  List<Object> get props => [
        isDeletingAccount,
        isFetchingProviders,
        userProviders,
      ];
}
