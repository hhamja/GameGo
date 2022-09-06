import 'package:mannergamer/utilites/index.dart';

final double currentAgeValue = 36.8;

final Map mannerEvaluationList = {
  'goodMannerList': [
    '친절하고 매너가 좋아요.',
    '시간 약속을 잘 지켜요.',
    '응답이 빨라요.',
    '맨탈이 강해요.',
    '게임 실력이 뛰어나요.',
    '불편하지 않게 편하게 대해줘요.',
    '목소리가 좋아요.',
    '게임할 떄 소통을 잘해요.',
    '게임을 진심으로 열심히 해요.'
  ],
  'goodMannerCountList': [
    '1',
    '2',
    '3',
    '3',
    '3',
    '3',
    '3',
    '3',
    '3',
  ],
  'badMannerList': [
    '불친절하고 매너가 나빠요.',
    '시간 약속을 잘 안지켜요.',
    '응답이 너무 늦어요.',
    '맨탈이 너무 약해요.',
    '게임 실력이 너무 아쉬워요.',
    '불편한 분위기를 만들어요.',
    '목소리가 안좋아요.',
    '게임할 떄 소통을 안해요.',
    '게임을 대충대충 열심히 안해요.'
  ],
  'badmannerCountList': [
    '1',
    '2',
    '3',
    '3',
    '3',
    '3',
    '3',
    '3',
    '3',
  ],
};

final List receivedDuoReviewList = [
  '게임을 너무 잘하세요',
  '다음에 또 같이 하고 싶어요.',
  '유쾌하시고 재밌었어요 굿밤되세요 ^^',
];

final List followUesrList = ['팔로우닉네임'];
final List blockUesrList = ['차단닉네임'];
final List unexposeUserList = ['게시글노출x닉네임'];

final Map homePostList = {
  'homePostTitleList': ['제목1', '제목2', '제목3'],
  'homePostNickNameList': ['닉네임1', '닉네임2', '닉네임3']
};

final List<String> leaveAppValue = [
  '비매너 사용자를 만났어요',
  '억울하게 이용이 제한됐어요',
  '광고가 너무 많아요',
  '알림이 너무 많이 와요',
  '새 계정을 만들고 싶어요',
  '너무 내용이 많고 산만해요',
  '사용자가 너무 적어요',
  '앱을 너무 많이 이용해요',
  '기타',
];

String? selectedLeaveReason;

final String userNameID = '오뚜막';
Container showLeaveReasonSolution() {
  //selectedLeaveReason = value of DropDownButton
  if (selectedLeaveReason == leaveAppValue[0]) {
    return leaveReasonSolution[0];
  } else if (selectedLeaveReason == leaveAppValue[1]) {
    return leaveReasonSolution[1];
  } else if (selectedLeaveReason == leaveAppValue[2]) {
    return leaveReasonSolution[2];
  } else if (selectedLeaveReason == leaveAppValue[3]) {
    return leaveReasonSolution[3];
  } else if (selectedLeaveReason == leaveAppValue[4]) {
    return leaveReasonSolution[4];
  } else if (selectedLeaveReason == leaveAppValue[5]) {
    return leaveReasonSolution[5];
  } else if (selectedLeaveReason == leaveAppValue[6]) {
    return leaveReasonSolution[6];
  } else if (selectedLeaveReason == leaveAppValue[7]) {
    return leaveReasonSolution[7];
  } else if (selectedLeaveReason == leaveAppValue[8]) {
    return leaveReasonSolution[8];
  }
  return Container();
}

List<Container> leaveReasonSolution = [
  Container(
      child: Column(
    children: [
      Text('비매너 사용자'),
      TextButton(onPressed: () {}, child: Text('사용안내'))
    ],
  )),
  Container(child: Text('억울한 제한')),
  Container(child: Text('광고 많음')),
  Container(child: Text('알림이 많음')),
  Container(child: Text('새계정')),
  Container(child: Text('너무 내용이 많고 산만해요')),
  Container(child: Text('사용자가 적음.')),
  Container(child: Text('앱 많이 이용해서')),
  Container(child: Text('기타')),
];

final List reportPostReason = [
  '음란성',
  '불법 또는 규제 상품 판매',
  '폭력성 · 혐오발언 · 욕설',
  '따돌림 · 괴롭힘',
  // '지적재산권 침해', (흠... 이거는 기타사유에서 쓰게 하는게 적당할거 같다.)
  '개인정보노출',
  '스팸 · 광고 · 홍보성',
  '사기 · 거짓',
  '중복게시물',
  '매너게이머 밖에서 대화유도',
  '기타사유',
];

final List illegalProduct = [
  '생명체(식물 제외)',
  '의약품, 의료기기, 건강기능식품',
  '담배, 라이터',
  '주류',
  '마약류',
  '음란물, 성인물, 성인용품',
  '신분증, 통장, 계정',
  '불법개조 및 불법기기',
  '총기류, 도검, 전자충격기',
  '유해 화학물질: 농약, 환강물질',
  '유류: 경유, LPG, 휘발유',
  '지역상품권',
];
