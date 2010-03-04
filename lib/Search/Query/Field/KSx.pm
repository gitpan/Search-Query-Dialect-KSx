package Search::Query::Field::KSx;
use strict;
use warnings;
use base qw( Search::Query::Field );
use Scalar::Util qw( blessed );

__PACKAGE__->mk_accessors(qw( type is_int analyzer ));

our $VERSION = '0.03';

=head1 NAME

Search::Query::Field::KSx - query field representing a KinoSearch field

=head1 SYNOPSIS

 my $field = Search::Query::Field::KSx->new( 
    name        => 'foo',
    alias_for   => [qw( bar bing )], 
 );

=head1 DESCRIPTION

Search::Query::Field::KSx implements field
validation and aliasing in KinoSearch search queries.

=head1 METHODS

This class is a subclass of Search::Query::Field. Only new or overridden
methods are documented here.

=head2 init

Available params are also standard attribute accessor methods.

=over

=item type

The column type. This may be a KinoSearch::FieldType object
or a simple string.

=item is_int

Set if C<type> matches m/int|num|date/.

=item analyzer

Set to a KinoSearch::Analysis::Analyzer-based object (optional).

=back

=cut

sub init {
    my $self = shift;
    $self->SUPER::init(@_);

    $self->{type} ||= 'char';

    # numeric types
    if ( !blessed( $self->{type} ) && $self->{type} =~ m/int|date|num/ ) {
        $self->{is_int} = 1;
    }

    # text types
    else {
        $self->{is_int} = 0;
    }

}

1;

__END__

=head1 AUTHOR

Peter Karman, C<< <karman at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-search-query-dialect-ksx at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Search-Query-Dialect-KSx>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Search::Query::Dialect::KSx


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Search-Query-Dialect-KSx>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Search-Query-Dialect-KSx>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Search-Query-Dialect-KSx>

=item * Search CPAN

L<http://search.cpan.org/dist/Search-Query-Dialect-KSx/>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2010 Peter Karman.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut
