import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';

class FullScreenImageViewer extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(
      initialPage: initialIndex,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Center(
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.contain,
                    errorBuilder: (c, o, s) => Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 50.sp,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 40.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 24.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
