use strict;
use Test::More;
use Acme::MoeCanChange;
use DBI;

my $dbh = DBI->connect("dbi:SQLite:t/test.db");
my $client = Acme::MoeCanChange->new;
$client->db($dbh);
isa_ok $client->db, 'DBI::db';
is $client->param_sum, undef;

# failed 
{
    is $client->param_sum('ttt'), undef;
}

# default 
{
    my $diff = $client->param_sum('default');
}

# default, natural
{
    my $diff = $client->param_sum('default', 'natural');
    is_deeply $diff, 
        { 
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

# changed
{
    my $diff = $client->param_sum('natural', 'spoiled');
    is_deeply $diff, 
        { 
            kind       => 1000,
            mischief   => 200,
            graceful   => 200,
            showy      => 200,
            aggressive => 200,
            reserved   => 200,
            vigor      => 500,
            shy        => 200,
            curiosity  => 500,
            mild       => 400,
        };
}

done_testing();
