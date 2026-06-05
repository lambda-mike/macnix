#!/usr/bin/env nix-shell
#! nix-shell -i perl -p perl

use strict;
use warnings;

print 'Start';

open(my $fh, '<', 'flake.nix') or die "Could not open file to read: $!";
my @lines = <$fh>;
close($fh);

open($fh, '>', 'flake.nix') or die "Could not open file to write: $!";
foreach (@lines) {
  s/^(\s*)loginwindowText = builtins\.abort.*$/${1}loginwindowText = "login-mock";/;
  s/^(\s*)hostname = builtins\.abort.*$/${1}hostname = "ci-host";/;
  s/^(\s*)user = builtins\.abort.*$/${1}user = "test";/;
  s/^(\s*)windowManager = builtins\.abort.*$/${1}windowManager = "leftwm";/;
  s/^(\s*)stateVersion = builtins\.abort.*$/${1}stateVersion = "25.05";/;
  print $fh $_;
}
close($fh);

# configuration
open($fh, '<', 'sage_configuration.nix') or die "Could not open file to read: $!";
@lines = <$fh>;
close($fh);
open($fh, '>', 'sage_configuration.nix') or die "Could not open file to write: $!";
foreach (@lines) {
  s/^(\s*)# CIFIXME_TEST.*$/${1}users.users.test.isNormalUser = true;/;
  print $fh $_;
}
close($fh);

# Open the file for writing
open($fh, '>', 'hardware-configuration.nix') or die "Could not open file: $!";
print $fh '{ ... }: {  fileSystems = { "/" = { device = "/dev/fake1"; fsType = "btrfs"; }; "/nix" = { device = "/dev/fake1"; fsType = "btrfs"; }; "/home" = { device = "/dev/fake1"; fsType = "btrfs"; }; "/data" = { device = "/dev/fake1"; fsType = "btrfs"; }; "/snapshots" = { device = "/dev/fake1"; fsType = "btrfs"; }; "/swap" = { device = "/dev/fake1"; fsType = "btrfs"; }; }; }' . "\n";
close($fh);
! system 'git add hardware-configuration.nix' or die 'git add hardware-configuration.nix failed';

open($fh, '>', 'keys.nix') or die "Could not open file: $!";
print $fh '[]' . "\n";
close($fh);
! system 'git add keys.nix' or die 'git add keys.nix failed!';

print 'Done';
