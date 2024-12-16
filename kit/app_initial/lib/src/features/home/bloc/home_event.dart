sealed class HomeEvent {}

class UpdateUserName extends HomeEvent {
  UpdateUserName(this.userName);
  final String userName;
}

class HomeListen extends HomeEvent {}
