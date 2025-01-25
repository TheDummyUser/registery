{
  pkgs,
  ...
}:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
    bun
    nodejs
    yarn
  ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;
  languages = {
    go.enable = true;
    javascript.enable = true;
    typescript.enable = true;
  };
  # https://devenv.sh/processes/
  processes.cargo-watch.exec = "cargo-watch";

  android = {
    enable = true;
    reactNative.enable = true;
    platforms.version = [ "35" ];
    systemImageTypes = [ "google_apis_playstore" ];
    abis = [
      "arm64-v8a"
      "x86_64"
    ];
    platformTools.version = "35.0.2";
    buildTools.version = [
      "34.0.0"
      "35.0.0"
    ];
    emulator = {
      enable = true;
      version = "35.2.5";
    };
    sources.enable = false;
    systemImages.enable = true;
    ndk.enable = true;
    googleAPIs.enable = true;
    googleTVAddOns.enable = true;
    extras = [ "extras;google;gcm" ];
    extraLicenses = [
      "android-sdk-preview-license"
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
    # android-studio = pkgs.android-studio;
  };

  # https://devenv.sh/services/
  # services.postgres.enable = true;
  services.mysql = {
    enable = true;
    initialDatabases = [
      {
        name = "testdb";
        schema = ./server/db/schema.sql;
      }
    ];
    ensureUsers = [
      {
        name = "root";
        ensurePermissions = {
          "justadb.*" = "ALL PRIVILEGES";
        };
      }
      {
        name = "backup";
        ensurePermissions = {
          "*.*" = "SELECT, LOCK TABLES";
        };
      }
    ];
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
