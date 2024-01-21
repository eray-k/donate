import '../model/position.dart';
import '../model/user.dart';

abstract class AuthRepository {
  User? currentUser;
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> register(User user, String password);
  Future<void> forgotPassword(String email);
  Future<void> updateLocation(Position newPosition);
}
