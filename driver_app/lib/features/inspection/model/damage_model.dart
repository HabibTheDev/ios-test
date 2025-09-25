const imageUrl = 'https://thumbs.dreamstime.com/b/car-insurance-repair-broken-vehicle-damage-accident-218031586.jpg';

class DamageModel {
  final String areaOfDamage;
  final List<DamageDetails>? damageDetails;

  DamageModel({required this.areaOfDamage, this.damageDetails});
}

class DamageDetails {
  final String? title;
  final List<DamageSubDetails>? damageSubDetails;

  DamageDetails({this.title, this.damageSubDetails});
}

class DamageSubDetails {
  final String? imageUrl;
  final String? details;
  final String? status;

  DamageSubDetails({this.imageUrl, this.details, this.status});
}

final List<DamageModel> damageList = [
  DamageModel(
    areaOfDamage: 'Front logo',
    damageDetails: [
      DamageDetails(
        damageSubDetails: [
          DamageSubDetails(imageUrl: imageUrl, details: '1 Broken part'),
          DamageSubDetails(imageUrl: imageUrl, details: '1 Scratch'),
        ],
      )
    ],
  ),
  DamageModel(
    areaOfDamage: 'Front bumper',
    damageDetails: [
      DamageDetails(
        title: 'Front side',
        damageSubDetails: [
          DamageSubDetails(imageUrl: imageUrl, details: '4 Dents'),
        ],
      ),
      DamageDetails(
        title: 'Left side',
        damageSubDetails: [
          DamageSubDetails(imageUrl: imageUrl, details: '1 Broken part'),
          DamageSubDetails(imageUrl: imageUrl, details: '1 Scratch', status: 'new'),
        ],
      ),
      DamageDetails(
        title: 'Right side',
        damageSubDetails: [
          DamageSubDetails(imageUrl: imageUrl, details: '4 Dents'),
        ],
      )
    ],
  ),
];
