import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/repository/api.dart';
import 'package:snacks_app/src/repository/modelClasses/orderDetailModel.dart';

class BottomNavigationBloc extends BlocBase {
  final _pageIndex = BehaviorSubject<int>();
  final _pageNames = BehaviorSubject<List<String>>();
  final _appbarFlag = BehaviorSubject<bool>();
  final _orderList = BehaviorSubject<OrderDetailsModel>();
  final _orderHashMap = BehaviorSubject<Map<String, int>>();
  final _totalOrder = BehaviorSubject<int>();

  Stream<int> get pageIndex => _pageIndex.stream;

  Stream<List<String>> get pageNames => _pageNames.stream;

  Stream<bool> get appbarFlag => _appbarFlag.stream;

  Stream<OrderDetailsModel> get orderList => _orderList.stream;

  Stream<Map<String, int>> get orderHashMap => _orderHashMap.stream;

  Stream<int> get totalOrder => _totalOrder.stream;

  Function(int) get changePageIndex => _pageIndex.sink.add;

  Function(List<String>) get changePageName => _pageNames.sink.add;

  Function(bool) get sinkAppbarFlag => _appbarFlag.sink.add;

  Function(OrderDetailsModel) get sinkOrderList => _orderList.sink.add;

  Function(Map<String, int>) get sinkOrderHashMap => _orderHashMap.sink.add;

  Function(int) get sinkTotalOrder => _totalOrder.sink.add;

  void getOrderList() async {
    OrderDetailsModel orderDetailsModel = await api.getOrderDetails();
    sinkOrderList(orderDetailsModel);
  }

  void setOrderHashMap(orderListSnapShot) {
    if (orderListSnapShot.hasData &&
        orderListSnapShot.data is OrderDetailsModel) {
      List<Order> orderList = orderListSnapShot.data.orders.toList();
      var orders = <String, int>{};
      var currentKey;
      for (int index = 0; index < orderList.length; index++) {
        currentKey = orderList[index].menu;
        if (currentKey != null && orders.containsKey('$currentKey')) {
          orders['$currentKey'] = orders['$currentKey'] + 1;
        } else {
          orders['$currentKey'] = 1;
        }
      }
      var values = orders.values;
      var totalOrderNum = values.reduce((sum, element) => sum + element);
      sinkTotalOrder(totalOrderNum);
      sinkOrderHashMap(orders);
    }
  }

  void deleteOrder(Order order) async {
    api.deleteOrder(order.userid);
  }

  @override
  void dispose() {
    _pageIndex.close();
    _pageNames.close();
    _appbarFlag.close();
    _orderList.close();
    _orderHashMap.close();
    _totalOrder.close();
  }
}
