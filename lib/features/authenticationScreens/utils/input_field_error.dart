enum InputFieldError {
  required("emptyFields"),
  invalidEmail("invalidEmail"),
  passwordsNotMatched("unmatchedPassword"),
  passwordsIsWeak("weakPassword");


  final String localizationKey;
  const InputFieldError(this.localizationKey);

}