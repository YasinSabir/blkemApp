import 'package:bloc/bloc.dart';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/features/search/presentation/widgets/hasttag_item.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final hashTagItems = BehaviorSubject<List<String>>();

  Function(List<String>) get changeHashTagList => hashTagItems.sink.add;
  final searchQuery = FieldValidators(null, null);

  Stream<List<String>> get haTagList =>hashTagItems.stream;

  SearchCubit() : super(SearchInitial()) {
    changeHashTagList(dummyHashTags);
    searchQuery.stream.listen((event) {
     if(event.isEmpty) changeHashTagList(dummyHashTags);
     else changeHashTagList(dummyHashTags.where((element) => element.contains(event.toLowerCase())).toList());
    });
  }
}
