#!/usr/bin/per

use strict;
use warnings;

use WWW::PTV;
use DBI;
use threads;
use Thread;
use Thread::Queue;

my $s 		= 30801;
my $STOP 	= {};
my $ROUTE 	= {};
my $p 		= WWW::PTV->new;
my $rq		= Thread::Queue->new();
my $sq		= Thread::Queue->new();
my $sem		= 1;

main();


sub main {
	return unless $_[0];
	return if ( $STOP->{ $_[0] } );
	
	
}

sub stop_thread {
	while ( $sem or $sq->pending ) {
		sleep ( rand 10 );
		my $s_id = $sq->dequeue_nb;
		next unless $s_id;
		insert_stop( $p->get_stop_by_stop_id ( $s_id ) )
	}
}


# Start at stop n
# Get ist of routes servicing stop n
# For each route, get list of stops on route
# Repeat
#
# For list of stops
# get stop information and populate db
#
#
# For list of routes
# Get route 
