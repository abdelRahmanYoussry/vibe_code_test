import 'dart:convert' show base64Decode;
import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/utils/color_utils.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/utils/file_utils.dart';
import 'package:test_vibe/core/utils/launcher_utils.dart';
import 'package:test_vibe/core/utils/safe_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gif/gif.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:size_config/size_config.dart';

class Pic extends StatelessWidget {
  static precache(BuildContext context) async {
    Future<void> _precacheImage(String image, BuildContext context) async {
      try {
        if ([
          'png',
          'jpg',
          'jpeg',
          'gif',
        ].any((e) => image.endsWith(e))) {
          await precacheImage(AssetImage(image), context);
          return;
        }
        if ([
          'svg',
        ].any((e) => image.endsWith(e))) {
          final loader = SvgAssetLoader(image);
          await svg.cache.putIfAbsent(loader.cacheKey(context), () => loader.loadBytes(context));
          return;
        }
      } catch (_) {}
    }

    await Future.wait([
      for (final asset in Assets.icons.values) _precacheImage(asset.path, context),
      for (final asset in Assets.images.values) _precacheImage(asset.path, context),
    ]);
  }

  const Pic(
    this.src, {
    super.key,
    this.placeholder,
    double? size,
    double? height,
    double? width,
    this.color,
    this.blendMode,
    this.fit,
    this.loadingBuilder,
    this.imageBuilder,
    this.repeat = false,
    this.imageClickable = true,
    this.direction,
    this.alignment,
    this.iconTheme,
    this.inherit = false,
  })  : width = width ?? size,
        height = height ?? size,
        memory = null;

  const Pic.memory(
    Uint8List this.memory, {
    super.key,
    this.placeholder,
    double? size,
    double? height,
    double? width,
    this.color,
    this.blendMode,
    this.fit,
    this.repeat = false,
    this.imageClickable = true,
    this.direction,
    this.alignment,
    this.iconTheme,
    this.inherit = false,
  })  : src = '',
        width = width ?? size,
        height = height ?? size,
        loadingBuilder = null,
        imageBuilder = null;

  final String src;
  final Widget Function(double progress)? loadingBuilder;
  final Widget Function(ImageProvider provider)? imageBuilder;
  final Widget? placeholder;
  final Uint8List? memory;
  final Color? color;
  final BlendMode? blendMode;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool repeat;
  final bool imageClickable;
  final TextDirection? direction;
  final Alignment? alignment;
  final bool inherit;
  final IconThemeData? iconTheme;

  @override
  Widget build(BuildContext context) {
    return RTLAware(
      direction: direction,
      child: _buildPicture(context),
    );
  }

  Widget _buildPicture(BuildContext context) {
    final isSvg = src.endsWith('svg');
    final isGif = src.endsWith('gif');

    if (!validString(src)) {
      return placeholder ??
          DefaultEmptyImage(
            width: width,
            height: height,
          );
    }

    final isId = validInt(src);
    if (isId) {
      return _downloadableImage();
    }

    final isAsset = src.startsWith('assets');
    if (isAsset) {
      if (isGif && repeat == false) {
        return _gifImage();
      }
      return isSvg ? _assetSvg(context) : _assetImage();
    }

    final isNetwork = src.startsWith('http');
    if (isNetwork) {
      return isSvg ? _networkSvg(context) : _networkImage(context);
    }

    final file = File(src);
    final isFile = file.existsSync();
    if (isFile) {
      return isSvg ? _fileSvg(file) : _fileImage(context, file);
    }

    var memory = this.memory;
    if (validString(src)) {
      try {
        memory = base64Decode(src);
      } catch (_) {}
    }
    final isMemory = memory != null;
    if (isMemory) {
      return isSvg ? _memSvg(context, memory) : _memImage(context, memory);
    }

    return DefaultEmptyImage(
      width: width,
      height: height,
    );
  }

  Widget _gifImage() => _GifImage(
        src: src,
        height: height,
        color: color,
        blendMode: blendMode,
        width: width,
        fit: fit,
        placeholder: placeholder,
        repeat: repeat,
        alignment: alignment ?? Alignment.center,
      );

