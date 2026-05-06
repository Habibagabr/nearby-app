part of 'profile_bloc.dart';

class ProfileState {
  final bool isRegister;
  final bool isChecking;
  final bool isLoading;
  final bool isPostLogout;
  final bool isEditProfileClicked;

  const ProfileState({
    this.isRegister = false,
    this.isChecking = true,
    this.isLoading = false,
    this.isPostLogout = false,
    this.isEditProfileClicked=false
  });

  ProfileState copyWith({
    bool? isRegister,
    bool? isChecking,
    bool? isLoading,
    bool? isPostLogout,
    bool? isEditProfileClicked,
  }) {
    return ProfileState(
      isRegister: isRegister ?? this.isRegister,
      isChecking: isChecking ?? this.isChecking,
      isLoading: isLoading ?? this.isLoading,
      isPostLogout: isPostLogout ?? this.isPostLogout,
      isEditProfileClicked: isEditProfileClicked ?? this.isEditProfileClicked
    );
  }
}