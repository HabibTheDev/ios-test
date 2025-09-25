part of 'widget_imports.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    this.header,
    required this.name,
    required this.imageUrl,
    required this.phone,
    required this.email,
    required this.address,
    required this.verified,
  });
  final String? header;
  final String? imageUrl;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final bool? verified;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return CardWidget(
      contentPadding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null)
            ButtonText(
              text: header!,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfilePhotoWidget(imageUrl: imageUrl, imageSize: 50),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(text: name ?? '${locale?.notAvailable}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified,
                          color: verified == true ? AppColors.lightProgressColor : AppColors.lightSecondaryTextColor,
                          size: 14,
                        ),
                        SmallText(
                          text: verified == true
                              ? '${locale?.verified.toLowerCase()}'
                              : '${locale?.notVerified.toLowerCase()}',
                          textColor:
                              verified == true ? AppColors.lightProgressColor : AppColors.lightSecondaryTextColor,
                        ).paddingOnly(left: 4)
                      ],
                    )
                  ],
                ).paddingOnly(left: 8),
              )
            ],
          ).paddingOnly(bottom: 10),
          InfoWithIconTile(leadingIcon: Icons.call, title: phone).paddingOnly(bottom: 8),
          InfoWithIconTile(leadingIcon: Icons.email, title: email).paddingOnly(bottom: 8),
          InfoWithIconTile(leadingIcon: Icons.location_on, title: address),
        ],
      ),
    );
  }
}
