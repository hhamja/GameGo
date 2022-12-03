import 'package:mannergamer/utilites/index/index.dart';

class CustomMannerAge extends StatelessWidget {
  final String mannerAge; //매너나이
  const CustomMannerAge(this.mannerAge);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          heightFactor: 0.8,
          child: Container(
            //container에 마우스 올리면 매너나이에 대한 설명나오게 하기
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '매너나이',
                  style: TextStyle(fontSize: 13, height: 1.28),
                ),
                IconButton(
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.centerLeft,
                    onPressed: () {},
                    icon: Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                    )),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('첫 나이 20.0세', style: TextStyle(fontSize: 12)),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${mannerAge}세',
                            style: TextStyle(
                                fontSize: 20, height: 1.2, color: Colors.blue),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.sentiment_satisfied,
                            size: 28,
                          )
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
                  thickness: 20,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                ),
                barPointers: [
                  LinearBarPointer(
                    value: double.parse(mannerAge),
                    color: Colors.blue,
                    thickness: 20,
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
