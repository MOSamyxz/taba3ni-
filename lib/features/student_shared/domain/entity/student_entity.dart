class StudentsEntity {
  final String id;
  final String name;
  final String username;
  final String? phone;
  final String parentPhone;
  final String groupId;

  StudentsEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.parentPhone,
    required this.groupId,
  });
}
