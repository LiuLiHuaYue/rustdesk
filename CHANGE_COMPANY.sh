sed -i -e 's|Purslane Ltd|K|' ./flutter/lib/desktop/pages/desktop_setting_page.dart
sed -i -e 's|Purslane Ltd.|K|' ./res/setup.nsi
sed -i -e 's|PURSLANE|K|' ./res/msi/preprocess.py
sed -i -e 's|Purslane Ltd|K|' ./res/msi/preprocess.py
sed -i -e 's|"Copyright © 2025 Purslane Ltd. All rights reserved."|"Copyright © 2025 K. All rights reserved."|' ./flutter/windows/runner/Runner.rc
sed -i -e 's|Purslane Ltd|K|' ./flutter/windows/runner/Runner.rc
sed -i -e 's|Purslane Ltd|K|' ./Cargo.toml
sed -i -e 's|Purslane Ltd|K|' ./libs/portable/Cargo.toml