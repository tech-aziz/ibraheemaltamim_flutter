
// Widget loadingIndicatorCircle({
//   required BuildContext context,
//   Color? color,
//   double? size,
// }) {
//   return Center(
//     child: LoadingAnimationWidget.fourRotatingDots(
//       color: AppColors.c5E35B1,
//       size: 50.w,
//     ),
//   );
// }

// Widget shimmer({
//   required BuildContext context,
//   double? height,
//   double? width,
// }) {
//   return Center(
//     child: Container(
//       width: width,
//       child:
//           Lottie.asset(Assets.json.shimmer, height: height, fit: BoxFit.fill),
//     ),
//   );
// }

// Widget noDataFound({
//   required BuildContext context,
//   Color? color,
//   double? size,
// }) {
//   double loaderSize = 250.sp;
//   return DotLottieLoader.fromAsset(Assets.animations.noData,
//       frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
//     if (dotlottie != null) {
//       return Center(
//         child: Container(
//           child: Lottie.memory(dotlottie.animations.values.single,
//               height: loaderSize, width: loaderSize),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   });
// }

// Widget errorData({
//   required BuildContext context,
//   Color? color,
//   double? size,
// }) {
//   double loaderSize = 250.sp;
//   return DotLottieLoader.fromAsset(Assets.animations.error,
//       frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
//     if (dotlottie != null) {
//       return Center(
//         child: Container(
//           child: Lottie.memory(dotlottie.animations.values.single,
//               height: loaderSize, width: loaderSize),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   });
// }
