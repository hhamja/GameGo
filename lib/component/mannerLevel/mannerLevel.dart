import 'package:gamegoapp/utilites/index/index.dart';

class CustomMannerLevel extends StatelessWidget {
  final String level;
  // 경험치 바 표시 여부
  // 나의 매너 레벨을 볼 때만 표시
  final bool isMe;
  final String exp;

  CustomMannerLevel(
    this.level,
    this.isMe,
    this.exp,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          heightFactor: 1.sp,
          child: Container(
            // container에 마우스 올리면 매너Lv에 대한 설명나오게 하기
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '매너레벨',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 35.sp),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 40.sp),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '첫 Lv.30',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.1.sp,
                            color: appGreyColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 0.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Lv.${level} ',
                            style: TextStyle(
                              fontSize: 26,
                              height: 1.sp,
                              fontWeight: FontWeight.w500,
                              color: mannerLevelColor,
                            ),
                          ),
                          isMe
                              ? Text(
                                  '($exp%)',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // 레벨 게이지
              SfLinearGauge(
                orientation: LinearGaugeOrientation.horizontal,
                minimum: 0,
                maximum: 100,
                interval: 0,
                labelPosition: LinearLabelPosition.inside,
                axisTrackStyle: LinearAxisTrackStyle(
                  thickness: 16,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                ),
                showLabels: false,
                barPointers: [
                  LinearBarPointer(
                    value: double.parse(level),
                    color: mannerLevelColor,
                    thickness: 16,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                  )
                ],
              ),

              // 경험치 표시 여부
              isMe
                  ?
                  // 나의 프로필 페이지인 경우
                  // 경험치 게이지
                  SfLinearGauge(
                      orientation: LinearGaugeOrientation.horizontal,
                      minimum: 0,
                      maximum: 100,
                      interval: 0,
                      labelPosition: LinearLabelPosition.inside,
                      axisTrackStyle: LinearAxisTrackStyle(
                        thickness: 6.sp,
                        edgeStyle: LinearEdgeStyle.bothCurve,
                      ),
                      showLabels: true,
                      barPointers: [
                        LinearBarPointer(
                          value: double.parse(exp),
                          color: appDarkGrey,
                          thickness: 6.sp,
                          edgeStyle: LinearEdgeStyle.bothCurve,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
