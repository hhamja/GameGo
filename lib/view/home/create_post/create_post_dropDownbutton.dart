import 'package:gamego/utilites/index/index.dart';

class AddPostDropDownButton extends StatelessWidget {
  const AddPostDropDownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 게임모드
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              // 3개 패딩값을 zero로 해야 버튼 자체의 양옆 패딩이 없어짐
              buttonPadding: EdgeInsets.only(
                right: AppSpaceData.screenPadding,
              ),
              itemPadding: EdgeInsets.symmetric(
                horizontal: AppSpaceData.screenPadding,
              ),
              buttonHeight: 50.sp,
              itemHeight: 50.sp,
              isExpanded: true,

              hint: Text(
                '게임모드',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              items: gameModeList
                  .map(
                    (modeItem) => DropdownMenuItem<String>(
                      value: modeItem,
                      child: Text(
                        modeItem,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                  .toList(),
              value: controller.seledtedPostGamemodeValue,
              onChanged: controller.showPositonAndTear,
            ),
          ),
          // 포지션 드랍다운버튼
          Visibility(
            visible: controller.showPosition,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                buttonPadding: EdgeInsets.only(
                  right: AppSpaceData.screenPadding,
                ),
                itemPadding: EdgeInsets.symmetric(
                  horizontal: AppSpaceData.screenPadding,
                ),
                buttonHeight: 50.sp,
                itemHeight: 50.sp,
                isExpanded: true,
                hint: Text(
                  '포지션',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                items: postionList
                    .map(
                      (positionItem) => DropdownMenuItem<String>(
                        value: positionItem,
                        child: Text(
                          positionItem,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                value: controller.seledtedPostdPositionValue,
                onChanged: (positionValue) {
                  controller.seledtedPostdPositionValue =
                      positionValue as String;
                  controller.update();
                },
              ),
            ),
          ),
          //티어 드랍다운버튼
          Visibility(
            visible: controller.showTear,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                buttonPadding: EdgeInsets.only(
                  right: AppSpaceData.screenPadding,
                ),
                itemPadding: EdgeInsets.symmetric(
                  horizontal: AppSpaceData.screenPadding,
                ),
                buttonHeight: 50.sp,
                itemHeight: 50.sp,
                isExpanded: true,
                hint: Text(
                  '티어',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                items: tearList
                    .map(
                      (tearItem) => DropdownMenuItem<String>(
                        value: tearItem,
                        child: Text(
                          tearItem,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                value: controller.seledtedPostTearValue,
                onChanged: (tearValue) {
                  controller.seledtedPostTearValue = tearValue as String;
                  controller.update();
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
