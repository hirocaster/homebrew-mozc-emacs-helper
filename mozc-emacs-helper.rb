require "formula"

class MozcEmacsHelper < Formula
  homepage "http://hiroki.jp/homebrew-mozc-emacs-helper"
  url "https://gist.github.com/cef707ac0b23b82f399a.git"
  version "0.0.1"

  def install

    # system "svn co https://src.chromium.org/svn/trunk/tools/depot_tools"
    # system "./depot_tools/gclient config http://mozc.googlecode.com/svn/trunk/src"
    # system "./depot_tools/gclient sync"
    # system "patch src/build_mozc.py < build_mozc.py.patch"
    # system "python src/build_mozc.py gyp --noqt"
    # system "python src/build_mozc.py build -c Release src/mac/mac.gyp:GoogleJapaneseInput src/mac/mac.gyp:gen_launchd_confs src/unix/emacs/emacs.gyp:mozc_emacs_helper"

    system "pwd"
    system "cp -r /Users/yusuke/mozc ."
    # system "git clone https://github.com/google/mozc.git -b 2018-02-26 --single-branch --recursive"
    Dir.chdir "mozc" do
      system "pwd"
      system 'cp /Users/yusuke/mozc_emacs_helper.patch .'
      system "ls -l"
      system "cat mozc_emacs_helper.patch"
      system "patch -p1 < mozc_emacs_helper.patch"
    end

    Dir.chdir "mozc/src" do
      system "pwd"
      system "ls -l"
      system "echo $0"
      system "zsh -c 'echo $0'"
      # system "zsh -c \"GYP_DEFINES='mac_sdk=11.3 mac_deployment_target=11.4' python2 build_mozc.py gyp --noqt --branding=GoogleJapaneseInput; python2 build_mozc.py build -c Release unix/emacs/emacs.gyp:mozc_emacs_helper\" "
      system "GYP_DEFINES='mac_sdk=11.3 mac_deployment_target=11.4' python2 build_mozc.py gyp --noqt --branding=GoogleJapaneseInput"
      system "zsh -c 'python2 build_mozc.py build -c Release unix/emacs/emacs.gyp:mozc_emacs_helper'"
    end
    # install


    bin.install 'src/out_mac/Release/mozc_emacs_helper'

    # system 'sudo cp -r src/out_mac/Release/Mozc.app /Library/Input\ Methods/'
    # system 'sudo cp src/out_mac/DerivedSources/Release/mac/org.mozc.inputmethod.Japanese.Converter.plist /Library/LaunchAgents'
    # system 'sudo cp src/out_mac/DerivedSources/Release/mac/org.mozc.inputmethod.Japanese.Renderer.plist /Library/LaunchAgents'
    system 'pwd'
    system 'date'
    system "cp ./mozc/src/out_mac/Release/mozc_emacs_helper /usr/local/bin"
  end

  def caveats
    msg = <<-EOF.undent
Please restart your operating system.
EOF
  end
end
