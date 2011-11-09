package WebKit::Render;
use Moose;

use 5.010001;
use IPC::Run qw(run);
use Clone qw(clone);
use namespace::autoclean;

has command => (
    is      => 'ro',
    default => 'wkhtmltopdf',
);

has default_options => (
    is      => 'ro',
    isa     => 'HashRef',
    lazy    => 1,
    builder => '_build_default_options',
);
sub _build_default_options { return {} }

sub convert {
    my ($self, $orig_options) = @_;
    my $options = $orig_options ? clone($orig_options) : {};

    my $infile  = delete $options->{infile};
    my $html    = delete $options->{html};
    my $outfile = delete $options->{outfile};

    my @opts = $self->option_list_from_hash(
        $self->merge_options_with_defaults($options)
    );

    push @opts, $infile || '-';
    push @opts, $outfile || '-';

    my $output;
    my $err;
    run([ $self->command, @opts ], \$html, \$output, \$err);

    if ($outfile && ! -s $outfile) {
        die "convert() did not put anything into $outfile. stdout=$output stderr=$err";
    }

    return $outfile // $output;
}

sub merge_options_with_defaults {
    my ($self, $options) = @_;
    my %rv = %{ $options };
    for (keys %{ $self->default_options }) {
        $rv{$_} = $self->default_options->{$_} unless exists $rv{$_};
    }
    return \%rv;
}

sub option_list_from_hash {
    my ($self, $options) = @_;
    my @rv = ();
    for (keys %$options) {
        my $opt = $_;
        my $val = $options->{$_};
        if (length $opt == 1) {
            $opt = '-' . $opt;
        } elsif (substr($opt, 0, 2) ne '--') {
            $opt = '--' . $opt;
        }
        $opt =~ s/_/-/g;
        push @rv, $opt;
        push @rv, $val if defined $val;
    }
    return @rv;
}

=head1 NAME

WebKit::Render - Render HTML as an image/pdf/etc

=head1 DESCRIPTION

Base class for L<WebKit::Render::Image> and L<WebKit::Render::PDF>.

=head1 ATTRIBUTES

=head2 default_options

Default cli options. Read-only.

=head2 command

CLI program to generate the output

=head1 METHODS

=head2 convert \%options

Generate the output.

Requires at least 'html' or 'infile'. Optionally give 'outfile', then
any other options the cli program accepts.

Returns output file, or output.
Throws exception on error.

For one-arg options, specify undef as the value. e.g. 
C<< 'some_option' => undef >>

=head1 SEE ALSO

L<wkhtmltoimage|https://github.com/antialize/wkhtmltopdf>

=cut

__PACKAGE__->meta->make_immutable;
1;
