part of 'register_bloc.dart';

enum LoadingStatus {
  initial,
  loading,
  error,
  done,
}

class PersonalRegisterState extends Equatable {
  final String? fullNameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final LoadingStatus? loadingStatus;

  const PersonalRegisterState({
    this.loadingStatus = LoadingStatus.initial,
    this.fullNameError,
    this.emailError,
    this.confirmPasswordError,
    this.passwordError,
  });

  @override
  List<Object?> get props => [
        fullNameError,
        emailError,
        passwordError,
        confirmPasswordError,
        loadingStatus,
      ];

  PersonalRegisterState copyWith({
    String? fullNameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    LoadingStatus? loadingStatus,
  }) {
    return PersonalRegisterState(
      fullNameError: fullNameError ?? this.fullNameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}

class OrganizationRegisterState extends Equatable {
  final String? organizationNameError;
  final String? organizationCEOError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  
  final LoadingStatus? loadingStatus;

  const OrganizationRegisterState({
    this.loadingStatus = LoadingStatus.initial,
    this.organizationNameError,
    this.organizationCEOError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  @override
  List<Object?> get props => [
        organizationNameError,
        organizationCEOError,
        emailError,
        passwordError,
        confirmPasswordError,
        loadingStatus,
      ];

  OrganizationRegisterState copyWith({
    String? organizationNameError,
    String? organizationCEOError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    LoadingStatus? loadingStatus,
  }) {
    return OrganizationRegisterState(
      organizationNameError:
          organizationNameError ?? this.organizationNameError,
      organizationCEOError: organizationCEOError ?? this.organizationCEOError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
