{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "davmail-oauth";
  runtimeInputs = with pkgs; [coreutils gnugrep];
  text = ''
    STATIC_FILE="/home/will/.config/davmail/davmail_static.conf"
    STATIC_TEXT="$(cat $STATIC_FILE)"
    CONF_FILE_CAMBRIDGE="/home/will/.config/davmail/davmail_cambridge.conf"
    CONF_FILE_WARWICK="/home/will/.config/davmail/davmail_warwick.conf"
    touch $CONF_FILE_CAMBRIDGE $CONF_FILE_WARWICK

    AUTH_PATTERN_CAMBRIDGE="davmail.oauth.*@cam.ac.uk.refreshToken"
    if grep -q "$AUTH_PATTERN_CAMBRIDGE" "$CONF_FILE_CAMBRIDGE"; then
        AUTH_TEXT_CAMBRIDGE="$(grep "$AUTH_PATTERN_CAMBRIDGE" "$CONF_FILE_CAMBRIDGE")"
    else
        AUTH_TEXT_CAMBRIDGE=""
    fi

    AUTH_PATTERN_WARWICK="davmail.oauth.*@live.warwick.ac.uk.refreshToken"
    if grep -q "$AUTH_PATTERN_WARWICK" "$CONF_FILE_WARWICK"; then
        AUTH_TEXT_WARWICK="$(grep "$AUTH_PATTERN_WARWICK" "$CONF_FILE_WARWICK")"
    else
        AUTH_TEXT_WARWICK=""
    fi

    NEW_CONF_TEXT_CAMBRIDGE="$STATIC_TEXT\n$AUTH_TEXT_CAMBRIDGE"
    echo -e "$NEW_CONF_TEXT_CAMBRIDGE" > $CONF_FILE_CAMBRIDGE
    NEW_CONF_TEXT_WARWICK="$STATIC_TEXT\n$AUTH_TEXT_WARWICK"
    echo -e "$NEW_CONF_TEXT_WARWICK" > $CONF_FILE_WARWICK
  '';
}
