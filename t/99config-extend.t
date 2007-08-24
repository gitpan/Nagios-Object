#!/usr/local/bin/perl -w

# File ID: $Id: 99config-extend.t 31 2007-08-24 02:42:41Z atobey $
# Last Change: $LastChangedDate: 2007-08-23 19:42:41 -0700 (Thu, 23 Aug 2007) $
# Revision: $Rev: 31 $

use strict;
use Test::More qw(no_plan);
use lib qw( ../lib ./lib );
eval { chdir('t') };

use_ok( 'Nagios::Object' );


package Nagios::Host;
{
    no warnings; # so use of valid_fields doesn't bug us
    $Nagios::Host::valid_fields->{foobar} = [ 'STRING', 0, 0, 0 ];
}
sub foobar { shift->{foobar}->() || 'public' }
sub set_foobar {
    my $self = shift;
    if ( !exists($self->{foobar}) ) {
        $self->{foobar} = 'public';
    }
    $self->_set('foobar', @_);
}

#sub set_foobar { $_[0]->{foobar} = $_[1] }

package main;

can_ok( 'Nagios::Host', 'foobar' );
can_ok( 'Nagios::Host', 'set_foobar' );

my $host = Nagios::Host->new();

can_ok( $host, 'foobar' );
can_ok( $host, 'set_foobar' );

ok( $host->set_foobar( "guessme" ),
    "newly created set_foobar method works" );
is( $host->foobar, 'guessme',
    "use getter method to verify previous test" );

