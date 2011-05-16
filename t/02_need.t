use strict;
use Test::More;
use Acme::MoeCanChange;
use DBI;

my $dbh = DBI->connect("dbi:SQLite:t/test.db");
my $client = Acme::MoeCanChange->new;
$client->db($dbh);
isa_ok $client->db, 'DBI::db';
is $client->need_param, undef;

# failed 
{
    is $client->need_param({ from => 'ttt', to => 'natural' }), undef;
    is $client->need_param({ from => 'natural', to => 'ttt' }), undef;
}

# default, natural
{
    my $diff = $client->need_param({ from => 'default', to => 'natural' });
    is_deeply $diff, 
        { 
            base_name    => 'デフォルト',
            base_name_en => 'default',
            to_name      => '天然',
            to_name_en   => 'natural',
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
    my $diff = $client->need_param({ from => 'natural', to => 'spoiled' });
    is_deeply $diff, 
        { 
            base_name    => '天然',
            base_name_en => 'natural',
            to_name      => '甘えん坊',
            to_name_en   => 'spoiled',
            kind       => 800,
            vigor      => 300,
            curiosity  => 300,
            mild       => 200,
        };
}

done_testing();
