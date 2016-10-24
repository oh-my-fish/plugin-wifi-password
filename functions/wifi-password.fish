function __wifi-password-linux
  set wifipath /etc/NetworkManager/system-connections/
  set current (nmcli -t -f ssid | head -1 | sed 's/.*to\s//')
  sudo grep -r '^psk=' $wifipath | grep $current | sed 's/.*psk=//'
end

function __wifi-password-macos
  set ssid (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ { print substr($0, index($0, $2))}')
  security find-generic-password -a 'AirPort network password' -wa $ssid
end

function wifi-password
  if test (uname) = 'Linux'
    __wifi-password-linux
  else
    __wifi-password-macos
  end
end
