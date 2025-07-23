
part of 'group_cubit.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object?> get props => [];
}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final List<GroupEntity> groups;

  const GroupLoaded(this.groups);

  @override
  List<Object?> get props => [groups];
}

class GroupError extends GroupState {
  final String error;

  const GroupError(this.error);

  @override
  List<Object?> get props => [error];
}
