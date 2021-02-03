import 'package:bloc/bloc.dart';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'bookmark_state.dart';
@injectable
class BookmarkCubit extends Cubit<BookmarkState> {
  final searchQuery=FieldValidators(null,null);
  BookmarkCubit() : super(BookmarkInitial());
}