  Widget _assetImage() => Image.asset(
        src,
        height: height,
        color: color,
        colorBlendMode: blendMode,
        width: width,
        fit: fit,
        alignment: alignment ?? Alignment.center,
      );

  Widget _networkImage(BuildContext context) {
    // if (!isImage(src)) {
    //   return FileWidget(src: src);
    // }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: !imageClickable ? null : () => Nav.photoView(context, src),
      onTap: () {
        //todo nav photo view
      },
      child: CachedNetworkImage(
        imageUrl: src,
        height: height,
        width: width,
        color: color,
        colorBlendMode: blendMode,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ??
            DefaultEmptyImage(
              height: height,
              width: width,
            ),
        errorWidget: (context, url, error) =>
            placeholder ??
            DefaultEmptyImage(
              height: height,
              width: width,
            ),
        imageBuilder: imageBuilder == null ? null : (context, imageProvider) => imageBuilder!.call(imageProvider),
        progressIndicatorBuilder: loadingBuilder == null
            ? null
            : (context, url, progress) => loadingBuilder!.call(progress.downloaded / (progress.totalSize ?? 1)),
        alignment: alignment ?? Alignment.center,
      ),
    );
  }

  Widget _fileImage(BuildContext context, File file) {
    if (!isImage(file.path)) {
      return CustomFileWidget(file: file);
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: !imageClickable ? null : () => Nav.photoViewFile(context, file),
      onTap: () {
        //todo nav photo view
      },
      child: Image.file(
        file,
        color: color,
        colorBlendMode: blendMode,
        height: height,
        width: width,
        fit: fit,
        alignment: alignment ?? Alignment.center,
      ),
    );
  }

  Widget _memImage(BuildContext context, Uint8List memory) {
    if (!isImage(src, memory)) {
      return CustomFileWidget(memory: memory);
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: !imageClickable ? null : () => Nav.photoViewMemory(context, memory),
      onTap: () {
        //todo nav photo view
      },
      child: Image(
        image: CacheMemoryImageProvider(src, memory),
        color: color,
        colorBlendMode: blendMode,
        height: height,
        width: width,
        fit: fit,
        alignment: alignment ?? Alignment.center,
      ),
    );
  }

  Widget _assetSvg(BuildContext context) {
    final iconTheme = this.iconTheme ?? IconTheme.of(context);
    Color? color;
    if (this.color != null) {
      color = this.color;
    } else if ((inherit || this.iconTheme != null) && iconTheme.color != null) {
      color = iconTheme.color;
    }
    double? width;
    if (this.width != null) {
      width = this.width;
    } else if ((inherit || this.iconTheme != null) && iconTheme.size != null) {
      width = iconTheme.size;
    }
    double? height;
    if (this.height != null) {
      height = this.height;
    } else if ((inherit || this.iconTheme != null) && iconTheme.size != null) {
      height = iconTheme.size;
    }
    return SvgPicture.asset(
      src,
      colorFilter: color == null ? null : ColorFilter.mode(color, blendMode ?? BlendMode.srcIn),
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
      placeholderBuilder: placeholder == null ? null : (context) => placeholder!,
      alignment: alignment ?? Alignment.center,
    );
  }

  Widget _networkSvg(BuildContext context) {
    final iconTheme = this.iconTheme ?? IconTheme.of(context);
    Color? color;
    if (this.color != null) {
      color = this.color;
    } else if ((inherit || this.iconTheme != null) && iconTheme.color != null) {
      color = iconTheme.color;
    }
    double? width;
    if (this.width != null) {
      width = this.width;
    } else if ((inherit || this.iconTheme != null) && iconTheme.size != null) {
      width = iconTheme.size;
    }
    double? height;
    if (this.height != null) {
      height = this.height;
    } else if ((inherit || this.iconTheme != null) && iconTheme.size != null) {
      height = iconTheme.size;
    }
    return SvgPicture.network(
      src,
      colorFilter: color == null ? null : ColorFilter.mode(color, blendMode ?? BlendMode.srcIn),
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
      alignment: alignment ?? Alignment.center,
    );
  }

  Widget _fileSvg(File file) => SvgPicture.file(
        file,
        colorFilter: color == null ? null : ColorFilter.mode(color!, blendMode ?? BlendMode.srcIn),
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
        alignment: alignment ?? Alignment.center,
      );

  Widget _memSvg(BuildContext context, Uint8List memory) {
    final iconTheme = this.iconTheme ?? IconTheme.of(context);
    Color? color;
    if (this.color != null) {
      color = this.color;
    } else if ((inherit || this.iconTheme != null) && iconTheme.color != null) {
      color = iconTheme.color;
    }
    double? width;
    if (this.width != null) {
      width = this.width;
    } else if ((inherit || this.iconTheme != null) && iconTheme.size != null) {
      width = iconTheme.size;
    }
    double? height;
    if (this.height != null) {
      height = this.height;
    } else if ((inherit || this.iconTheme != null) && iconTheme.size != null) {
      height = iconTheme.size;
    }
    return SvgPicture.memory(
      memory,
      colorFilter: color == null ? null : ColorFilter.mode(color, blendMode ?? BlendMode.srcIn),
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
      alignment: alignment ?? Alignment.center,
    );
  }

  // Widget _downloadableImage() => FutureBuilder(
  //       future: di<AuthRepo>().getAttachment(src),
  //       builder: (context, snapshot) {
  //         Widget? pic;
  //         snapshot.data?.fold(
  //           (l) {},
  //           (r) {
  //             pic = Pic(
  //               r,
  //               placeholder: placeholder,
  //               height: height,
  //               width: width,
  //               color: color,
  //               blendMode: blendMode,
  //               fit: fit,
  //               loadingBuilder: loadingBuilder,
  //               imageBuilder: imageBuilder,
  //               repeat: repeat,
  //               rtlAware: rtlAware,
  //               direction: direction,
  //               alignment: alignment ?? Alignment.center,
  //             );
  //           },
  //         );
  //         return pic ?? const DefaultEmptyImage();
  //       },
  //     );

  //todo implement downloadable image
  Widget _downloadableImage() => SizedBox();
}

