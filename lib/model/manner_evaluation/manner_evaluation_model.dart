import 'package:mannergamer/utilites/index/index.dart';

class MannerEvaluationModel {
  final String idFrom; //매너 평가 보낸 uid
  final String idTo; //매너 평가 받은 uid
  final String evaluationType; //ture : 좋아요 평가, false : 별로에요 평가
  final List selectList; //선택한 평가 항목의 index 리스트 ex. [1, 3, 7 ,9]
  final Timestamp createdAt; //생성시간

  MannerEvaluationModel({
    required this.idFrom,
    required this.idTo,
    required this.evaluationType,
    required this.selectList,
    required this.createdAt,
  });

  factory MannerEvaluationModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return MannerEvaluationModel(
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      evaluationType: snapshot['evaluationType'],
      selectList: snapshot['selectList'],
      createdAt: snapshot['createdAt'],
    );
  }
}

//9개 매너 평가 항목 리스트
var goodMannerList = [
  '친절하고 매너가 좋아요.',
  '시간 약속을 잘 지켜요.',
  '응답이 빨라요.',
  '맨탈이 강해요.',
  '게임 실력이 뛰어나요.',
  '불편하지 않게 편하게 대해줘요.',
  '착하고 부드럽게 말해요.',
  '게임할 떄 소통을 잘해요.',
  '게임을 진심으로 열심히 해요.'
];

//12개 비매너 평가 항목 리스트
var badMannerList = [
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

enum BadEvaluation {
  badManner, //불친절하고 매너가 나빠요.
  appointment, //시간 약속을 안 지켜요
  answer, //응답이 늦어요
  mental, //맨탈이 약해요
  gameSkill, //게임 실력이 아쉬워요
  troll, //고의적으로 트롤 행위를 해요
  abuse, //욕설이나 험악한 말을 해요
  sexual, //성적인 발언을 해요
  shortTalk, //반말을 사용해요
  communication, //소통을 안해요
  uncomfortable, //불편한 분위기를 만들어요
  privateMeeting, //사적인 만남을 하려고 해요.
}

enum GoodEvaluation {
  kindManner,
  appointment,
  answer,
  mental,
  gameSkill,
  comfortable,
  speaking,
  Communication,
  hardGame,
}
