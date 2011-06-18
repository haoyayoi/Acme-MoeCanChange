use strict;
use Test::More;
use Acme::MoeCanChange::TypeStruct;

my $types = Acme::MoeCanChange::TypeStruct->types;
ok $types;
isa_ok $types, 'ARRAY';
is @$types, 18;

done_testing();
