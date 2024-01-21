/// Maneja los diferentes estados
enum Status {
  loading,
  initial,
  success,
  error;

  /// Devuelve si el estado es [Status.initial]
  bool get isInitial => this == Status.initial;

  /// Devuelve si el estado es [Status.loading]
  bool get isLoading => this == Status.loading;

  /// Devuelve si el estado es [Status.success]
  bool get isSuccess => this == Status.success;

  /// Devuelve si el estado es [Status.error]
  bool get isError => this == Status.error;
}
