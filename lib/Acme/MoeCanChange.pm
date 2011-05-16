package Acme::MoeCanChange;

use strict;
use warnings;
use utf8;
use 5.008_0009;
our $VERSION = '0.01';

use DBI;
use SQL::Maker;
use Class::Accessor::Lite (
    rw => [ qw(home db) ]
);

sub new {
    my $class = shift;
    bless { 
        home => $ENV{MOE_CAN_CHANGE} || "$ENV{HOME}/.moecanchange/",
    }, $class;
}

sub dbh {
    my $self = shift;
    my $dbh  = DBI->connect(
        "dbi:SQLite:" . $self->home . "type.db", "", "",
        {
            RaiseError => 1,
            PrintError => 0,
            AutoCommit => 1,
        })
        or die "Cannot connect to DB:: " . $DBI::errstr;
    return $dbh;
}

sub sql_builder {
    my $self = shift;
    SQL::Maker->new( driver => 'SQLite' );
}

sub type_construct {
    my ($self, $type) = @_;
    return unless $type;
    
    my $dbh = $self->db || $self->dbh;
    my ($sql, @binds) = $self->sql_builder->select('type', ['*'], { name_en => $type });
    my $sth = $dbh->prepare($sql);
    $sth->execute(@binds);
    my $result = $sth->fetchrow_hashref;
    return unless keys %$result;
    undef $sth;
    delete $result->{id};
    return $result;
}

sub need_param {
    my ($self, $args) = @_;
    return unless $args;
    return unless ref $args eq 'HASH';
    
    my $base_param = $self->type_construct($args->{from});
    return unless keys %$base_param;
    my $to_param   = $self->type_construct($args->{to});
    return unless keys %$to_param;
    my $result = +{
        base_name    => delete $base_param->{name},
        base_name_en => delete $base_param->{name_en},
        to_name      => delete $to_param->{name},
        to_name_en   => delete $to_param->{name_en},
    };
    foreach my $key (keys %$base_param) {
        if ( ($to_param->{$key} || 0) > ($base_param->{$key} || 0)) {
            $result->{$key} = $to_param->{$key} - $base_param->{$key};
        }
    }
    return $result;
}

sub param_sum {
    my ($self, $args) = @_;
    
}

1;
__END__

=head1 NAME

Acme::MoeCanChange -

=head1 SYNOPSIS

  use Acme::MoeCanChange;

=head1 DESCRIPTION

Acme::MoeCanChange is

=head1 AUTHOR

Default Name E<lt>default {at} example.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