class _GifImage extends StatefulWidget {
  const _GifImage({
    required this.repeat,
    required this.src,
    this.color,
    this.blendMode,
    this.height,
    this.width,
    this.fit,
    this.placeholder,
    this.alignment,
  });

  final String src;
  final Color? color;
  final BlendMode? blendMode;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Widget? placeholder;
  final Alignment? alignment;
  final bool repeat;

  @override
  State<_GifImage> createState() => _GifImageState();
}

class _GifImageState extends State<_GifImage> with SingleTickerProviderStateMixin {
  late GifController controller;

  @override
  void initState() {
    controller = GifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Gif(
      image: AssetImage(widget.src),
      controller: controller,
      height: widget.height,
      width: widget.width,
      color: widget.color,
      colorBlendMode: widget.blendMode,
      fit: widget.fit,
      autostart: widget.repeat ? Autostart.loop : Autostart.once,
      repeat: widget.repeat ? ImageRepeat.repeat : ImageRepeat.noRepeat,
      alignment: widget.alignment ?? Alignment.center,
      placeholder: (context) => widget.placeholder ?? const SizedBox(),
      onFetchCompleted: () {},
    );
  }
}

class DefaultEmptyImage extends StatelessWidget {
  const DefaultEmptyImage({
    super.key,
    this.width,
    this.height,
    this.size,
  });

  final double? width;
  final double? height;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Pic(
      isApplicationDarkMode(context) ? Assets.images.noImageDark.path : Assets.images.noImageLight.path,
      height: height,
      width: width,
      size: size,
      fit: BoxFit.cover,
    );
  }
}

class RTLAware extends StatelessWidget {
  const RTLAware({
    super.key,
    required this.child,
    this.direction,
  });

