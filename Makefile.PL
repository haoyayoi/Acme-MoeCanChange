use inc::Module::Install;
name 'Acme-MoeCanChange';
all_from 'lib/Acme/MoeCanChange.pm';

requires 'DBD::SQLite' => '1.00';
requires 'DBI';
tests 't/*.t';
author_tests 'xt';

default_test_target
    run_on_prepare => [ 't/database.pl' ],
;

if ((not $ENV{MOE_CAN_CHANGE}) or ($ENV{MOE_CAN_CHANGE} eq '')) {
    $ENV{MOE_CAN_CHANGE} = "$ENV{HOME}/.moecanchange";
}

if (-d "$ENV{MOE_CAN_CHANGE}") {
    system "rm -rf $ENV{MOE_CAN_CHANGE}";
}

system "mkdir $ENV{MOE_CAN_CHANGE}";
if (-f "$ENV{MOE_CAN_CHANGE}/type.db") {
    system "rm $ENV{MOE_CAN_CHANGE}/type.db";
}

system "sqlite3 $ENV{MOE_CAN_CHANGE}/type.db < sql/sqlite.sql";
unless (-f "$ENV{MOE_CAN_CHANGE}/type.db") {
    die "failed to create sqlite database file! check 'sqlite3 --version'";
}

build_requires 'Module::Install::TestTarget';
build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
