part of 'obscure_form_cubit.dart';

abstract class ObscureFormState extends Equatable {
  const ObscureFormState();

  @override
  List<Object> get props => [];
}

class ObscureFormInitial extends ObscureFormState {
  final bool isPassword;

  const ObscureFormInitial({this.isPassword = false});

  @override
  List<Object> get props => [isPassword];
}
