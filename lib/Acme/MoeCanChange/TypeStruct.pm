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
世話焼き 600 600 1000 800 3000
ﾔﾝﾃﾞﾚ 400 800 800 600 2600
泣き虫 700 1000 500 2200
高貴 800 1000 700 2500
ﾏﾆｯｼｭ 1000 800 400 300 2500
やんちゃ 200 500 500 800 200 600 2800
まじめ 800 800 1000 2600
    kind       => 200,
    mischief   INTEGER     NOT NULL DEFAULT 0,
    graceful   INTEGER     NOT NULL DEFAULT 0,
    showy      INTEGER     NOT NULL DEFAULT 0,
    aggressive INTEGER     NOT NULL DEFAULT 0,
    reserved   INTEGER     NOT NULL DEFAULT 0,
    vigor      INTEGER     NOT NULL DEFAULT 0,
    shy        INTEGER     NOT NULL DEFAULT 0,
    curiosity  INTEGER     NOT NULL DEFAULT 0,
    mild       INTEGER     NOT NULL DEFAULT 0

   
}

sub data_by {
    my ($class, $type) = @_;
    
    {
        
}

1;
