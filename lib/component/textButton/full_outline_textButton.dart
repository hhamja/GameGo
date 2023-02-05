import 'package:mannergamer/utilites/index/index.dart';

// 흰색 백그라운드에 outline이 핑크색
class CustomFullOutlineTextButton extends StatelessWidget {
  const CustomFullOutlineTextButton(
    this.content,
    this.onPressed,
  );

  final String content;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 7.5.h,
      decoration: BoxDecoration(
        color: appWhiteColor,
        border: Border.all(
          color: appPrimaryColor,
          width: 0.3.w,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.sp),
        ),
      ),
      child: TextButton(
        child: Text(
          content,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
