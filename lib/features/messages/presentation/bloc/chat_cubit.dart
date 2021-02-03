import 'package:bloc/bloc.dart';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/features/messages/domain/entity/chat_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:colibri/extensions.dart';
part 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {

  final messageController=BehaviorSubject<List<ChatEntity>>.seeded(ChatEntity.getDummyData());
  Function(List<ChatEntity>) get changeMessageList=>messageController.sink.add;
  Stream<List<ChatEntity>> get messageList=>messageController.stream;

  final searchQuery=FieldValidators(null,null);

  final message=FieldValidators(null, null);
  ChatCubit() : super(ChatInitial());

  sendMessage(){
    var items=messageController.value;
    items.add(ChatEntity(
      message: message.text,
      time: DateTime.now().getCurrentFormattedTime()
    ));
    changeMessageList(items);
  }
}
