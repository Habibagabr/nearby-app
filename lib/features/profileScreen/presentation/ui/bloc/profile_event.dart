part of 'profile_bloc.dart';


sealed class ProfileEvent {}

class ProfileScreenStarted extends ProfileEvent{}
class LogoutConfirmed extends ProfileEvent{}
class PostLogout extends ProfileEvent{}

class EditProfileClicked extends ProfileEvent{}
class EditProfileCancelled extends ProfileEvent{}

