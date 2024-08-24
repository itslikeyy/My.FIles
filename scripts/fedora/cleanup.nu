# cleans up system

print "Cleaning up dnf5 and dnf"
sudo dnf5 clean all
sudo dnf clean all

print "Cleaning up brew"
brew autoremove
brew cleanup

print "Done."
