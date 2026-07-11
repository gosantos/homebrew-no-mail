cask "no-mail" do
  version "1.0.2"
  sha256 "d77e28c969e8a37ee10984107d1b54d88a2ee647283a9f9ee85552449ccacc10"

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
