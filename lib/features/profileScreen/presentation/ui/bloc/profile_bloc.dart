import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/network/sessionManager/session_manager_interface.dart';

part 'profile_event.dart';

part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SessionManager sessionManager;

  ProfileBloc({required this.sessionManager})
      : super(const ProfileState()) {
    on<ProfileScreenStarted>(_onProfileScreenStarted);
    on<LogoutConfirmed>(_onLogoutConfirmed);
  }

  Future<void> _onProfileScreenStarted(
      ProfileScreenStarted event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(isChecking: true));

    final userId = await sessionManager.getUserId();

    emit(state.copyWith(
      isChecking: false,
      isRegister: userId != null,
    ));
  }

  Future<void> _onLogoutConfirmed(
      LogoutConfirmed event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    await sessionManager.clearSession();

    emit(state.copyWith(
      isLoading: false,
      isRegister: false,
      isPostLogout: true,
    ));
  }
}