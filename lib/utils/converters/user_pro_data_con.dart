import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/data.dart';

class UserProviderDataConverter
    implements JsonConverter<UserProviderData, dynamic> {
  const UserProviderDataConverter();
  @override
  UserProviderData fromJson(dynamic data) {
    if (data == null) {
      return const UserProviderData();
    }
    final json = data as Map<String, dynamic>;
    return UserProviderData.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(UserProviderData userProviderdata) {
    return userProviderdata.toJson();
  }
}
