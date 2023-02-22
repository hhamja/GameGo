import 'package:gamegoapp/utilites/index/index.dart';

class GoodEvaluationModel {
  final String evaluationType; //'good' : 매너평가
  final String idFrom; //매너 평가 보낸 uid
  final String idTo; //매너 평가 받은 uid
  final bool kindManner; //'친절하고 매너가 좋아요.'
  final bool goodAppointment; // '시간 약속을 잘 지켜요.'
  final bool fastAnswer; //'응답이 빨라요.'
  final bool strongMental; // '맨탈이 강해요.'
  final bool goodGameSkill; // '게임 실력이 뛰어나요.'
  final bool softMannerTalk; // '착하고 부드럽게 말해요.'
  final bool comfortable; // '불편하지 않게 편하게 대해줘요.'
  final bool goodCommunication; //'게임할 떄 소통을 잘해요.'
  final bool hardGame; // '게임을 진심으로 열심히 해요.'
  final Timestamp createdAt; //생성시간

  GoodEvaluationModel({
    required this.evaluationType,
    required this.idFrom,
    required this.idTo,
    required this.kindManner,
    required this.goodAppointment,
    required this.fastAnswer,
    required this.strongMental,
    required this.goodGameSkill,
    required this.softMannerTalk,
    required this.comfortable,
    required this.goodCommunication,
    required this.hardGame,
    required this.createdAt,
  });

  factory GoodEvaluationModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return GoodEvaluationModel(
      evaluationType: snapshot['evaluationType'],
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      kindManner: snapshot['kindManner'],
      goodAppointment: snapshot['goodAppointment'],
      fastAnswer: snapshot['fastAnswer'],
      strongMental: snapshot['strongMental'],
      goodGameSkill: snapshot['goodGameSkill'],
      softMannerTalk: snapshot['softMannerTalk'],
      comfortable: snapshot['comfortable'],
      goodCommunication: snapshot['goodCommunication'],
      hardGame: snapshot['hardGame'],
      createdAt: snapshot['createdAt'],
    );
  }

  //9개 매너 평가 항목 리스트
  static List goodList = [
    '친절하고 매너가 좋아요.',
    '시간 약속을 잘 지켜요.',
    '응답이 빨라요.',
    '맨탈이 강해요.',
    '게임 실력이 뛰어나요.',
    '착하고 부드럽게 말해요.',
    '불편하지 않게 편하게 대해줘요.',
    '게임할 떄 소통을 잘해요.',
    '게임을 진심으로 열심히 해요.',
  ];
}
