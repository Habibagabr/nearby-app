part of 'profile_bloc.dart';

class ProfileState {
  final bool isRegister;
  final bool isChecking;
  final bool isLoading;
  final bool isPostLogout;

  const ProfileState({
    this.isRegister = false,
    this.isChecking = true,
    this.isLoading = false,
    this.isPostLogout = false,
  });

  ProfileState copyWith({
    bool? isRegister,
    bool? isChecking,
    bool? isLoading,
    bool? isPostLogout,
  }) {
    return ProfileState(
      isRegister: isRegister ?? this.isRegister,
      isChecking: isChecking ?? this.isChecking,
      isLoading: isLoading ?? this.isLoading,
      isPostLogout: isPostLogout ?? this.isPostLogout,
    );
  }
}