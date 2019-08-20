import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/blocs/validators/validators.dart';
import 'package:snacks_app/src/repository/api.dart';
import 'package:snacks_app/src/repository/modelClasses/menuModel.dart';

class MenuBloc extends BlocBase with Validators {
  final _mainMenu = BehaviorSubject<String>();
  final _altMenuOne = BehaviorSubject<String>();
  final _altMenuTwo = BehaviorSubject<String>();
  final _altMenuThree = BehaviorSubject<String>();

  //..................Stream....................//
  Stream<String> get mainMenu => _mainMenu.stream;

  Stream<String> get altMenuOne => _altMenuOne.stream;

  Stream<String> get altMenuTwo => _altMenuTwo.stream;

  Stream<String> get altMenuThree => _altMenuThree.stream;

  //..................Function........................//
  Function(String) get sinkMainMenu => _mainMenu.sink.add;

  Function(String) get sinkAltMenuOne => _altMenuOne.sink.add;

  Function(String) get sinkAltMenuTwo => _altMenuTwo.sink.add;

  Function(String) get sinkAltMenuThree => _altMenuThree.sink.add;

  @override
  void dispose() {
    _mainMenu.close();
    _altMenuOne.close();
    _altMenuTwo.close();
    _altMenuThree.close();
  }

  void showMenu() async {
    MenuModel menuModel = await api.getMenu();
    var splitAltMenu = menuModel.alternateMenu.toString().split("/");
    sinkMainMenu(menuModel.mainMenu);
    sinkAltMenuOne(splitAltMenu[0]);
    sinkAltMenuTwo(splitAltMenu[1]);
    sinkAltMenuThree(splitAltMenu[2]);
  }
}
