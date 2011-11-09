package WebKit::Render::Image;
use Moose;
extends 'WebKit::Render';

use 5.010001;
use namespace::autoclean;

has '+command' => ( default => 'wkhtmltoimage' );
has format => (
    is      => 'ro',
    isa     => 'Str',
    default => 'png',
);

sub _build_default_options {
    my $self = shift;
    return {
        format   => $self->format,
        encoding => 'UTF-8',
    }
}

=head1 NAME

WebKit::Render::Image - Render HTML as an image

=head1 DESCRIPTION

TODO: This should be documented.

=head1 METHODS

=head2 convert { width => $w, height => $h, %other_options }

...

=head1 SEE ALSO

L<WebKit::Render>

L<wkhtmltoimage|https://github.com/antialize/wkhtmltopdf>

=cut

__PACKAGE__->meta->make_immutable;
1;
