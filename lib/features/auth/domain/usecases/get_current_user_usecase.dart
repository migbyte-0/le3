import '../entities/auth_entities.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;
  GetCurrentUser(this.repository);

  Stream<Auth?> execute() {
    return repository.currentUser;
  }
}
