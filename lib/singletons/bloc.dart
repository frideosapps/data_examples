import 'package:frideos_core/frideos_core.dart';

class SingletonBloc {
  static final SingletonBloc _singletonBloc = new SingletonBloc._internal();

  final dateTime = StreamedValue<String>();
  final text = StreamedValue<String>();  

  factory SingletonBloc() {
    return _singletonBloc;
  }

  SingletonBloc._internal() {
    text.value = "Lorem ipsum";
  }

  dispose() {
    print('Disposing bloc');
    dateTime.dispose();
    text.dispose();    
  }
}


final bloc = SingletonBloc();

