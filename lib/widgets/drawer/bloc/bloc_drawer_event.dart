part of 'bloc_drawer.dart';

/// {@template BlocDrawerEvent}
/// Define los eventos que pueden ocurrir en el drawer.
///
/// Defines the events that can occur in the drawer.
/// {@endtemplate}
abstract class BlocDrawerEvent extends Equatable {
  /// {@macro BlocDrawerEvent}
  const BlocDrawerEvent();

  @override
  List<Object> get props => [];
}

/// {@template BlocDrawerEventSignOut}
/// Cierra sesión.
///
/// Sign out.
/// {@endtemplate}
class BlocDrawerEventSignOut extends BlocDrawerEvent {
  /// {@macro BlocDrawerEventSignOut}
  const BlocDrawerEventSignOut();
}
