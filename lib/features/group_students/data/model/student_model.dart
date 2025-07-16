import 'package:taba3ni/features/group_students/domain/entity/student_entity.dart';

class StudentsModel extends StudentsEntity {
  StudentsModel({
    required super.id,
    required super.name,
     super.phone,
    required super.parentPhone,
    required super.groupId,
  });

  factory StudentsModel.fromMap(Map<String, dynamic> map) {
    return StudentsModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone']?? '',
      parentPhone: map['parentPhone'] , 
      groupId: map['groupId'] ?? '',  
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'groupId': groupId,
    };
  }
}