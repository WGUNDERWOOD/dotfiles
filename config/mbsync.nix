{pkgs, ...}: {
  programs.mbsync.enable = true;
  programs.mbsync.extraConfig = ''
    # general settings
    Create Near
    SyncState *

    # gmail
    IMAPAccount gmail
    TLSType IMAPS
    Host imap.gmail.com
    UserCmd "${pkgs.coreutils}/bin/cat $HOME/tmp/bw/neomutt_gmail_email"
    PassCmd "${pkgs.coreutils}/bin/cat $HOME/tmp/bw/neomutt_gmail_password"

    IMAPStore gmail-far
    Account gmail

    MaildirStore gmail-near
    Path ~/mail/gmail/
    Inbox ~/mail/gmail/INBOX/
    SubFolders Verbatim

    Channel gmail
    Far :gmail-far:
    Near :gmail-near:
    Patterns * !"[Gmail]/All Mail" !"[Gmail]/Important" !"[Gmail]/Starred"
    Expunge Both
    CopyArrivalDate yes
  '';
}
