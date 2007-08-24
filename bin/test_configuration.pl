#!/usr/local/bin/perl

# File ID: $Id: test_configuration.pl 31 2007-08-24 02:42:41Z atobey $
# Last Change: $LastChangedDate: 2007-08-23 19:42:41 -0700 (Thu, 23 Aug 2007) $
# Revision: $Rev: 31 $

use lib qw(./lib ../lib);
use Nagios::Config;
use Benchmark ':hireswallclock';
use Getopt::Std;

=head1 NAME

test_configuration.pl - Load your configuration to verify Nagios::Object is compatible with it.

=head1 USAGE

perl test_configuration.pl -c /etc/opt/nagios/nagios.cfg

=cut

our $opt_c;
getopt( 'c:' );
die "Must specify location of Nagios configuration with -c option."
    if ( !$opt_c );

my $bench_start = Benchmark->new;
my $cf = Nagios::Config->new( Filename => $opt_c, force_relative_files => 1 );

my $bench_end = Benchmark->new;

printf "\nTime to parse: %s\n",
        timestr(timediff( $bench_end, $bench_start ));

