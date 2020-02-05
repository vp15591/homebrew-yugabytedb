class YugabytedbAT2090 < Formula
  desc "High-performance distributed SQL database Yugabyte DB"
  homepage "https://yugabyte.com"
  url "https://downloads.yugabyte.com/yugabyte-2.0.9.0-darwin.tar.gz"
  sha256 "7d5da3fec65309bb4f2369a9c393994b718fed664aeb2d911acd7a83ba218dea"

  conflicts_with "yugabytedb", :because => "yugabyte also ships latest similar binarys"
  depends_on :java => "1.8"
  depends_on "python"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/yugabyted"
    bin.install_symlink libexec/"postgres/bin/ysqlsh"
    bin.install_symlink libexec/"bin/cqlsh"
  end

  def post_install
    (var/"yugabyte_data").mkpath
    (prefix/"logs").mkpath
    (var/"log/yugabyte").mkpath
    if !(File.exist?((etc/"yugabyted.conf"))) then
      (etc/"yugabyted.conf").write yugabyte_conf
    end
  end

  def yugabyte_conf; <<~EOS
    {
    "tserver_webserver_port": 9000, 
    "master_rpc_port": 7100, 
    "webserver_port": 7200, 
    "master_webserver_port": 7000, 
    "bind_ip": "127.0.0.1", 
    "ycql_port": 9042, 
    "data_dir": "#{var}/yugabyte_data", 
    "ysql_port": 5433, 
    "log_dir": "#{var}/log/yugabyte", 
    "polling_interval": "5", 
    "tserver_rpc_port": 9100
    }
  EOS
  end

  def caveats; <<~EOS
    Use yugabyted status to check the status of the database.
    Use ysqlsh to drop into an SQL shell to interact with the database
    If you are upgrading Yugabyte version to newer version, Please restart Yugabyte service.
    `brew services restart yugabytedb`
  EOS
  end

  plist_options :startup => true
  plist_options :manual => "yugabyted start --config #{HOMEBREW_PREFIX}/etc/yugabyted.conf"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/yugabyted</string>
        <string>start</string>
        <string>--config</string>
        <string>#{etc}/yugabyted.conf</string>
        <string>--daemon</string>
        <string>false</string>
      </array>
      <key>KeepAlive</key>
      <dict>
        <key>SuccessfulExit</key>
        <false/>
      </dict>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{HOMEBREW_PREFIX}</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/yugabyte/yugabyted-service.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/yugabyte/yugabyted-service.log</string>
      <key>HardResourceLimits</key>
      <dict>
        <key>NumberOfFiles</key>
        <integer>262144</integer>
      </dict>
      <key>SoftResourceLimits</key>
      <dict>
        <key>NumberOfFiles</key>
        <integer>262144</integer>
      </dict>
    </dict>
    </plist>
  EOS
  end

  test do
    system "#{libexec}/bin/yugabyted", "version", "--config", "#{HOMEBREW_PREFIX}/etc/yugabyted.conf"
  end
end
