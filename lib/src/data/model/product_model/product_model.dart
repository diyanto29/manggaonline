import 'package:collection/collection.dart';

import 'data.dart';

class ProductModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  ProductModel({this.status, this.code, this.message, this.data});

  @override
  String toString() {
    return 'ProductModel(status: $status, code: $code, message: $message, data: $data)';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json['status'] as bool?,
        code: json['code'] as int?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'message': message,
        'data': data?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProductModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      status.hashCode ^ code.hashCode ^ message.hashCode ^ data.hashCode;
}
