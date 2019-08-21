import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/repository/api.dart';
import 'package:snacks_app/src/repository/modelClasses/orderModel.dart';
import 'package:snacks_app/src/sessionManager/sessionManager.dart';

class MyOrderBloc extends BlocBase {
  final _radioBtnOrderValue = BehaviorSubject<String>();

  Stream<String> get radioBtnOrderValue => _radioBtnOrderValue.stream;

  Function(String) get changeMyOrder => _radioBtnOrderValue.sink.add;

  @override
  void dispose() {
    _radioBtnOrderValue.close();
  }

  void sendOrder() async {
    var userName = await sessionManager.userName;
    var userID = await sessionManager.userID;

    OrderModel orderModel = await api.sendOrder(userID, userName, _radioBtnOrderValue.value, userID);
    var messageType = orderModel.messageType.toString();
    print("HEYYYYYYYYYYYYYYYYYYY $messageType");

  }

  Future<String> viewPresentOrder() async {
    var userID = await sessionManager.userID;
    OrderModel orderModel = await api.getPresentOrder(userID);
    return orderModel.messageType.toString();
  }
}
