part of 'widget_imports.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key, this.message, this.onRefresh});
  final String? message;
  final Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message ?? '${locale?.noDataFound}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
          ),
          if (onRefresh != null)
            TextButton(
              onPressed: onRefresh,
              child: Text(
                '${locale?.refresh}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primaryColor),
              ),
            )
        ],
      ),
    ).paddingAll(16);
  }
}
