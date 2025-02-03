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

    # cambridge
    IMAPAccount cambridge
    TLSType None
    AuthMechs Login
    Host localhost
    Port 1143
    UserCmd "${pkgs.coreutils}/bin/cat $HOME/tmp/bw/neomutt_cambridge_email"
    PassCmd "${pkgs.coreutils}/bin/cat $HOME/tmp/bw/neomutt_cambridge_password"

    IMAPStore cambridge-far
    Account cambridge

    MaildirStore cambridge-near
    Path ~/mail/cambridge/
    Inbox ~/mail/cambridge/INBOX/
    SubFolders Verbatim

    Channel cambridge
    Far :cambridge-far:
    Near :cambridge-near:
    Patterns *
    Expunge Both
    CopyArrivalDate yes
  '';
}
