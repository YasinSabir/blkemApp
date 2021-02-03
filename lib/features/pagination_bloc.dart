import 'package:colibri/extensions.dart';
abstract class PaginationBloc<T>{
  final PaginationFunc<T> loadData;

  PaginationBloc(this.loadData);
}

class NewBloc extends PaginationBloc<String>{
  NewBloc(Future<List<T>> Function<T>({int pageKey, int pageSize}) loadData) : super(loadData);
  

  
}