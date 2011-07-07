package Acme::MoeCanChange;

use strict;
use warnings;
use utf8;
use 5.008_0009;
our $VERSION = '0.01';

use DBI;
use SQL::Maker;
use Acme::MoeCanChange::TypeStruct;
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

sub sql_builder { SQL::Maker->new( driver => 'SQLite' ) }

sub type_construct {
    my ($self, $type) = @_;
    return unless $type;
    
    my $dbh = $self->db || $self->dbh;
    my ($sql, @binds) = $self->sql_builder->select(
        'type', ['*'], { name_en => $type }
    );
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
    my $keys = Acme::MoeCanChange::TypeStruct->param_keys;
    foreach my $key (@{$keys}) {
        if ( ($to_param->{$key} || 0) > ($base_param->{$key} || 0) ) {
            $result->{$key} = $to_param->{$key} - $base_param->{$key} || 0;
        }
    }
    return $result;
}

sub param_sum {
    my ($self, @args) = @_;
    return unless @args;
   
    my $structs = +{};
    foreach my $type (@args) {
        $structs->{$type} = $self->type_construct($type);
        delete $structs->{$type}->{name};
        delete $structs->{$type}->{name_en};
        delete $structs->{$type} unless keys %{$structs->{$type}};
    }
    return unless keys %{$structs};

    my $result = +{};
    my $keys = Acme::MoeCanChange::TypeStruct->param_keys;
    foreach my $key (@{$keys}) {
        my @type_by_key;
        foreach my $type (@args) {
            my $val = $structs->{$type}->{$key} || 0;
            push @type_by_key, $val;
        }
        my @order_type_by_key = sort { $b <=> $a } @type_by_key;
        $result->{$key} = shift @order_type_by_key;
    }
    return $result;
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
