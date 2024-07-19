{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "davmail-oauth";
  runtimeInputs = with pkgs; [coreutils gnugrep];
  text = ''
    STATIC_FILE="/home/will/.config/davmail/davmail_static.conf"
    STATIC_TEXT="$(cat $STATIC_FILE)"
    CONF_FILE="/home/will/.config/davmail/davmail.conf"
    touch $CONF_FILE

    AUTH_PATTERN="davmail.oauth.*.refreshToken"
    if grep -q "$AUTH_PATTERN" "$CONF_FILE"; then
        AUTH_TEXT="$(grep "$AUTH_PATTERN" "$CONF_FILE")"
    else
        AUTH_TEXT=""
    fi

    NEW_CONF_TEXT="$STATIC_TEXT\n$AUTH_TEXT"
    echo -e "$NEW_CONF_TEXT" > $CONF_FILE
  '';
}
