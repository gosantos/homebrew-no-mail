cask "no-mail" do
  version "1.0.0"
  sha256 "8c03db66994e49033a99b2da63cf53d75955dba2154bf1babf7e6c27573b7d92"

  url "https://github.com/gosantos/no-mail/releases/download/v#{version}/noMail-#{version}.zip"
  name "noMail"
  desc "Prevents Apple Mail from launching"
  homepage "https://github.com/gosantos/no-mail"

  auto_updates false
  depends_on macos: :big_sur

  app "noMail.app"

  # The app is ad-hoc signed (not notarized with a paid Apple Developer ID),
  # so macOS would otherwise quarantine it and refuse to open it. Strip the
  # quarantine flag on install so it launches without the Gatekeeper prompt.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/noMail.app"]
  end

  uninstall quit: "com.nomail.NoMail"

  zap trash: "~/Library/Preferences/com.nomail.NoMail.plist"
end
