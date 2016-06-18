require "formula"

class MozcEmacsHelper < Formula
  homepage "http://hiroki.jp/homebrew-mozc-emacs-helper"
  url "https://gist.github.com/cef707ac0b23b82f399a.git"
  version "0.0.1"

  def install
    system "svn co https://src.chromium.org/svn/trunk/tools/depot_tools"
    system "./depot_tools/gclient config http://mozc.googlecode.com/svn/trunk/src"
    system "./depot_tools/gclient sync"
    system "patch src/build_mozc.py < build_mozc.py.patch"
    system "python src/build_mozc.py gyp --noqt"
    system "python src/build_mozc.py build -c Release src/mac/mac.gyp:GoogleJapaneseInput src/mac/mac.gyp:gen_launchd_confs src/unix/emacs/emacs.gyp:mozc_emacs_helper"

    bin.install 'src/out_mac/Release/mozc_emacs_helper'
    system 'sudo cp -r src/out_mac/Release/Mozc.app /Library/Input\ Methods/'
    system 'sudo cp src/out_mac/DerivedSources/Release/mac/org.mozc.inputmethod.Japanese.Converter.plist /Library/LaunchAgents'
    system 'sudo cp src/out_mac/DerivedSources/Release/mac/org.mozc.inputmethod.Japanese.Renderer.plist /Library/LaunchAgents'
  end

  def caveats
    msg = <<-EOF.undent
Please restart your operating system.
EOF
  end
end
