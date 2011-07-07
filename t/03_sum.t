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
    my $need = $client->param_sum('default');
    is_deeply $need, 
        {
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
    my $sum = $client->param_sum('natural', 'spoiled');
    is_deeply $sum, 
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
