# Waybar Configuration

[Waybar](https://github.com/Alexays/Waybar) configuration with Omarchy.

## 802.1x Configuration

Adapted from [NetworkManager setup guide](https://github.com/Zeus-Deus/omarchy-setup/blob/main/NetworkManager/README.md),
change Omarchy's default Waybar to use `nm-applet` instead of Impala by setting
`"network"` &rarr; `"on-click"` to `"nm-applet --indicator"`.
