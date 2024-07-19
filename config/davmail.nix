{pkgs, ...}: {
  home.file.".config/davmail/davmail.conf".text = ''
    ######################
    # Logging Settings
    ######################
    # Logging information while running and output to /var/log/davmail.log
    # Set to warn but feel free to update this to DEBUG if you are facing some issues
    log4j.logger.davmail=WARN
    log4j.logger.httpclient.wire=WARN
    log4j.logger.org.apache.commons.httpclient=WARN
    log4j.rootLogger=WARN

    ######################
    # Connection Settings
    ######################
    # Base exchange URL
    davmail.url=https://outlook.office365.com/EWS/Exchange.asmx

    # This exchange method was the only that worked with my institution
    davmail.mode=O365Interactive

    # We want to run as a server not workstation
    davmail.server=true

    ######################
    # Port Settings
    ######################
    # Setup ports, make sure these are not being used by another process
    davmail.caldavPort=1080
    davmail.imapPort=1143
    davmail.ldapPort=1389
    davmail.popPort=1110
    davmail.smtpPort=1025


    ######################
    # Network Settings
    ######################
    # We need to disable SSL to get this working
    davmail.ssl.nosecureimap=false
    davmail.ssl.nosecureldap=false
    davmail.ssl.nosecurecaldav=false
    davmail.ssl.nosecuresmtp=false
    davmail.ssl.nosecurepop=false

    # We want to keep this alive for large file and message downloads so it doesn't timeout
    davmail.enableKeepAlive=true



    # We don't need remote connections to DavMail, this may change depending on your setup, if you are running this externally.
    davmail.allowRemote=false

    ######################
    # SMTP Settings
    ######################
    # let Exchange save a copy of sent messages in Sent folder
    davmail.smtpSaveInSent=true


    ######################
    # IMAP Settings
    ######################
    # Delete messages immediately on IMAP STORE \Deleted flag
    davmail.imapAutoExpunge=true
    # To enable IDLE support, set a maximum client polling delay in minutes
    # Clients using IDLE should poll more frequently than this delay
    davmail.imapIdleDelay=
    # Always reply to IMAP RFC822.SIZE requests with Exchange approximate message size for performance reasons
    davmail.imapAlwaysApproxMsgSize=


    ######################
    # POP settings
    ######################
    # Delete messages on server after 30 days
    davmail.keepDelay=30
    # Delete messages in server sent folder after 90 days
    davmail.sentKeepDelay=90
    # Mark retrieved messages read on server
    davmail.popMarkReadOnRetr=false
  '';
}
