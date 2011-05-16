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

unless (-d "$ENV{HOME}/.moecanchange") {
    system "mkdir $ENV{HOME}/.moecanchange";
} 
system "rm $ENV{HOME}/.moecanchange/type.db";
system "sqlite3 $ENV{HOME}/.moecanchange/type.db < sql/sqlite.sql";
unless (-f "$ENV{HOME}/.moecanchange/type.db") {
    die "failed to create sqlite database file! check 'sqlite3 --version'";
}

build_requires 'Module::Install::TestTarget';
build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
