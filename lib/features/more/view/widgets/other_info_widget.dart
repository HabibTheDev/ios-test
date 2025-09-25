part of 'widget_imports.dart';

class OtherInfo extends StatelessWidget {
  const OtherInfo({super.key, required this.gender, required this.dateOfBirth});
  final String? gender;
  final String? dateOfBirth;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return CardWidget(
      contentPadding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(
            text: '${locale?.otherInfo}',
            textColor: AppColors.lightSecondaryTextColor,
            fontWeight: FontWeight.bold,
          ).paddingOnly(bottom: 16),
          InfoWithIconTile(leadingIcon: Icons.person, title: gender ?? '${locale?.notAvailable}')
              .paddingOnly(bottom: 8),
          InfoWithIconTile(leadingIcon: Icons.cake, title: dateOfBirth ?? '${locale?.notAvailable}'),
        ],
      ),
    );
  }
}
