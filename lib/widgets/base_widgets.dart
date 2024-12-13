import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/base_vm.dart';

abstract class BaseWidget<V extends BaseViewModel> extends StatefulWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  State<BaseWidget> createState() => _BaseWidgetState<V>();

  @protected
  Widget buildUI(BuildContext context, V viewModel);

}

class _BaseWidgetState<V extends BaseViewModel> extends State<BaseWidget> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin,WidgetsBindingObserver  {
  late V v;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    v = context.read<V>();
    v.setContext(context);
    v.initView();
    v.initAnimation(this);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.buildUI(context,context.watch<V>());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    v.disposeView();
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //do your stuff
      v.onResume();
    }
    else if(state == AppLifecycleState.inactive){

      v.inActive();
    }
    else if(state == AppLifecycleState.paused){

      v.paused();
    }
    else if(state == AppLifecycleState.detached){

      v.detached();
    }
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
