#!/usr/bin/perl


my $VERSION			= "4.0.0-beta.2";

my @CORE_COLOURS	= qw(primary secondary success info warning danger light dark);

my $NPM				= "/usr/local/lib";

use strict;
use warnings;
use IO::All;
use YAML::Tiny;

my $SCSS_TMP	= "/tmp/bootstrap.scss";
my $CSS_TMP		= "/tmp/bootstrap.css";

warn << "END";

Make a Bootstrap Colours CSS file
---------------------------------

- read in a YAML file of colour codes

- make a SASS file out of them

- run SASS, and extract the colour codes

- make CSS files, one for each colour, and one for all of them

END

##
warn "Make version dir";

io( "./$VERSION/css")->mkpath();
io( "./$VERSION/html")->mkpath();

##
warn "Read colour list\n";

my $yaml = new YAML::Tiny->read( 'colours.yaml' );

my %colours = %{ $yaml->[0] };

warn ". got " . ( scalar keys %colours ) . " colours\n";

##
warn "Write SCCS file\n";

my @colour_list_scss = () ;

foreach my $colour ( sort keys %colours )
	{
	#"XXX$colour" - there are name clashes in SCSS, doesnt like named SCCS colours.

	my $escape = $colour;

	$escape = "XXX$colour" if ! grep /^$colour$/, @CORE_COLOURS;

	push @colour_list_scss, qq#\t$escape:$colours{ $colour }#;
	}

my $colour_list_scss = join ",\n", @colour_list_scss;

my $scss = << "END";

// \@import "$NPM/node_modules/bootstrap/scss/_functions";
// \@import "$NPM/node_modules/bootstrap/scss/_variables";
// \@import "$NPM/node_modules/bootstrap/scss/_mixins";

\$theme-colors: (
$colour_list_scss
);

\@import "$NPM/node_modules/bootstrap/scss/bootstrap";

END


$scss > io( $SCSS_TMP );

warn ". done\n";

##
warn "Run SASS\n";

qx( sass $SCSS_TMP > $CSS_TMP );

##
warn "Extract the colour rules\n";

warn ". munge rules on to 1 line\n";

my $css < io( $CSS_TMP ) ;

$css =~ s/\n/ /g;

$css =~ s/}/}\n/g; #  does not handle @rules which are indented !

my @css = split /\n\s*/, $css ;

##
warn ". grep for the colour rules we want\n";

my @colour_xxx_css = grep /XXX/ , @css ;
 
warn ". . got lines : " . scalar( @colour_xxx_css ) . "\n";

my $colour_xxx_css = join ( "\n", @colour_xxx_css ) . "\n";

$colour_xxx_css =~ s/XXX//g;

my $colour_css = $colour_xxx_css;

$colour_css > io( "./$VERSION/css/bootstrap_colours.css" );

##
warn ". write css\n";

my @colour_css = split /\n/, $colour_css;
 
warn ". . got lines : " . scalar( @colour_css ) . "\n";

foreach my $colour ( sort keys %colours )
	{
	next if grep /^$colour$/, @CORE_COLOURS;

	my @this_colour_css = grep /-$colour\W/, @colour_css;

	@this_colour_css	= grep ! /charset/, @this_colour_css;

	die "empty $colour\n" if ! @this_colour_css;

	my $this_colour_css = join( "\n", @this_colour_css) . "\n";

	$this_colour_css > io( "./$VERSION/css/$colour.css");
	}
  
## 
warn ". write demo html\n";

my $html;

foreach my $colour ( sort keys %colours )
	{
	$html .= <<"END";

	<tr>
		<td> <button class="btn btn-$colour"> btn-$colour </button></td> 
		<td> <button class="btn btn-outline-$colour"> btn-outline-$colour </button> </td>
		<td> <span class="text-$colour"> text-$colour</span> </td>
		<td> <span class="badge badge-$colour"> badge-$colour</span> </td>
		<td class="bg-$colour"> bg-$colour</td>
	</tr>
END
	}

qq(<table class="table">\n$html</table>\n) > io( "./$VERSION/html/bootstrap_colours.html" );



