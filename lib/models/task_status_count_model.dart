// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskStatusCountModel {
  String? sId;
  int? sum;
  TaskStatusCountModel({
    this.sId,
    this.sum,
  });

  // TaskStatusCountModel({this.sId, this.sum});

  // TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
  //   sId = json['_id'];
  //   sum = json['sum'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['sum'] = this.sum;
  //   return data;
  // }

  TaskStatusCountModel copyWith({
    String? sId,
    int? sum,
  }) {
    return TaskStatusCountModel(
      sId: sId ?? this.sId,
      sum: sum ?? this.sum,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sId': sId,
      'sum': sum,
    };
  }

  factory TaskStatusCountModel.fromMap(Map<String, dynamic> map) {
    return TaskStatusCountModel(
      sId: map['sId'] != null ? map['sId'] as String : null,
      sum: map['sum'] != null ? map['sum'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskStatusCountModel.fromJson(String source) => TaskStatusCountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TaskStatusCountModel(sId: $sId, sum: $sum)';

  @override
  bool operator ==(covariant TaskStatusCountModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.sId == sId &&
      other.sum == sum;
  }

  @override
  int get hashCode => sId.hashCode ^ sum.hashCode;
}
