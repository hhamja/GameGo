import 'package:mannergamer/utilites/index/index.dart';

class BadEvaluationItem extends StatelessWidget {
  final int element;
  final String title;

  const BadEvaluationItem({
    required this.element,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    //동일 항목이 2개 이상인 경우에만 표시
    return element >= 2
        ? ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.sp,
              horizontal: 0,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.people_alt_outlined),
                SizedBox(width: 4.sp),
                // 받은 매너평가 항목 총 개수
                Text(
                  '$element',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
