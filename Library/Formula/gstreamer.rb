require 'formula'

class Gstreamer <Formula
  homepage 'http://gstreamer.freedesktop.org/'
  url 'http://gstreamer.freedesktop.org/src/gstreamer/gstreamer-0.10.30.tar.bz2'
  md5 'de01f73f71d97c5854badd363ca06509'

  depends_on 'pkg-config'
  depends_on 'gettext'
  depends_on 'glib'

  def install
    # Look for plugins in HOMEBREW_PREFIX/lib/gstreamer-0.10 instead of
    # HOMEBREW_PREFIX/Cellar/gstreamer/0.10/lib/gstreamer-0.10, so we'll find
    # plugins installed by other packages without setting GST_PLUGIN_PATH in
    # the environment.
    inreplace "configure", 'PLUGINDIR="$full_var"',
      "PLUGINDIR=\"#{HOMEBREW_PREFIX}/lib/gstreamer-0.10\""

    ENV.append "CFLAGS", "-funroll-loops -fstrict-aliasing -fno-common"
    system "./configure", "--prefix=#{prefix}", "--disable-debug",
      "--disable-dependency-tracking"
    system "make"
    system "make install"
  end
end
