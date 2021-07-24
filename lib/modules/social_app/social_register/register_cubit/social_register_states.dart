abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates {
}

class SocialRegisterCreateSuccessState extends SocialRegisterStates {
  final String uId;

  SocialRegisterCreateSuccessState(this.uId);
}

class SocialRegisterCreateErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterCreateErrorState(this.error);
}
