# Arch Cookbook

This is the source code for the Arch Cookbook contents. It uses Pro Git's tools
to make ebooks.It is licensed underthe Creative Commons Attribution-Non 
Commercial-Share Alike 3.0 license.

## Making PDF

```
sudo apt-get install pandoc texlive texlive-exetex mercurial
./update.rb
./makepdfs en
```

## Making mbed wiki
mbed wiki is a custom version of creole wiki

```
sudo gem install redcarpet
./makewiki.rb
```

## Writing

