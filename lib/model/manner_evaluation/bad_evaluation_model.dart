import 'package:gamegoapp/utilites/index/index.dart';

class BadEvaluationModel {
  final String evaluationType; //'bad' : 비매너평가
  final String idFrom; //매너 평가 보낸 uid
  final String idTo; //매너 평가 받은 uid
  final bool badManner; // '불친절하고 매너가 나빠요.'
  final bool badAppointment; // '시간 약속을 안 지켜요.'
  final bool slowAnswer; // '응답이 늦어요.'
  final bool weakMental; // '맨탈이 약해요.'
  final bool badGameSkill; // '게임 실력이 아쉬워요.'
  final bool troll; // '고의적으로 트롤 행위를 해요.'
  final bool abuseWord; // '욕설이나 험악한 말을 해요'
  final bool sexualWord; // '성적인 발언을 해요.'
  final bool shortTalk; // '반말을 사용해요'
  final bool noCommunication; // '소통을 안해요.'
  final bool uncomfortable; // '불편한 분위기를 만들어요.'
  final bool privateMeeting; // '사적인 만남을 하려고 해요.'
  final Timestamp createdAt; //생성시간

  BadEvaluationModel({
    required this.evaluationType,
    required this.idFrom,
    required this.idTo,
    required this.badManner,
    required this.badAppointment,
    required this.slowAnswer,
    required this.weakMental,
    required this.badGameSkill,
    required this.troll,
    required this.abuseWord,
    required this.sexualWord,
    required this.shortTalk,
    required this.noCommunication,
    required this.uncomfortable,
    required this.privateMeeting,
    required this.createdAt,
  });

  factory BadEvaluationModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return BadEvaluationModel(
      evaluationType: snapshot['evaluationType'],
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      badManner: snapshot['badManner'],
      badAppointment: snapshot['badAppointment'],
      slowAnswer: snapshot['slowAnswer'],
      weakMental: snapshot['weakMental'],
      badGameSkill: snapshot['badGameSkill'],
      troll: snapshot['troll'],
      abuseWord: snapshot['abuseWord'],
      sexualWord: snapshot['sexualWord'],
      shortTalk: snapshot['shortTalk'],
      noCommunication: snapshot['noCommunication'],
      uncomfortable: snapshot['uncomfortable'],
      privateMeeting: snapshot['privateMeeting'],
      createdAt: snapshot['createdAt'],
    );
  }

  //12개 비매너 평가 항목 리스트
  static List badList = [
    '불친절하고 매너가 나빠요.',
    '시간 약속을 안 지켜요.',
    '응답이 늦어요.',
    '맨탈이 약해요.',
    '게임 실력이 아쉬워요.',
    '고의적으로 트롤 행위를 해요.',
    '욕설이나 험악한 말을 해요',
    '성적인 발언을 해요.',
    '반말을 사용해요',
    '소통을 안해요.',
    '불편한 분위기를 만들어요.',
    '사적인 만남을 하려고 해요.',
  ];
}
