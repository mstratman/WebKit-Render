package WebKit::Render::PDF;
use Moose;
extends 'WebKit::Render';

use namespace::autoclean;

has '+command' => ( default => 'wkhtmltopdf' );

sub _build_default_options {
    return {
        'page-size'     => 'Letter',
        'margin-top'    => '0.75in',
        'margin-right'  => '0.75in',
        'margin-bottom' => '0.75in',
        'margin-left'   => '0.75in',
        'encoding'      => 'UTF-8',
    }
}

=head1 NAME

WebKit::Render::PDF - Render HTML as a PDF

=head1 DESCRIPTION

TODO: This should be documented.

=head1 SEE ALSO

L<WebKit::Render>

L<wkhtmltoimage|https://github.com/antialize/wkhtmltopdf>

=cut

__PACKAGE__->meta->make_immutable;
1;
