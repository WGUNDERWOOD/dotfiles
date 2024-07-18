{
  config,
  pkgs,
  ...
}: {
  services.davmail.enable = true;
  services.davmail.url = https://outlook.office365.com/EWS/Exchange.asmx;
  services.davmail.config = {
      davmail.imapPort = 1443;
  }
}
