import 'package:colibri/core/common/bloc/base_bloc.dart';
import 'package:colibri/core/common/uistate/common_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget blocProvider<B extends Cubit<CommonUIState<T>>,T>(T value, B bloc){
  return BlocBuilder<B,CommonUIState>(
    builder: (BuildContext context, state) {
      return state.when(
          initial: ()=>Container(child: Text("init"),),
          success: (d)=>Container(child: Text("Success"),),
          loading: ()=>Container(child: Text("loading"),),
          error: (e)=>Container(child: Text('erro'),));
    },
  );
}