  final Widget child;
  final TextDirection? direction;

  @override
  Widget build(BuildContext context) {
    final direction = this.direction ?? TextDirection.ltr;
    return Transform.scale(
      scaleX: Directionality.of(context) == direction ? 1 : -1,
      child: child,
    );
  }
}

class CustomFileWidget extends StatelessWidget {
  const CustomFileWidget({
    super.key,
    this.src,
    this.file,
    this.memory,
  });

  final String? src;
  final File? file;
  final Uint8List? memory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (file != null) {
          await launchFile(file!);
        } else if (memory != null) {
          await openMemoryFile(memory!);
        } else if (src != null && validString(src)) {
          final file = await downloadFile(context, src!, '${DateTime.now().millisecondsSinceEpoch}.txt');
          if (file != null) {
            await launchFile(file);
          }
        }
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(getBorderRadius()),
            // color: ColorsHelper.filePicBGColor(context),
            ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: AutoSizeText(
                file?.path.safeSplit('/').safeLast?.safeSplit('.').safeFirst ?? '',
                stepGranularity: 1.sp,
                maxFontSize: 12.sp,
                minFontSize: 8.sp,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                // style: RequiredTextStyle(
                //   context: context,
                //   fontFamily: (s) => s.body,
                //   fontWeight: (s) => s.regular,
                //   fontSize: (s) => s.xxs,
                //   height: (s) => s.xxs,
                //   color: ColorsHelper.filePicFGColor(context),
                // ),
              ),
            ),
            SizedBox(height: 2.h),
            isVideo(file?.path ?? '')
                ? Icon(
                    Icons.video_file_outlined,
                    // color: ColorsHelper.filePicFGColor(context),
                    size: 24.w,
                  )
                : isAudio(file?.path ?? '')
                    ? Icon(
                        Icons.audio_file_outlined,
                        // color: ColorsHelper.filePicFGColor(context),
                        size: 24.w,
                      )
                    : Pic(
                        '',
                        // Assets.fileAttachment,
                        // color: ColorsHelper.filePicFGColor(context),
                        height: 24.w,
                        width: 24.w,
                      ),
          ],
        ),
      ),
    );
  }
}

openMemoryFile(Uint8List memory) async {
  try {
    final dir = await getTemporaryDirectory();
    String ext = 'txt';
    try {
      final mime = lookupMimeType('', headerBytes: memory);
      ext = mime?.safeSplit('/').safeLast ?? 'txt';
    } catch (_) {}
    final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.$ext';
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
      await file.create();
    } else {
      await file.create();
    }
    await file.writeAsBytes(memory);
    await launchFile(file);
  } catch (_) {}
}

class CacheMemoryImageProvider extends ImageProvider<CacheMemoryImageProvider> {
  final String tag; //the cache id use to get cache
  final Uint8List img; //the bytes of image to cache

  CacheMemoryImageProvider(this.tag, this.img);

  @override
  ImageStreamCompleter loadImage(CacheMemoryImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(decode),
      scale: 1.0,
      debugLabel: tag,
      informationCollector: () sync* {
        yield ErrorDescription('Tag: $tag');
      },
    );
  }

  Future<Codec> _loadAsync(ImageDecoderCallback decode) async {
    // the DefaultCacheManager() encapsulation, it get cache from local storage.
    final Uint8List bytes = img;

    if (bytes.lengthInBytes == 0) {
      // The file may become available later.
      PaintingBinding.instance.imageCache.evict(this);
      throw StateError('$tag is empty and cannot be loaded as an image.');
    }
    final buffer = await ImmutableBuffer.fromUint8List(bytes);

    return await decode(buffer);
  }

  @override
  Future<CacheMemoryImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CacheMemoryImageProvider>(this);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    bool res = other is CacheMemoryImageProvider && other.tag == tag;
    return res;
  }

  @override
  int get hashCode => tag.hashCode;

  @override
  String toString() => '${objectRuntimeType(this, 'CacheImageProvider')}("$tag")';
}
