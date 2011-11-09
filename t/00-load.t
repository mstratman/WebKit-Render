#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WebKit::Render' ) || print "Bail out!\n";
    use_ok( 'WebKit::Render::Image' ) || print "Bail out!\n";
    use_ok( 'WebKit::Render::PDF' ) || print "Bail out!\n";
}

diag( "Testing WebKit::Render $WebKit::Render::VERSION, Perl $], $^X" );
