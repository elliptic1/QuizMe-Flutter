import 'package:flutter_bloc/flutter_bloc.dart';
import 'mic/events.dart';
import '../states.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(NotListening());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is StartListening) {
      yield Listening();
    } else if (event is StopListening) {
      yield NotListening();
    }
  }
}
