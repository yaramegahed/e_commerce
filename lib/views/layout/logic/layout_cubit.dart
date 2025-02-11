import 'package:bloc/bloc.dart';

import 'layout_state.dart';


class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  int currentIndex=0;
  changeIndex(int index){
    currentIndex =index;
    emit(IndexChangeState());
  }
}
