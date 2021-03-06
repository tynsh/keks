#!/bin/zsh

cd $(dirname $0)
cd ..

source ~/.rvm/scripts/rvm

rvm use 2.1.1
bundle install --without development --deployment --jobs 4

rvm use 1.9.3
bundle install --without development --deployment --jobs 4

rm -rf vendor/bundle/**/gems/nokogiri-*/ext/nokogiri/tmp
rm -rf vendor/bundle/**/gems/nokogiri-*/ports/*/libxml2/*/share/*doc
rm -rf vendor/bundle/**/gems/capybara-webkit-*/src/webkit_server.gch/c++
rm -rf vendor/bundle/**/gems/teaspoon-*/spec/dummy
rm -rf vendor/bundle/ruby/*/cache
tar cf pack_bundler.tar vendor/bundle
xz --verbose -9e pack_bundler.tar
rsync --partial --progress "./pack_bundler.tar.xz" vollmar-stefan:/srv/trap/share/bundler/keks.tar.xz
