import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/blocs/validators/validators.dart';
import 'package:snacks_app/src/repository/api.dart';
import 'package:snacks_app/src/repository/modelClasses/menuModel.dart';

class MenuBloc extends BlocBase with Validators {
  final _menu = BehaviorSubject<MenuModel>();

  Stream<MenuModel> get menu => _menu.stream.transform(validateMenu);

  Function(MenuModel) get changeMenu => _menu.sink.add;

  @override
  void dispose() {
    _menu.close();
  }

  void showMenu() async {
    print("aaaaaaa");
    api.getMenu().then((onValue) {
      changeMenu(onValue);
    });
  }
}
