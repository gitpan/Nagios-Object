#!/usr/bin/perl

# File ID: $Id: multi_type_entries.t 31 2007-08-24 02:42:41Z atobey $
# Last Change: $LastChangedDate: 2007-08-23 19:42:41 -0700 (Thu, 23 Aug 2007) $
# Revision: $Rev: 31 $

use strict;
use warnings;
use Test::More 'no_plan';
use Data::Dumper;

use Nagios::Object::Config;
use Nagios::Object;

eval { chdir('t'); };

my $cfile = 'multi_type_entries.cfg';
my $c = Nagios::Object::Config->new( Version => 2.5 );
ok( $c->parse($cfile), "Config parse() succeeded for '$cfile'" );
$c->resolve_objects;
$c->register_objects;

ok( my $service = $c->find_object('Current Load'), "Get a service object to work with" );

ok( my $host = $c->find_object( 'anotherhost' ), "Get a host to work with" );
my $host_multi = $host->parents;

#print Dumper($host_multi);

#use B::Deparse;
#my $dp = B::Deparse->new();
#print $dp->coderef2text( \&Nagios::Service::servicegroups );

my $list = $service->servicegroups;

