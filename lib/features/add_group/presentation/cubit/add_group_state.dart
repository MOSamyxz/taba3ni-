
part of 'add_group_cubit.dart';

abstract class AddGroupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddGroupInitial extends AddGroupState {}

class AddGroupUpdated extends AddGroupState {}

class AddGroupLoading extends AddGroupState {}

class AddGroupSubmitted extends AddGroupState {
  final GroupEntity group;
  AddGroupSubmitted(this.group);

  @override
  List<Object?> get props => [group];
}

class AddGroupError extends AddGroupState {
  final String error;
  AddGroupError(this.error);

  @override
  List<Object?> get props => [error];
}
