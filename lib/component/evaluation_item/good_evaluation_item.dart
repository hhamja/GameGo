import 'package:gamegoapp/utilites/index/index.dart';

class GoodEvaluationItem extends StatelessWidget {
  final int element;
  final String title;
  final double verticalHeight;

  const GoodEvaluationItem({
    required this.element,
    required this.title,
    required this.verticalHeight,
  });

  @override
  Widget build(BuildContext context) {
    return element.toInt() != 0
        ? ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: verticalHeight,
              horizontal: 0,
            ),
            //  매너평가 항목 텍스트
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.people_alt_outlined),
                SizedBox(width: 5),
                // 받은 매너평가 항목 총 개수
                Text(
                  '$element',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
