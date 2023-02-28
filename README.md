# agl-flutter-monitor
AGL Flutter Application for monitoring and manipulating CAN Traffic and VSS Information

Based on AGL Flutter HVAC App
https://gerrit.automotivelinux.org/gerrit/admin/repos/apps/html5-hvac,general


For AGL Deployment:
- monitor_config.yaml needs to be located at 
    /etc/xdg/AGL/monitor_config.yaml
- update path in /lib/config.dart to 
    String configFilePath = '/etc/xdg/AGL/MONITOR_config.yaml';

For development purposes only:
- open VSS Port on AGL Image
    root@raspberrypi4-64:/bin# iptables -A INPUT -p tcp --dport 8090 -j ACCEPT
    root@raspberrypi4-64:/bin# iptables -A OUTPUT -p tcp --dport 8090 -j ACCEPT

> flutter build bundle


Building the App:
> flutter create --platform {YOUR-PLATFORM} .
> flutter build {YOUR-PLATFORM}
> flutter run
