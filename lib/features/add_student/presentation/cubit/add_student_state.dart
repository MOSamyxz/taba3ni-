part of 'add_student_cubit.dart';

sealed class AddStudentState extends Equatable {
  const AddStudentState();

  @override
  List<Object> get props => [];
}

final class AddStudentInitial extends AddStudentState {}

class AddStudentLoading extends AddStudentState {}
class AddStudentSuccess extends AddStudentState {}
class AddStudentSubmitted extends AddStudentState {
    final StudentsEntity student;
  const AddStudentSubmitted(this.student);
 
}
class AddStudentError extends AddStudentState {
  final String error;

  const AddStudentError(this.error);
  
    @override
  List<Object> get props => [error];
 
}