import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/repository/api.dart';
import 'package:snacks_app/src/repository/modelClasses/orderDetailModel.dart';

class OrderDetailsBloc extends BlocBase {
  final _orderList = BehaviorSubject<OrderDetailsModel>();

  Stream<OrderDetailsModel> get orderList => _orderList.stream;

  Function(OrderDetailsModel) get sinkOrderList => _orderList.sink.add;

  void getOrderList() async {
    OrderDetailsModel orderDetailsModel = await api.getOrderDetails();
    sinkOrderList(orderDetailsModel);
  }

  void deleteOrder(Order order) async {
    api.deleteOrder(order.userid);
  }

  @override
  void dispose() {
    _orderList.close();
  }
}
