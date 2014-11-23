#!/usr/bin/perl

BEGIN { unshift @INC, '.' };
use strict;
use warnings;

use WWW::PTV;

my $p		= WWW::PTV->new;
my $s_stop_id	= 30801;
my $stops;
my $routes;

print "VERSION $WWW::PTV::VERSION\n";

get_stop( 30801 );

sub get_stop {
	return if $stops->{ $_[0] };
	return unless $_[0];
	print "Stop ID: $_[0] (";
	my $s = $p->get_stop_by_id( $_[0] );
	print $s->address . ")\n";
	$stops->{ $_[0] }++;

	foreach my $route ( $p->get_stop_by_id( $_[0] )->get_route_ids ) {
		return if $routes->{ $route };
		$routes->{ $route }++;
		my $r = $p->get_route_by_id( $route );
		print "Route ID: $route (" . $r->name . ")\n";
		#print "my \$tt = \$p->get_route_by_id( $route )->get_inbound_tt;\n";
		#my $tt = $p->get_route_by_id( $route )->get_inbound_tt;
		my $r = $p->get_route_by_id( $route );
		#use Data::Dumper;
		#print Dumper($r);
		my $tt = $r->get_inbound_tt;
		
		foreach my $stop ( $tt->stop_ids ) {
			get_stop( $stop )
		}
	}
}
