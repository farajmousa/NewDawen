// import "package:flutter/foundation.dart";
// import "package:flutter/material.dart";
// import "package:intl/intl.dart";
//
// configureLogger() {
//   if (!kReleaseMode) Logger.addClient(DebugLoggerClient());
// }
//
// testsLogger() {
//   Logger.addClient(DebugLoggerClient());
// }
//
// class Logger {
//   static final _clients = <LoggerClient>[];
//
//   /// Debug level logs
//   static d(
//     String message, {
//     dynamic e,
//     StackTrace? s,
//   }) {
//     _clients.forEach((c) => c.onLog(
//           level: LogLevel.debug,
//           message: message,
//           e: e,
//           s: s,
//         ));
//   }
//
//   static w(
//     String message, {
//     dynamic e,
//     StackTrace? s,
//   }) {
//     _clients.forEach((c) => c.onLog(
//           level: LogLevel.warning,
//           message: message,
//           e: e,
//           s: s,
//         ));
//   }
//
//   static e(
//     String message, {
//     dynamic e,
//     required StackTrace s,
//   }) {
//     _clients.forEach((c) => c.onLog(
//           level: LogLevel.error,
//           message: message,
//           e: e,
//           s: s,
//         ));
//   }
//
//   static addClient(LoggerClient client) {
//     _clients.add(client);
//   }
// }
//
// enum LogLevel { debug, warning, error }
//
// abstract class LoggerClient {
//   onLog({
//     LogLevel level,
//     String message,
//     dynamic e,
//     StackTrace? s,
//   });
// }
//
// /// Debug logger that just prints to console
// class DebugLoggerClient implements LoggerClient {
//   static final dateFormat = DateFormat("HH:mm:ss.SSS");
//
//   String _timestamp() {
//     return dateFormat.format(DateTime.now());
//   }
//
//   @override
//   onLog({
//     LogLevel level = LogLevel.debug,
//     String? message,
//     dynamic e,
//     StackTrace? s ,
//   }) {
//     switch (level) {
//       case LogLevel.debug:
//         debugPrint("${_timestamp()} [DEBUG]  $message");
//         if (e != null) {
//           debugPrint(e.toString());
//           debugPrint(s.toString()); // ?? StackTrace.current
//         }
//         break;
//       case LogLevel.warning:
//         debugPrint("${_timestamp()} [WARNING]  $message");
//         if (e != null) {
//           debugPrint(e.toString());
//           debugPrint(s.toString() ); //?? StackTrace.current.toString()
//         }
//         break;
//       case LogLevel.error:
//         debugPrint("${_timestamp()} [ERROR]  $message");
//         if (e != null) {
//           debugPrint(e.toString());
//         }
//         // Errors always show a StackTrace
//         debugPrint(s.toString() ); //?? StackTrace.current.toString()
//         break;
//     }
//   }
// }
