export LANG=ru_RU.utf8
export LC_ALL=ru_RU.utf8

export QT_STYLE_OVERRIDE=gtk
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

setxkbmap "us,ru" ",winkeys" "grp:caps_toggle,grp_led:caps"

xset b off

twmnd &
gxkb &
compton -b &
nm-applet &
devmon &

exec i3