sealed class SettingsEvent {}

class SettingsInit extends SettingsEvent {
  SettingsInit();
}

class DeleteAccount extends SettingsEvent {
  DeleteAccount();
}

class SignOutSettings extends SettingsEvent {
  SignOutSettings();
}
