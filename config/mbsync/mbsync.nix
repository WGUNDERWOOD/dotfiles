{pkgs, ...}: {
    programs.mbsync = {
        enable = true;
        extraConfig =
            ''
            # general settings
            Create Near
            SyncState *

            # gmail
            IMAPAccount gmail
            SSLType IMAPS
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
            Expunge None
            CopyArrivalDate yes

            # gmail
            IMAPAccount princeton
            SSLType IMAPS
            Host imap.gmail.com
            UserCmd "${pkgs.coreutils}/bin/cat $HOME/tmp/bw/neomutt_princeton_email"
            PassCmd "${pkgs.coreutils}/bin/cat $HOME/tmp/bw/neomutt_princeton_password"

            IMAPStore princeton-far
            Account princeton

            MaildirStore princeton-near
            Path ~/mail/princeton/
            Inbox ~/mail/princeton/INBOX/
            SubFolders Verbatim

            Channel princeton
            Far :princeton-far:
            Near :princeton-near:
            Patterns * !"[Gmail]/All Mail" !"[Gmail]/Important" !"[Gmail]/Starred"
            Expunge None
            CopyArrivalDate yes
            '';
    };
}
