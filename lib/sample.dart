import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'core/redux/app_state.dart';

class ResidentialMove extends StatefulWidget {
  @override
  createState() {
    return new _ResidentialMoveState();
  }
}

_ResidentialMoveState createState() => _ResidentialMoveState();
//  StoreProvider.of<AppState>(context).dispatch(DropDate(endData));
class _ResidentialMoveState extends State<ResidentialMove>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) {},
        builder: (context, state) {
          return Container();
        });
  }
}
