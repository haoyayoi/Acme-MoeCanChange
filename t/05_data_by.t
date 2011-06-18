use strict;
use warnings;
use utf8;
use Test::More;
use Acme::MoeCanChange::TypeStruct;

my $types = Acme::MoeCanChange::TypeStruct->data_by('bitch');
ok $types;
isa_ok $types, 'HASH';
is_deeply $types, {
    name       => '小悪魔',
    mild       => 200,
    aggressive => 0,
    kind       => 300,
    shy        => 0,
    mischied   => 300,
    showy      => 200,
    curiosity  => 600,
    vigor      => 0,
    reserved   => 0,
    graceful   => 0,
};

done_testing();
