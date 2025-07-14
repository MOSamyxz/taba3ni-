
enum UserRole { teacher, parent }

class UserEntity {
  final String id;
  final String name;
  final UserRole role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.role,
  });
}
