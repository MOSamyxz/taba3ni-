
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> json, UserRole role) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      role: role,
    );
  }
}
