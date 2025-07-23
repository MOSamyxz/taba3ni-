part of 'group_details_cubit.dart';

abstract class GroupDetailsState extends Equatable {
  const GroupDetailsState();
  @override
  List<Object?> get props => [];
}

class GroupDetailsInitial extends GroupDetailsState {}

class GroupDetailsLoading extends GroupDetailsState {}

class GroupDetailsLoaded extends GroupDetailsState {
  final GroupEntity group;
  const GroupDetailsLoaded(this.group);

  @override
  List<Object?> get props => [group];
}

class GroupDetailsError extends GroupDetailsState {
  final String error;
  const GroupDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}
