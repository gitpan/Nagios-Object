#!/usr/local/bin/perl

# File ID: $Id: 98nagios-sample-config.t 31 2007-08-24 02:42:41Z atobey $
# Last Change: $LastChangedDate: 2007-08-23 19:42:41 -0700 (Thu, 23 Aug 2007) $
# Revision: $Rev: 31 $

use strict;
use Test::More qw(no_plan);
use Data::Dumper;
use Scalar::Util qw(blessed);
use lib qw( ./lib ../lib );
#BEGIN { plan tests => 7; }
eval { chdir('t') };

use_ok( 'Nagios::Config' );
use_ok( 'Nagios::Object::Config' );

my @sample_files = qw(
    sample-config-bigger.cfg
    sample-config-minimal.cfg
);

open my $fh, "> /tmp/test.cfg";

foreach my $file ( @sample_files ) {
    diag( "testing with Nagios sample file $file ..." );
	my $parser = Nagios::Object::Config->new( Version => '2.0' );
	$parser->parse( $file );
	
	ok( $parser->resolve_objects, "\$parser->resolve_objects" );
	ok( $parser->register_objects, "\$parser->register_objects" );

    my $all_objects = $parser->all_objects;
    foreach my $object ( @$all_objects ) {
        ok( $object->dump, 'dump '.ref($object). ' named '. $object->name );
        print $fh $object->dump;
    }
}	


