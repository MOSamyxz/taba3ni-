import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';

class StudentsModel extends StudentsEntity {
  StudentsModel({
    required super.id,
    required super.name,
    required super.username,
     super.phone,
    required super.parentPhone,
    required super.groupId,
  });

  factory StudentsModel.fromMap(Map<String, dynamic> map) {
    return StudentsModel(
      id: map['id'],
      name: map['name_ar'],
      username: map['username_en'],
      phone: map['phone']?? '',
      parentPhone: map['parent_phone'] , 
      groupId: map['group_id'] ?? '',  
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_ar': name,
      'username_en': username,
      'phone': phone,
      'parent_phone': parentPhone,
      'group_id': groupId,
    };
  }
}