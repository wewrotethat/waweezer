import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_bloc.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_data_provider.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_repository.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_state.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/widgets/admin_screens/users_list_item.dart';

class UsersList extends StatelessWidget {
  final userRoleRepository = UserRoleRepository(
      userRoleDataProvider: UserRoleDataProvider(apiHelper: APIHelper()));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRoleBloc, UserRoleState>(
      builder: (context, state) => Container(
        child: state is UserRoleOperationSuccess
            ? ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) => UserListItem(
                  user: state.users[index],
                ),
              )
            : Container(
                child: Center(
                  child: (state is UserRoleOperationInProgress)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Loading users"),
                          ],
                        )
                      : state is UserRoleOperationFailed
                          ? Text(state.error)
                          : Text(state.toString()),
                ),
              ),
      ),
    );
  }
}
