enum HandleStatus {
  initial,
  loading,
  error,
  success;

  bool get isInitial => this == HandleStatus.initial;

  bool get isLoading => this == HandleStatus.loading;

  bool get isError => this == HandleStatus.error;

  bool get isSuccess => this == HandleStatus.success;
}
