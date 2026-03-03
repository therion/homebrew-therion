class Therion < Formula
  desc "Processes survey data and generates maps or 3D models of caves"
  homepage "https://therion.speleo.sk"
  url "https://github.com/therion/therion/archive/v6.3.4.tar.gz"
  sha256 "e678a539aeab436465556e769fa9ecbc51b2944f8969a34b29cc3fdc6d78765a"
  version "6.3.4"
  revision 1
  head "https://github.com/therion/therion.git"

  depends_on "cmake" => :build
  depends_on "catch2" => :build
  depends_on "fmt" => :build
  depends_on "freetype"
  depends_on "ghostscript"
  depends_on "imagemagick"
  depends_on "lcdf-typetools"
  depends_on "libjpeg"
  depends_on "libpng"
  depends_on "pkg-config"
  depends_on "proj"
  depends_on "tcl-tk"
  depends_on "bwidget"
  depends_on "vtk"
  depends_on "wxwidgets"
  depends_on "zlib"

  def install
    ENV.prepend_path "PATH", "/Library/TeX/texbin"

    inreplace "loch/CMakeLists.txt" do |s|
      s.gsub! "/Applications", prefix
    end

    inreplace "loch/help/CMakeLists.txt" do |s|
      s.gsub!(
        'COMMAND ${CMAKE_COMMAND} -E tar cfv loch.htb --format=zip loch.hhp loch.hhc
                loch.hhk loch.htm',
        'COMMAND /usr/bin/zip -X -r loch.htb loch.hhp loch.hhc loch.hhk loch.htm'
      )
    end

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  def caveats
    "Copy Loch.app to your /Applications folder: cp -R #{prefix}/loch.app/ /Applications/loch.app"
  end

  test do
    system "#{bin}/therion", "--version"
  end
end
