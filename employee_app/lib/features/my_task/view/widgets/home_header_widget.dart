part of 'widget_imports.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key, required this.taskOverviewModel, required this.myTaskController});
  final TaskOverviewModel? taskOverviewModel;
  final MyTaskController myTaskController;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      height: 270,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Welcome message
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(text: '${locale?.welcomeBack} 👋', textColor: AppColors.lightAppBarIconColor),
                  TitleText(text: '${locale?.readyForYourTask}?', textColor: AppColors.lightAppBarIconColor),
                ],
              ),
              const Spacer(),
              //Search Icon
              InkWell(
                onTap: () async {
                  await Get.toNamed(RouterPaths.search);
                  myTaskController.refreshMyTask();
                },
                child: const Icon(Icons.search, color: AppColors.lightAppBarIconColor),
              ),
            ],
          ),
          const HeightBox(height: 28),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Task summery
                  SizedBox(
                    height: 156,
                    width: 156,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      value:
                          taskOverviewModel?.todayCompletedTasksCount != null &&
                              taskOverviewModel!.todayTasksCount.isNotNullNotZero()
                          ? (int.parse('${taskOverviewModel?.todayCompletedTasksCount ?? 0}') /
                                    int.parse('${taskOverviewModel?.todayTasksCount ?? 0}'))
                                .toDouble()
                          : 0,
                      strokeWidth: 14,
                      strokeCap: StrokeCap.round,
                      backgroundColor: Colors.black12,
                    ),
                  ),

                  // Incomplete & In progress Button
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(color: AppColors.lightAppBarIconColor, fontSize: 14),
                          children: [
                            TextSpan(
                              text: '${taskOverviewModel?.todayCompletedTasksCount ?? '0'}',
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                            ),
                            TextSpan(text: '/${taskOverviewModel?.todayTasksCount ?? '0'}'),
                          ],
                        ),
                      ),
                      SmallText(text: '${locale?.todaysTasks}', textColor: AppColors.lightAppBarIconColor),
                    ],
                  ),
                ],
              ).paddingOnly(left: 8),
              const WidthBox(width: 32),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeTaskCard(
                      title: '${locale?.inProgress}',
                      value: '${taskOverviewModel?.inProgressTasksCount ?? '0'}',
                      onTap: () async {
                        await Get.toNamed(RouterPaths.inProgress);
                        myTaskController.refreshMyTask();
                      },
                    ),
                    const AppDivider(color: Colors.white24, height: 26),
                    HomeTaskCard(
                      title: '${locale?.pendingTasks}',
                      value: '${taskOverviewModel?.pendingTaskCount ?? '0'}',
                      onTap: () async {
                        await Get.toNamed(RouterPaths.pendingTasks);
                        myTaskController.refreshMyTask();
                      },
                    ),
                    const AppDivider(color: Colors.white24, height: 26),
                    HomeTaskCard(
                      title: '${locale?.completedTask}',
                      value: '${taskOverviewModel?.totalTasksCount ?? '0'}',
                      onTap: () async {
                        await Get.toNamed(RouterPaths.completedTasks);
                        myTaskController.refreshMyTask();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
