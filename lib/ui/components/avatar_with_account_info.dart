import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../helper/app_color.dart';
import '../../helper/dim.dart';


class AvatarWithAccountInfo extends StatelessWidget {
  final String? avatarUrl;
  final String? name;
  final String? emailAddress;
  final Function()? onAvatarPressed;

  AvatarWithAccountInfo(
      {this.avatarUrl,
      this.name,
      this.emailAddress, this.onAvatarPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: 72.0,
              maxWidth: 72.0,
              minWidth: 64.0,
              minHeight: 64.0),
          child: Hero(
            tag: 'avatar_tag',
            child: Material(
              elevation: 0,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              child: avatarUrl != null ?
                InkWell(
                    onTap: onAvatarPressed,
                    child: CachedNetworkImage(
                      imageUrl: avatarUrl ?? "",
                      placeholder: (context, url) => CircularProgressIndicator(),
                      width: double.maxFinite,
                      height: double.maxFinite,
                      placeholderFadeInDuration: Duration(milliseconds: 150),
                      fit: BoxFit.cover,

                    ),
                  ):Container(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: Text(
                name ?? "",
              style: TextStyle(color: AppColor.whiteColor,fontSize:Dim.fontSize16),
              overflow:  TextOverflow.ellipsis
            ),
          ),
        ),
        Center(
          child: Text(
            emailAddress ?? "",
            style:  TextStyle(color: AppColor.whiteColor,fontSize:Dim.fontSize12),
            overflow:  TextOverflow.ellipsis
          ),
        ),
      ],
    );
  }
}
