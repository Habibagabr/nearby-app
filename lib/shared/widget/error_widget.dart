import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';

class CustomErrorWidget extends StatefulWidget {
  final String? errorImage;
  final String? errorMessage;
  final TextStyle? errorMessageStyle;

  const CustomErrorWidget({
    super.key,
    this.errorMessageStyle,
    this.errorMessage,
    this.errorImage,
  });

  @override
  CustomErrorWidgetState createState() => CustomErrorWidgetState();
}

class CustomErrorWidgetState extends State<CustomErrorWidget> {
  bool _isScaled = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      if (mounted) setState(() => _isScaled = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: AppDimens.paddingL,
        vertical: AppDimens.paddingL,
      ),
      child: Column(
        spacing: AppDimens.spacingL,
        children: [
          if (widget.errorImage != null)
            AnimatedScale(
              scale: _isScaled ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: AppDimens.paddingM,
                  vertical: AppDimens.paddingS,
                ),
                decoration: BoxDecoration(shape: BoxShape.circle , color: AppColors.darkGray),
                child: Image(
                  image: AssetImage(widget.errorImage!),
                  width: screenWidth * 0.40,
                ),
              ),
            ),
          if (widget.errorMessage != null)
            Text(widget.errorMessage!, style: widget.errorMessageStyle),
        ],
      ),
    );
  }
}
