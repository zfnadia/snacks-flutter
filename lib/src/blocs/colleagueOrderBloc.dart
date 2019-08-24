import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/blocs/validators/validators.dart';
import 'package:snacks_app/src/repository/api.dart';
import 'package:snacks_app/src/repository/modelClasses/orderModel.dart';
import 'package:snacks_app/src/repository/modelClasses/userListModel.dart';
import 'package:snacks_app/src/sessionManager/sessionManager.dart';

class ColleagueOrderBloc extends BlocBase with Validators {
  List<User> mUserList = List<User>();
  final _userList = BehaviorSubject<UserListModel>();
  final _userDropdownValue = BehaviorSubject<User>();
  final _radioBtnOrderValue = BehaviorSubject<String>();
  var trimmedOrder;

  Stream<UserListModel> get userList =>
      _userList.stream.transform(validateUsers);

  Stream<User> get userDropdownValue => _userDropdownValue.stream;

  Stream<String> get radioBtnOrderValue => _radioBtnOrderValue.stream;

  Function(UserListModel) get sinkUserList => _userList.sink.add;

  Function(User) get changeUserDropdownValue => _userDropdownValue.sink.add;

  Function(String) get changeMyOrder => _radioBtnOrderValue.sink.add;

  void showUserList() async {
    UserListModel userListModel = await api.getUserList();
    sinkUserList(userListModel);
  }

  /*Had to trim the order selected through Radio Button as Radio widget is 
   returning value with a leading space when onChanged is being called. BAZINGA */
  void trimLeadingSpace(String str) {
    trimmedOrder = str.replaceFirst(new RegExp(r"^\s+"), "");
  }

  void sendColleagueOrder() async {
    var userID = await sessionManager.userID;
    trimLeadingSpace(_radioBtnOrderValue.value);

    await api.sendOrder(_userDropdownValue.value.gid,
        _userDropdownValue.value.uname, trimmedOrder, userID);
    print(_userDropdownValue.value.uname);
  }

  Future<String> viewPresentOrder() async {
    OrderModel orderModel =
        await api.getOrderStatus(_userDropdownValue.value.gid);
    return orderModel.messageType;
  }

  @override
  void dispose() {
    _userList.close();
    _userDropdownValue.close();
    _radioBtnOrderValue.close();
  }
}
