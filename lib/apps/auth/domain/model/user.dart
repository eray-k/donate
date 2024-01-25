import 'package:donate/apps/auth/domain/model/position.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String name,
    required String email,
    required bool isCurrentUser,
    Position? lastPosition, // No record if null
    // TODO: Maybe store as int since accuracy isn't that important,
  }) = _User;
  const User._();
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
