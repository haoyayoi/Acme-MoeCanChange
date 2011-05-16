use strict;
use Test::More;
use Acme::MoeCanChange;
use DBI;

my $dbh = DBI->connect("dbi:SQLite:t/test.db");
my $client = Acme::MoeCanChange->new;
$client->db($dbh);
isa_ok $client->db, 'DBI::db';
is $client->type_construct, undef;

# failed 
{
    my $class_default = $client->type_construct('dummy');
    is $class_default, undef;
}

# default
{
    my $class_default = $client->type_construct('default');
    is_deeply $class_default, 
        { 
            name       => 'デフォルト',
            name_en    => 'default',
            kind       => 0,
            mischief   => 0,
            graceful   => 0,
            showy      => 0,
            aggressive => 0,
            reserved   => 0,
            vigor      => 0,
            shy        => 0,
            curiosity  => 0,
            mild       => 0,
        };
}

# changed
{
    my $class_default = $client->type_construct('natural');
    is_deeply $class_default, 
        { 
            name       => '天然',
            name_en    => 'natural',
            kind       => 200,
            mischief   => 200,
            graceful   => 200,
            showy      => 200,
            aggressive => 200,
            reserved   => 200,
            vigor      => 200,
            shy        => 200,
            curiosity  => 200,
            mild       => 200,
        };
}

done_testing();
