import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'obscure_form_state.dart';

class ObscureFormCubit extends Cubit<ObscureFormState> {
  ObscureFormCubit() : super(const ObscureFormInitial());

  void onChangingObscure({required bool isPassword}) {
    emit(ObscureFormInitial(isPassword: isPassword));
  }
}
