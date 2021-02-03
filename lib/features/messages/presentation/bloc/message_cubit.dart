import 'package:bloc/bloc.dart';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'message_state.dart';

@injectable
class MessageCubit extends Cubit<MessageState> {

  final messageController=BehaviorSubject<List<String>>();
  Function(List<String>) get changeMessageList=>messageController.sink.add;
  Stream<List<String>> get messageList=>messageController.stream;
  final searchQuery=FieldValidators(null,null);
  MessageCubit() : super(MessageInitial());
}
