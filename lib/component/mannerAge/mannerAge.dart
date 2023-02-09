import 'package:flutter/cupertino.dart';
import 'package:mannergamer/utilites/index/index.dart';

class CustomMannerAge extends StatelessWidget {
  final mannerAge; //매너나이
  const CustomMannerAge(this.mannerAge);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          heightFactor: 1.sp,
          child: Container(
            //container에 마우스 올리면 매너나이에 대한 설명나오게 하기
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '매너나이',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // IconButton(
                //     padding: EdgeInsets.all(2),
                //     alignment: Alignment.centerLeft,
                //     onPressed: () {},
                //     icon: Icon(
                //       CupertinoIcons.info_circle,
                //       size: 18,
                //     )),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40.sp),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 8.sp),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '첫 나이 20.0세',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 12.sp,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 3.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${mannerAge.toString()}세',
                            style: TextStyle(
                                fontSize: 16.sp,
                                height: 1.2,
                                fontWeight: FontWeight.bold,
                                color: mannerAgeColor),
                          ),
                          SizedBox(width: 5.sp),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SfLinearGauge(
                orientation: LinearGaugeOrientation.horizontal,
                minimum: 0,
                maximum: 100,
                interval: 0,
                labelPosition: LinearLabelPosition.inside,
                axisTrackStyle: LinearAxisTrackStyle(
                  thickness: 15.sp,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                ),
                barPointers: [
                  LinearBarPointer(
                    value: double.parse(mannerAge),
                    color: mannerAgeColor,
                    thickness: 15.sp,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
