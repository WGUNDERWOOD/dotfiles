{pkgs, ...}: {
  home.file.".config/davmail/davmail_static.conf".text = ''
    # davmail settings
    davmail.url=https://outlook.office365.com/EWS/Exchange.asmx
    davmail.mode=O365Interactive
    davmail.server=true
    davmail.enableKeepAlive=true
    davmail.allowRemote=false
    davmail.smtpSaveInSent=true
    davmail.imapAutoExpunge=true
    davmail.imapIdleDelay=
    davmail.imapAlwaysApproxMsgSize=

    # logging
    log4j.logger.davmail=WARN
    log4j.logger.httpclient.wire=WARN
    log4j.logger.org.apache.commons.httpclient=WARN
    log4j.logger.org.apache.http.wire=WARN
    log4j.rootLogger=WARN
    log4j.logger.org.apache.http.conn.ssl=WARN

    # ports
    davmail.caldavPort=1080
    davmail.imapPort=1143
    davmail.ldapPort=1389
    davmail.popPort=1110
    davmail.smtpPort=1025

    # security
    davmail.ssl.nosecureimap=false
    davmail.ssl.nosecureldap=false
    davmail.ssl.nosecurecaldav=false
    davmail.ssl.nosecuresmtp=false
    davmail.ssl.nosecurepop=false

    # oauth key (leave as bottom line)
  '';
}
