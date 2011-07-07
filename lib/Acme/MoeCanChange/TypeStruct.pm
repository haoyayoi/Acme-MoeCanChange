package Acme::MoeCanChange::TypeStruct;
use strict;
use warnings;
use utf8;

my $data = +{
    'default'     => [qw/デフォルト 0 0 0 0 0 0 0 0 0 0/],
    'natural'     => [qw/天然 200 200 200 200 200 200 200 200 200 200/],
    'spoiled'     => [qw/甘えん坊 1000 0 0 0 0 0 500 0 500 400/],
    'tundere'     => [qw/ツンデレ 0 0 0 0 1000 1000 0 1000 0 0/],
    'high-handed' => [qw/高飛車 0 200 200 600 1000 0 200 0 0 200/],
    'boyish'      => [qw/ボーイッシュ 0 0 0 0 0 0 1000 0 0 400/],
    'mysterious'  => [qw/ミステリアス 400 0 0 0 0 600 0 500 500 0/],
    'sexy'        => [qw/セクシー 0 1000 0 800 0 0 400 0 400 0/],
    'neatly'      => [qw/清楚 500 0 1000 0 0 0 0 300 0 600/],
    'bitch'       => [qw/小悪魔 300 300 0 200 0 0 0 0 600 200/],
    'cool'        => [qw/クール 0 0 400 0 200 100 0 700 0 200/],
    'obliging'    => [qw/世話焼き 600 0 0 0 600 0 0 0 1000 800/],
    'yandere'     => [qw/ヤンデレ 0 400 0 800 0 800 600 0 0 0/],
    'crybaby'     => [qw/泣き虫 700 0 0 0 0 1000 0 0 0 500/],
    'noble'       => [qw/高貴 0 0 800 1000 700 0 0 0 0/],
    'manish'      => [qw/マニッシュ 0 1000 0 0 800 0 0 400 300 0/],
    'tomboy'      => [qw/やんちゃ 200 500 0 500 0 0 800 0 200 600/],
    'serious'     => [qw/まじめ 800 800 1000 0 0 0 0 0 0 0/],
};

my @skey = qw/
    kind mischief graceful showy aggressive
    reserved vigor shy curiosity mild/;

sub types { [ sort { $a cmp $b } keys %{$data} ] }

sub param_keys { [ sort { $a cmp $b } @skey ] }

sub data_by {
    my ($class, $type) = @_;
    my @struct = @{$data->{$type}};
    my %result;
    unshift @skey, 'name';
    @result{@skey} = @struct; 
    delete $result{name};
    return \%result;
}

1;
