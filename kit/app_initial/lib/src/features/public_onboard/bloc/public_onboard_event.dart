sealed class PublicOnboardEvent {}

class PublicOnboardListeners extends PublicOnboardEvent {}

class UpdatePublicOnboardIndex extends PublicOnboardEvent {
  UpdatePublicOnboardIndex(this.index);

  final int index;
}

class FinishPublicOnboard extends PublicOnboardEvent {}
