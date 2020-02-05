class YugabytedbClientAT2090 < Formula
  desc "High-performance distributed SQL database Yugabyte DB"
  homepage "https://yugabyte.com"
  url "https://downloads.yugabyte.com/yugabyte-2.0.9.0-darwin.tar.gz"
  sha256 "7d5da3fec65309bb4f2369a9c393994b718fed664aeb2d911acd7a83ba218dea" 

  conflicts_with "yugabytedb-client", :because => "yugabyte-client also ships latest similar binarys"
  depends_on :java => "1.8"
  depends_on "python"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"postgres/bin/ysqlsh"
    bin.install_symlink libexec/"bin/cqlsh"
  end
  
  test do
    system "#{libexec}/bin/ysqlsh", "--help"
  end
end
