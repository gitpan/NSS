#!/usr/bin/perl

use strict;

use Test::More tests => 8;
use File::Spec;

BEGIN { use_ok("NSS"); }
is(NSS->config_dir, ".");

my $config_dir = File::Spec->catdir(".", "db");

ok(NSS->set_config_dir($config_dir));
is(NSS->config_dir, $config_dir);

ok(!NSS->is_initialized());
is(NSS->initialize(), 0);
ok(NSS->is_initialized());

ok(!NSS->set_config_dir($config_dir));
