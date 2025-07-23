
part of 'add_group_cubit.dart';

abstract class AddGroupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddGroupInitial extends AddGroupState {}

class AddGroupUpdated extends AddGroupState {}

class AddGroupLoading extends AddGroupState {}

class GroupSubmitted extends AddGroupState {
  final GroupEntity group;
  GroupSubmitted(this.group);

  @override
  List<Object?> get props => [group];
}

class AddGroupError extends AddGroupState {
  final String error;
  AddGroupError(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateGroupLoading extends AddGroupState {}

class UpdateGroupError extends AddGroupState {
  final String error;
  UpdateGroupError(this.error);

  @override
  List<Object?> get props => [error];
}
