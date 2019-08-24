import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/repository/api.dart';
import 'package:snacks_app/src/repository/modelClasses/orderModel.dart';
import 'package:snacks_app/src/sessionManager/sessionManager.dart';

class MyOrderBloc extends BlocBase {
  final _radioBtnOrderValue = BehaviorSubject<String>();
  var trimmedOrder;

  Stream<String> get radioBtnOrderValue => _radioBtnOrderValue.stream;

  Function(String) get changeMyOrder => _radioBtnOrderValue.sink.add;

  @override
  void dispose() {
    _radioBtnOrderValue.close();
  }

  /*Had to trim the order selected through Radio Button as Radio widget is
   returning value with a leading space when onChanged is being called. BAZINGA */
  void trimLeadingSpace(String str) {
    trimmedOrder = str.replaceFirst(new RegExp(r"^\s+"), "");
  }

  void sendOrder() async {
    var userName = await sessionManager.userName;
    var userID = await sessionManager.userID;

    trimLeadingSpace(_radioBtnOrderValue.value);
    await api.sendOrder(userID, userName, trimmedOrder, userID);
  }

  Future<String> viewPresentOrder() async {
    var userID = await sessionManager.userID;
    OrderModel orderModel = await api.getOrderStatus(userID);
    return orderModel.messageType.toString();
  }
}
