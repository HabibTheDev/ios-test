import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/services/local/orientation_service.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/text_widget.dart';

class ImageAndVideoWidget extends StatefulWidget {
  const ImageAndVideoWidget({super.key});

  @override
  State<ImageAndVideoWidget> createState() => _ImageAndVideoWidgetState();
}

class _ImageAndVideoWidgetState extends State<ImageAndVideoWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    OrientationService().showStatusBar();
    OrientationService().portraitOrientation();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4'));
    await _videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      allowPlaybackSpeedChanging: false,
      showOptions: false,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      hideControlsTimer: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyText(
          text: 'Images & 360° video ',
          fontWeight: FontWeight.w700,
          textColor: AppColors.lightSecondaryTextColor,
        ).paddingOnly(bottom: 16),

        //Video Player
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Chewie(controller: _chewieController!))
            : const CenterLoadingWidget(),
        const HeightBox(height: 10),

        Wrap(
          children: [1, 2, 3, 4, 5, 6, 7, 8]
              .map((item) => item == 8
                  ? Container(
                      height: 70,
                      width: 70,
                      alignment: Alignment.center,
                      child: const BodyText(
                        text: 'View all',
                        textColor: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const Icon(
                      Icons.image,
                      size: 70,
                      color: AppColors.lightTextFieldHintColor,
                    ))
              .toList(),
        )
      ],
    );
  }
}
