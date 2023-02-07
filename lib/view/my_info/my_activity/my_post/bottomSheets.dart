import 'package:mannergamer/utilites/index/index.dart';

void leftTabOpenBottomSheet() {
  Get.bottomSheet(
    Container(
      color: appWhiteColor,
      height: 240,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(onPressed: () {}, child: Text('게시글 수정')),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(onPressed: () {}, child: Text('숨기기')),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '삭제',
                    style: TextStyle(color: Colors.redAccent),
                  )),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('닫기')),
              width: double.infinity,
            ),
          ),
        ],
      ),
    ),
  );
}

void centerTabOpenBottomSheet() {
  Get.bottomSheet(
    Container(
      color: appWhiteColor,
      height: 300,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(onPressed: () {}, child: Text('듀오 찾는 중')),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(onPressed: () {}, child: Text('게시물 수정')),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(onPressed: () {}, child: Text('숨기기')),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '삭제',
                    style: TextStyle(color: Colors.redAccent),
                  )),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('닫기')),
              width: double.infinity,
            ),
          ),
        ],
      ),
    ),
  );
}

void rightTabOpenBottomSheet() {
  Get.bottomSheet(
    Container(
      color: appWhiteColor,
      height: 180,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(onPressed: () {}, child: Text('게시글 수정')),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '삭제',
                    style: TextStyle(color: Colors.redAccent),
                  )),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('닫기')),
              width: double.infinity,
            ),
          ),
        ],
      ),
    ),
  );
}

void viewSentReviewsBottomSheet() {
  Get.bottomSheet(
    Container(
      color: appWhiteColor,
      height: 120,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '게임 후기 취소하기',
                    style: TextStyle(color: Colors.redAccent),
                  )),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('닫기')),
              width: double.infinity,
            ),
          ),
        ],
      ),
    ),
  );
}

void receivedReviewsBottomSheet() {
  Get.bottomSheet(
    Container(
      color: appWhiteColor,
      height: 120,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.redAccent),
                  )),
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('닫기')),
              width: double.infinity,
            ),
          ),
        ],
      ),
    ),
  );
}
