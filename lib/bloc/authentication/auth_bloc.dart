import 'package:bloc/bloc.dart';

import '../../data/repository/authentication_repository.dart';
import '../../di/di.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locator.get();
  AuthBloc() : super(AuthInitiateState()) {
    on<AuthLoginRequestEvent>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.login(event.username, event.password);
      emit(AuthResponseState(response));
    });
  }
}
