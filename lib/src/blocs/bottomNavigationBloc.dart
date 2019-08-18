import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';

class BottomNavigationBloc extends BlocBase {
  final _pageIndex = BehaviorSubject<int>();
  final _pageNames = BehaviorSubject<List<String>>();

  Stream<int> get pageIndex => _pageIndex.stream;

  Stream<List<String>> get pageNames => _pageNames.stream;

  Function(int) get changedPageIndex => _pageIndex.sink.add;

  Function(List<String>) get changedPageName => _pageNames.sink.add;

  @override
  void dispose() {
    _pageIndex.close();
    _pageNames.close();
  }
//
//  void clearAllData() {
//    _pageIndex.value = 0;
//    _pageNames.value = null;
//  }

  void getPageNames() {
    final List<String> _pageNames = [
      "Welcome",
      "My Order",
      "Order for a Colleague!",
    ];

    changedPageName(_pageNames);
  }
}
