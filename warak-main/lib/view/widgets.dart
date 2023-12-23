import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../Themes/colors.dart';
import '../main.dart';

class WarakLogo extends StatelessWidget {
  const WarakLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/warak_logo.png",
    );
  }
}

class EmailIcon extends StatelessWidget {
  const EmailIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      size: 25,
      Svg(
        "assets/icons/email_icon.svg",
      ),
    );
  }
}

class PasswordKeyIcon extends StatelessWidget {
  const PasswordKeyIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      Svg("assets/icons/login_background.png"),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        "assets/images/login_background.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

class IconButtonBack extends StatelessWidget {
  const IconButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.arrow_back_ios_outlined);
  }
}

class ActiveBottomBarIcon extends StatelessWidget {
  const ActiveBottomBarIcon({
    super.key,
    required this.widgetIcon,
  });
  final Widget widgetIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: orangeColor),
      child: widgetIcon,
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, this.photoUrl});
  final String? photoUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: currentUserInfos.imageURL != ""
            ? ClipOval(
                child: MainFunctions.pickedImage == null
                    ? CachedNetworkImage(
                        imageUrl: currentUserInfos.imageURL!,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        MainFunctions.pickedImage!,
                        fit: BoxFit.cover,
                      ))
            : ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  color: MainFunctions.generatePresizedColor(
                      currentUserInfos.lastName!.length +
                          currentUserInfos.firstName!.length),
                  child: Text(
                    currentUserInfos.lastName![0].toUpperCase(),
                    style: const TextStyle(fontSize: 27),
                  ),
                ),
              ));
  }
}

class ProfilePictureForOthers extends StatelessWidget {
  const ProfilePictureForOthers(
      {super.key, required this.photoUrl, required this.name});
  final String photoUrl;
  final String name;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: photoUrl != ""
            ? ClipOval(
                child: MainFunctions.pickedImage == null
                    ? CachedNetworkImage(
                        imageUrl: photoUrl,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        MainFunctions.pickedImage!,
                        fit: BoxFit.cover,
                      ))
            : ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  color: MainFunctions.generatePresizedColor(name.length),
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : "&",
                    style: const TextStyle(fontSize: 27),
                  ),
                ),
              ));
  }
}

class BookThumnail extends StatelessWidget {
  const BookThumnail({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: greyColor)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, child, loadingProgress) {
            return Center(
              child: CircularProgressIndicator(value: loadingProgress.progress),
            );
          },
        ),
      ),
    );
  }
}

// class ProfilePictureForOtherUsers extends StatelessWidget {
//   const ProfilePictureForOtherUsers({
//     super.key,
//     required this.userModel,
//   });
//   final UserModel userModel;
//   @override
//   Widget build(BuildContext context) {
//     print(userModel.photoUrl);
//     //  await CachedNetworkImage.evictFromCache(url);4
//     // ImageCache().clear();
//     return SizedBox(
//         height: 120,
//         width: 120,
//         child:
//             !(userModel.photoUrl == "$linkServerName/images/users/default.png")
//                 ? ClipOval(
//                     child: Image.network(
//                     linkServerName + userModel.photoUrl!.substring(21),
//                     fit: BoxFit.cover,
//                     headers: const {
//                       "Connection": "Keep-Alive",
//                       "Keep-Alive": "timeout=5, max=1000"
//                     },
//                     errorBuilder: (context, error, stackTrace) {
//                       return ClipOval(
//                         child: Container(
//                           alignment: Alignment.center,
//                           color: MainFunctions.generatePresizedColor(
//                               userModel.email!.length),
//                           child: Text(
//                             userModel.email![0].toUpperCase(),
//                             // style: const TextStyle(
//                             //     fontSize: 27, color: purpleTextColor),
//                           ),
//                         ),
//                       );
//                     },
//                   ))
//                 : ClipOval(
//                     child: Container(
//                         alignment: Alignment.center,
//                         color: MainFunctions.generatePresizedColor(
//                             userModel.username?.length ??
//                                 userModel.person!.lastName!.length +
//                                     userModel.person!.firstName!.length),
//                         child: Builder(
//                           builder: (context) {
//                             if (userModel.username == null) {
//                               return Text(
//                                 userModel.person!.firstName![0].toUpperCase(),
//                                 // style: const TextStyle(
//                                 //     fontSize: 27, color: purpleTextColor),
//                               );
//                             } else {
//                               return Text(
//                                 userModel.username![0].toUpperCase(),
//                                 // style: const TextStyle(
//                                 //     fontSize: 27, color: purpleTextColor),
//                               );
//                             }
//                           },
//                         )),
//                   ));
//   }
// }

class SmallBodyText extends StatelessWidget {
  final String text;

  const SmallBodyText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
        ),
      );
    } catch (e) {
      return const Text("");
    }
  }
}

class TitleSmallText extends StatelessWidget {
  final String text;

  const TitleSmallText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
      ),
    );
  }
}

class UserNameText extends StatelessWidget {
  final String text;

  const UserNameText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Theme.of(context).primaryColorLight.withAlpha(200),
        fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
      ),
    );
  }
}

class TitleMediumText extends StatelessWidget {
  final String text;

  const TitleMediumText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
      ),
    );
  }
}

class TitleLargeText extends StatelessWidget {
  final String text;

  const TitleLargeText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    super.key,
    this.trimLines = 2,
  }) : assert(text != null);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = orangeColor;
    final widgetColor = greyColor;
    TextSpan link = TextSpan(
        text: _readMore ? "... اقرأ المزيد" : " شاهد الأقل",
        style: TextStyle(
          color: colorClickableText,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int? endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(color: widgetColor, fontSize: 17),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
              text: widget.text,
              style: TextStyle(color: widgetColor, fontSize: 17));
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
