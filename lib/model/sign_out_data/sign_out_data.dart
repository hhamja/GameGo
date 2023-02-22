import 'package:gamegoapp/utilites/index/index.dart';

List<String> leaveAppValue = [
  '선택해주세요',
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
  } else if (selectedLeaveReason == leaveAppValue[9]) {
    return leaveReasonSolution[9];
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
  '개인정보노출',
  '스팸 · 광고 · 홍보성',
  '사기 · 거짓',
  '중복게시물',
  '$appName 밖에서 대화유도',
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
