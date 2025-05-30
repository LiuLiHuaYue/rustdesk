sed -i -e 's|Homepage: https://rustdesk.com|Homepage: www.baidu.com|' ./build.py
sed -i -e "s|launchUrl(Uri.parse('https://rustdesk.com'));|launchUrl(Uri.parse('www.baidu.com'));|" ./flutter/lib/common.dart
sed -i -e "s|launchUrlString('https://rustdesk.com');|launchUrlString('www.baidu.com');|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('www.baidu.com/privacy.html')|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
sed -i -e "s|const url = 'https://rustdesk.com/';|const url = 'www.baidu.com';|" ./flutter/lib/mobile/pages/settings_page.dart
sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('www.baidu.com/privacy.html')|" ./flutter/lib/mobile/pages/settings_page.dart
sed -i -e "s|https://rustdesk.com/privacy.html|www.baidu.com/privacy.html|" ./flutter/lib/desktop/pages/install_page.dart
sed -i -e "s|https://rustdesk.com/|www.baidu.com.urlLink }}|" ./res/setup.nsi