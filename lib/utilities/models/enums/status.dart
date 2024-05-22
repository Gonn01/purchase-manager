/// {@template Status}
/// Maneja los diferentes estados
///
/// Manage the different states
/// {@endtemplate}
enum Status {
  /// Estado de carga
  ///
  /// Loading state
  loading,

  /// Estado inicial
  ///
  /// Initial state
  initial,

  /// Estado de exito
  ///
  /// Success state
  success,

  /// Estado de error
  ///
  /// Error state
  error;

  /// Devuelve si el estado es [Status.initial]
  ///
  /// Returns if the state is [Status.initial]
  bool get isInitial => this == Status.initial;

  /// Devuelve si el estado es [Status.loading]
  ///
  /// Returns if the state is [Status.loading]
  bool get isLoading => this == Status.loading;

  /// Devuelve si el estado es [Status.success]
  ///
  /// Returns if the state is [Status.success]
  bool get isSuccess => this == Status.success;

  /// Devuelve si el estado es [Status.error]
  ///
  /// Returns if the state is [Status.error]
  bool get isError => this == Status.error;
}
