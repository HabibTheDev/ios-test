import '../../../core/constants/app_string.dart';

class ExchangeHistoryModel {
  final String? title;
  final String? contentText;
  final String? imageUrl;

  ExchangeHistoryModel({this.title, this.contentText, this.imageUrl});

  static List<ExchangeHistoryModel> list = [
    ExchangeHistoryModel(
        title: '12 Jan 2023- Present',
        contentText: '2023 Infinite Q503456LWT',
        imageUrl: AppString.carBrandImageUrl),
    ExchangeHistoryModel(
        title: '03 Jul 2021- 12 Jan 2023',
        contentText: 'Lamborghini BlueBeast 21',
        imageUrl: AppString.carBrandImageUrl),
    ExchangeHistoryModel(
        title: '03 Jul 2021- 12 Jan 2023',
        contentText: 'Lamborghini BlueBeast 21',
        imageUrl: AppString.carBrandImageUrl),
    ExchangeHistoryModel(
        title: '03 Jul 2021- 12 Jan 2023',
        contentText: 'Lamborghini BlueBeast 21',
        imageUrl: AppString.carBrandImageUrl),
  ];
}
