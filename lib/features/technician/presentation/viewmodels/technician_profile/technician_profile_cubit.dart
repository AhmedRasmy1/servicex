import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'technician_profile_state.dart';

class TechnicianProfileCubit extends Cubit<TechnicianProfileState> {
  TechnicianProfileCubit() : super(TechnicianProfileInitial());
}
