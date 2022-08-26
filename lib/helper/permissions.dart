import 'logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getStoragePermission() async {
  return false;
}

// logPermissionStatus(Permission permissionGroup, PermissionStatus status) =>
//     Logger.w("${permissionGroup.toString()} status: ${status.toString()}");

Future<bool> getPermission(Permission permissionGroup) async {
  final bool permission = await [permissionGroup].request().then((status) async {
    if (status[permissionGroup] == PermissionStatus.granted) {
      // logPermissionStatus(permissionGroup, PermissionStatus.granted);
      return true;
    } else {
      // Just for android platform
      return await permissionGroup.shouldShowRequestRationale
          .then((isShown) async {
        if (!isShown) {
          // user has selected "Dont’ ask again" to grant the permission
          // settings must not be shown for the first time
          if (!await hasPermissionBeenAsked(permissionGroup)) {
            setPermissionHasBeenAsked(permissionGroup);
            return false;
          }
          return await openAppSettings()
              .then((isOpened) async {
            if (isOpened) {
              return await permissionGroup
                  .request()
                  .then((status) {
                if (status == PermissionStatus.granted) {
                  // logPermissionStatus(permissionGroup, status);
                  return true;
                }
                return false;
              });
            }
            return false;
          });
        }
        return false;
      });
    }
  });
  return permission;
}

Future<void> setPermissionHasBeenAsked(Permission permissionGroup) async {
  (await SharedPreferences.getInstance())
      .setBool('PERMISSION_ASKED_${permissionGroup.value}', true);
}

Future<bool> hasPermissionBeenAsked(Permission permissionGroup) async {
  return (await SharedPreferences.getInstance())
          .getBool('PERMISSION_ASKED_${permissionGroup.value}') ??
      false;
}
