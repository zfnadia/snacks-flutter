import 'package:rxdart/rxdart.dart';
import 'package:snacks_app/src/blocs/provider/blocProvider.dart';
import 'package:snacks_app/src/blocs/validators/validators.dart';
import 'package:snacks_app/src/repository/api.dart';
import 'package:snacks_app/src/repository/modelClasses/orderModel.dart';
import 'package:snacks_app/src/repository/modelClasses/userListModel.dart';
import 'package:snacks_app/src/sessionManager/sessionManager.dart';

class ColleagueOrderBloc extends BlocBase with Validators {
  @override
  void dispose() {
    _userList.close();
    _userDropdownValue.close();
    _radioBtnOrderValue.close();
  }

  List<User> mUserList = List<User>();
  final _userList = BehaviorSubject<UserListModel>();
  final _userDropdownValue = BehaviorSubject<User>();
  final _radioBtnOrderValue = BehaviorSubject<String>();

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

  void sendColleagueOrder() async {
    var userName = await sessionManager.userName;
    var userID = await sessionManager.userID;

    await api.sendOrder(_userDropdownValue.value.gid, userName,
        _radioBtnOrderValue.value, userID);
  }

  Future<String> viewPresentOrder() async {
    OrderModel orderModel =
        await api.getPresentOrder(_userDropdownValue.value.gid);
    return orderModel.messageType.toString();
  }
}
