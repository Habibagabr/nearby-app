import 'package:bloc/bloc.dart';
import 'package:near_buy_gp/features/authenticationScreens/utils/input_field_error.dart';

import '../../utils/common_validations.dart';
part 'signup_screen_event.dart';
part 'signup_screen_state.dart';

class SignupScreenBloc extends Bloc<SignupScreenEvent, SignupScreenState> {
  SignupScreenBloc() : super(SignupScreenInitial()) {
    on<SecondaryBtnClicked>(_onSecondaryBtnClicked);
    on<PrimaryBtnClicked>(_onSignupPressed);
  }

  void _onSecondaryBtnClicked(
    SecondaryBtnClicked event,
    Emitter<SignupScreenState> emit,
  ) {
    emit(NavigateToLoginScreen());
  }

  void _onSignupPressed(
    PrimaryBtnClicked event,
    Emitter<SignupScreenState> emit,
  ) {
    InputFieldError? emailError;
    InputFieldError? userNameError;
    InputFieldError? passwordError;
    InputFieldError? confirmPasswordError;

    if (event.userName.trim().isEmpty) {
      userNameError = InputFieldError.required;
    }

    // Email validation
    if (event.email.trim().isEmpty) {
      emailError = InputFieldError.required;
    } else if (!isValidEmailSyntax(event.email)) {
      emailError = InputFieldError.invalidEmail;
    }

    // Password validation
    if (event.password.trim().isEmpty) {
      passwordError = InputFieldError.required;
    } else if (!isStrongPassword(event.password)) {
      passwordError = InputFieldError.passwordsIsWeak;
    }

    // Password validation
    if (event.confirmPassword.trim().isEmpty) {
      confirmPasswordError = InputFieldError.required;
    } else if (!isStrongPassword(event.confirmPassword)) {
      confirmPasswordError = InputFieldError.passwordsIsWeak;
    } else if (event.confirmPassword != event.confirmPassword) {
      confirmPasswordError = InputFieldError.passwordsNotMatched;
    }

    //local validation failed
    if(emailError != null || passwordError !=null || confirmPasswordError !=null || userNameError!=null){
      emit(SignupValidationError(
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
        userNameError: userNameError
      ));
    }
  }
}
