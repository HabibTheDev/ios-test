part of 'widget_imports.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.body, required this.controller});
  final AppDrawerController controller;
  final Widget body;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void dispose() {
    SocketService.instance.disconnectSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final NotificationController notificationController = Get.find();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          Navigator.of(context).pop();
        } else {
          // ignore: use_build_context_synchronously
          final shouldExit = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AppAlertDialog(
              title: '${locale?.exitApp}?',
              message: '${locale?.exitAppMgs}',
              primaryButtonText: '${locale?.exit}',
              themeColor: AppColors.warningColor,
              buttonAction: () {
                // SystemNavigator.pop();
                SocketService.instance.disconnectSocket();
                exit(0);
              },
            ),
          );
          return shouldExit ?? false;
        }
      },
      child: StatusBarWidget(
        child: Scaffold(
          key: widget.controller.drawerScaffoldKey,
          endDrawer: AppDrawer(controller: widget.controller),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            title: SvgPicture.asset(Assets.assetsSvgFleetbloxWhite, height: 20, width: 115),
            actions: [
              Obx(
                () => IconButton(
                  onPressed: () => Get.toNamed(RouterPaths.notification),
                  icon: Badge(
                    label: notificationController.unreadNotification.value != 0
                        ? SmallText(text: notificationController.unreadNotification.toString())
                        : null,
                    backgroundColor: AppColors.lightAppBarIconColor,
                    child: const Icon(Icons.notifications_none, color: AppColors.lightAppBarIconColor),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => widget.controller.drawerScaffoldKey.currentState?.openEndDrawer(),
                icon: const Icon(Icons.menu, color: AppColors.lightAppBarIconColor),
              ),
            ],
          ),
          body: widget.body,
        ),
      ),
    );
  }
}
