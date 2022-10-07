import 'package:mannergamer/utilites/index.dart';

class ChatRoomModel {
  final String id; //채팅방의 id
  final List userIdList;
  final String? postingUserId; //보내는 사람 id
  final String? peerUserId; //받는사람 id
  final String? lastContent; //마지막 채팅내용
  final String? updatedAt; //가장 최근 주고받은 일시

  ChatRoomModel({
    required this.id,
    required this.userIdList,
    this.postingUserId,
    this.peerUserId,
    this.lastContent,
    this.updatedAt,
  });

  factory ChatRoomModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return ChatRoomModel(
      id: doc['id'],
      userIdList: doc['userIdList'],
      postingUserId: doc['postingUserId'],
      peerUserId: doc['peerUserId'],
      lastContent: doc['lastContent'],
      updatedAt: doc['updatedAt'],
    );
  }
}
