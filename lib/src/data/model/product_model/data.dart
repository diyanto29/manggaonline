import 'package:collection/collection.dart';

import 'produk.dart';

class Data {
  List<List<Produk>>? produk;

  Data({this.produk});

  @override
  String toString() => 'Data(produk: $produk)';

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        produk: (json['produk'] as List<dynamic>?)
            ?.map((e) => (e as List<dynamic>)
                .map((e) => Produk.fromJson(e as Map<String, dynamic>))
                .toList())
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'produk':
            produk?.map((e) => e.map((e) => e.toJson()).toList()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => produk.hashCode;
}
