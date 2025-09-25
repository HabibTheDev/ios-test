import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/repository/local/media_repo.dart';
import '../../../../shared/services/service_locator.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';

class AddImageWidget extends StatefulWidget {
  const AddImageWidget({super.key, required this.imageList, required this.onDelete, required this.onAddImage});
  final List<File> imageList;
  final Function(List<int>) onDelete;
  final Function(File) onAddImage;

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  bool _selectEnabled = false;
  final List<int> _selectedIndex = [];

  void _onLongPress(index) {
    if (!_selectEnabled) {
      setState(() {
        _selectEnabled = true;
        _selectedIndex.add(index);
      });
    }
  }

  void _onTap(index) {
    if (!_selectEnabled) return;
    if (_selectedIndex.contains(index)) {
      setState(() {
        _selectedIndex.remove(index);
        if (_selectedIndex.isEmpty) {
          _selectEnabled = false;
        }
      });
    } else {
      setState(() {
        _selectedIndex.add(index);
      });
    }
  }

  Future<void> _addImage() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final File? file = await ServiceLocator.get<MediaRepo>().getImageFromCamera();
    if (file != null) {
      final String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      final File savedFile = await File(file.path).copy('${appDir.path}/$fileName');
      widget.onAddImage(savedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 6,
          runSpacing: 6,
          children: List.generate(
            widget.imageList.length,
            (imageIndex) {
              File imageFile = widget.imageList[imageIndex];
              return imageFile.path.isNotEmpty
                  ? InkWell(
                      onLongPress: () => _onLongPress(imageIndex),
                      onTap: () => _onTap(imageIndex),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        child: Stack(
                          children: [
                            Image.file(imageFile, height: 60, width: 72, fit: BoxFit.cover),
                            if (_selectedIndex.contains(imageIndex))
                              Container(
                                height: 60,
                                width: 72,
                                decoration: const BoxDecoration(color: Colors.white60),
                                child: const Icon(Icons.check_circle, color: AppColors.primaryColor),
                              )
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: _addImage,
                      child: BorderCardWidget(
                        height: 60,
                        width: 72,
                        borderColor: AppColors.primaryColor,
                        borderWidth: 0.5,
                        child: SvgPicture.asset(Assets.assetsSvgGeneralCameraPlus, fit: BoxFit.scaleDown),
                      ),
                    );
            },
          ),
        ),

        // Delete button
        if (_selectedIndex.isNotEmpty)
          InkWell(
            onTap: () {
              widget.onDelete(_selectedIndex);
              setState(() {
                _selectedIndex.clear();
                _selectEnabled = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BodyText(text: '${locale?.remove} ', textColor: AppColors.errorColor, fontWeight: FontWeight.bold),
                const Icon(Icons.delete_outline_sharp, color: AppColors.errorColor, size: 18)
              ],
            ),
          ).paddingOnly(top: 26)
      ],
    );
  }
}
