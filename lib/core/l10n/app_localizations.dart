import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [
    Locale('vi'),
    Locale('en'),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static String _lang(Locale locale) => locale.languageCode.toLowerCase();

  String get appTitle => _text('appTitle');
  String get loginTitle => _text('loginTitle');
  String get loginSubtitle => _text('loginSubtitle');
  String get accountTitle => _text('accountTitle');
  String get emailLabel => _text('emailLabel');
  String get passwordLabel => _text('passwordLabel');
  String get forgotPassword => _text('forgotPassword');
  String get signIn => _text('signIn');
  String get trustNote => _text('trustNote');
  String get welcomeBack => _text('welcomeBack');
  String get homeTitle => _text('homeTitle');
  String get homeSubtitle => _text('homeSubtitle');
  String get statusIdle => _text('statusIdle');
  String get statusBusy => _text('statusBusy');
  String get settingsTitle => _text('settingsTitle');
  String get notificationsSection => _text('notificationsSection');
  String get notificationToggle => _text('notificationToggle');
  String get notificationSubtitle => _text('notificationSubtitle');
  String get soundToggle => _text('soundToggle');
  String get soundSubtitle => _text('soundSubtitle');
  String get dataSection => _text('dataSection');
  String get autoUploadToggle => _text('autoUploadToggle');
  String get autoUploadSubtitle => _text('autoUploadSubtitle');
  String get accountSection => _text('accountSection');
  String get editProfile => _text('editProfile');
  String get signOut => _text('signOut');
  String get validationEmailRequired => _text('validationEmailRequired');
  String get validationEmailInvalid => _text('validationEmailInvalid');
  String get validationPasswordRequired => _text('validationPasswordRequired');
  String get validationPasswordLength => _text('validationPasswordLength');
  String get invalidCredentials => _text('invalidCredentials');

  String _text(String key) {
    final lang = _lang(locale);
    final map = _localizedValues[lang] ?? _localizedValues['en']!;
    return map[key] ?? _localizedValues['en']![key] ?? key;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'vi': {
      'appTitle': 'Nhận diện khuôn mặt',
      'loginTitle': 'Chào mừng trở lại',
      'loginSubtitle':
          'Đăng nhập để bắt đầu nhận diện khuôn mặt với độ chính xác cao.',
      'accountTitle': 'Tài khoản',
      'emailLabel': 'Email',
      'passwordLabel': 'Mật khẩu',
      'forgotPassword': 'Quên mật khẩu?',
      'signIn': 'Đăng nhập',
      'trustNote':
          'Hệ thống bảo vệ dữ liệu khuôn mặt và mã hóa toàn bộ ảnh tải lên.',
      'welcomeBack': 'Xin chào!',
      'homeTitle': 'Nhận diện khuôn mặt',
      'homeSubtitle': 'Sẵn sàng nhận diện khuôn mặt chỉ với một lần chụp.',
      'statusIdle': 'Chưa có ảnh nào được gửi.',
      'statusBusy': 'Đang xử lý ảnh, vui lòng chờ...',
      'settingsTitle': 'Cài đặt',
      'notificationsSection': 'Thông báo',
      'notificationToggle': 'Nhận thông báo nhận diện',
      'notificationSubtitle': 'Cập nhật ngay khi kết quả sẵn sàng.',
      'soundToggle': 'Âm báo',
      'soundSubtitle': 'Phát âm thanh khi chụp ảnh.',
      'dataSection': 'Dữ liệu',
      'autoUploadToggle': 'Tự động tải ảnh',
      'autoUploadSubtitle': 'Tự gửi ảnh ngay sau khi chụp.',
      'accountSection': 'Tài khoản',
      'editProfile': 'Chỉnh sửa',
      'signOut': 'Đăng xuất',
      'validationEmailRequired': 'Vui lòng nhập email.',
      'validationEmailInvalid': 'Email không hợp lệ.',
      'validationPasswordRequired': 'Vui lòng nhập mật khẩu.',
      'validationPasswordLength': 'Mật khẩu cần ít nhất 6 ký tự.',
      'invalidCredentials': 'Tài khoản hoặc mật khẩu không đúng.',
    },
    'en': {
      'appTitle': 'Face Recognition',
      'loginTitle': 'Welcome back',
      'loginSubtitle':
          'Sign in to start face recognition with high accuracy.',
      'accountTitle': 'Account',
      'emailLabel': 'Email',
      'passwordLabel': 'Password',
      'forgotPassword': 'Forgot password?',
      'signIn': 'Sign in',
      'trustNote':
          'Your face data is protected and every upload is fully encrypted.',
      'welcomeBack': 'Hello!',
      'homeTitle': 'Face Recognition',
      'homeSubtitle': 'Ready to recognize faces with a single capture.',
      'statusIdle': 'No image has been sent yet.',
      'statusBusy': 'Processing image, please wait...',
      'settingsTitle': 'Settings',
      'notificationsSection': 'Notifications',
      'notificationToggle': 'Recognition alerts',
      'notificationSubtitle': 'Get updates as soon as results are ready.',
      'soundToggle': 'Sound',
      'soundSubtitle': 'Play a sound when capturing.',
      'dataSection': 'Data',
      'autoUploadToggle': 'Auto upload photos',
      'autoUploadSubtitle': 'Send photos right after capture.',
      'accountSection': 'Account',
      'editProfile': 'Edit',
      'signOut': 'Sign out',
      'validationEmailRequired': 'Please enter your email.',
      'validationEmailInvalid': 'Email is invalid.',
      'validationPasswordRequired': 'Please enter your password.',
      'validationPasswordLength': 'Password must be at least 6 characters.',
      'invalidCredentials': 'Invalid username or password.',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .any((supported) => supported.languageCode == locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    Intl.defaultLocale = locale.toLanguageTag();
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

