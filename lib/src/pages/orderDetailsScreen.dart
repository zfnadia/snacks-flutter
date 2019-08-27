import 'package:flutter/material.dart';
import 'package:snacks_app/src/blocs/orderDetailsBloc.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/repository/modelClasses/orderDetailModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  OrderDetailsState createState() => OrderDetailsState();
}

class OrderDetailsState extends State<OrderDetailsScreen> {
  OrderDetailsBloc _orderDetailsBloc;

  @override
  Widget build(BuildContext context) {
    _orderDetailsBloc = BlocProvider.of(context);
    _orderDetailsBloc.getOrderList();

    // TODO: implement build
    return StreamBuilder(
        stream: _orderDetailsBloc.orderList,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data is OrderDetailsModel) {
            List<Order> orderList = snapshot.data.orders.toList();
            return ListView.builder(
              itemCount: snapshot.data == null ? 0 : orderList.length,
              itemBuilder: (context, int index) {
                var name = orderList[index].uname;
                var orderedBy = orderList[index].orderedby;
                var menuItem = orderList[index].menu;
                return Slidable(
                  actionExtentRatio: 0.25,
                  actionPane: SlidableBehindActionPane(),
                  child: Card(
                    elevation: 3.0,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.hasData && snapshot.data.orders[index].uname is String
                                      ? name
                                      : "No order has been placed yet!",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  snapshot.hasData && snapshot.data.orders[index].orderedby is String
                                      ? "Ordered By: $orderedBy"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(children: <Widget>[
                                Text(
                                    snapshot.hasData && snapshot.data.orders[index].menu is String
                                        ? menuItem
                                        : "",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black87))
                              ])),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
//                        _showSnackBar(context, 'Deleted');
                        _orderDetailsBloc.deleteOrder(orderList[index]);
                        orderList.removeAt(index);
                        setState(() {});
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            return Text("");
          }
        });
  }

//  void _showSnackBar(BuildContext context, String text) {
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
//  }
}
