import 'package:mannergamer/utilites/index/index.dart';

class HomeDropDownButton extends StatefulWidget {
  const HomeDropDownButton({Key? key}) : super(key: key);

  @override
  State<HomeDropDownButton> createState() => _HomeDropDownButtonState();
}

class _HomeDropDownButtonState extends State<HomeDropDownButton> {
  HomePageDropDownBTController homeDropDownBTController =
      Get.put(HomePageDropDownBTController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageDropDownBTController>(
      builder: (controller) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 게임모드 드랍다운 버튼
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              style: Theme.of(context).textTheme.bodyMedium,
              buttonWidth:
                  controller.selectedModeValue == '무작위 총력전' ? 101.sp : 72.sp,
              dropdownWidth: 110.sp,
              isExpanded: true,
              items: gameModes.map(
                (item) {
                  return DropdownMenuItem<String>(
                    // 솔로,자유 -> 포지션과 티어 표시
                    // 일반게임 -> 포지션만 나오게
                    onTap: () {},
                    value: item,
                    child: Text(item),
                  );
                },
              ).toList(),
              value: controller.selectedModeValue,
              onChanged: controller.changeGamemode,
            ),
          ),

          SizedBox(
            width: 8.0.sp,
          ),
          // 포지션 드랍다운 버튼
          Visibility(
            visible: controller.showPosition,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                style: Theme.of(context).textTheme.bodyMedium,
                buttonWidth: 60.sp,
                dropdownWidth: 80.sp,
                isExpanded: true,
                items: postions.map(
                  (item) {
                    return DropdownMenuItem<String>(
                      onTap: () {},
                      // 솔로,자유 -> 포지션과 티어 표시
                      // 일반게임 -> 포지션만 나오게
                      value: item,
                      child: Text(item),
                    );
                  },
                ).toList(),
                value: controller.selectedPositionValue,
                onChanged: controller.changePosition,
              ),
            ),
          ),
          SizedBox(
            width: 8.0.sp,
          ),
          // 티어 드랍다운 버튼
          Visibility(
            visible: controller.showTear,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                
                style: Theme.of(context).textTheme.bodyMedium,
                buttonWidth: controller.selectedTearValue == '다이아몬드' ||
                        controller.selectedTearValue == '플래티넘'
                    ? 85.sp
                    : 70.sp,
                dropdownWidth: 100.sp,
                isExpanded: true,
                items: tears
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ),
                    )
                    .toList(),
                value: controller.selectedTearValue,
                onChanged: controller.changeTear,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
