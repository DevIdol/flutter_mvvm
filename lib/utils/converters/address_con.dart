import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/data.dart';

class AddressConverters
    implements JsonConverter<Address, Map<String, dynamic>> {
  const AddressConverters();

  @override
  Address fromJson(Map<String, dynamic> json) {
    return Address.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Address address) {
    return address.toJson();
  }
}

class NullableAddressConverters
    implements JsonConverter<Address?, Map<String, dynamic>?> {
  const NullableAddressConverters();

  @override
  Address? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    return Address.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(Address? address) {
    return address?.toJson();
  }
}
