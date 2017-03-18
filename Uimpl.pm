package Uimpl;
use strict;
use Cdk;
use Text::Wrap;
use Mail::IMAPClient;
use File::Path qw(make_path);
use File::Basename;
use DBI;
use Exporter;
my @ISA = qw(Exporter);

my $FIFO = '/tmp/.out';

$Text::Wrap::columns = 72;

my $CONKY  = "/usr/bin/conky";

my $label = ();


sub passdialog {
    my @prompt = @_;

    # Create a new entry object.
    my $entry = new Cdk::Entry(
        'Label' => @prompt,
        'Width' => 1,
        'Min'   => 0,
        'Max'   => 256
    );

    # Activate the object.
    my $pw = $entry->activate();

    # Check the results.
    if ( !defined $pw ) {
        popupLabel( ["<C>You hit escape, nothing returned."] );
    }
    else {
        return $pw;
    }

}

sub do_first {
# XXX fill up
}

sub do_second {
# XXX fill up
}
sub do_third {
# XXX fill up
}

sub confirmdialog {
    my ( $msg, $alt ) = @_;

    my (@buttons) = ();

    # Create the dialog buttons.
    if ( defined($alt) ) {
        @buttons = ( "</B>    Alternate    <!B>", "</B>    Standard    <!B>" );
    }
    else {
        @buttons = ( "</B>    YES    <!B>", "</B>    NO     <!B>" );
    }

    # Create the dialog message.
    my @mesg = ( "<C></2>      $msg          <!2>", );

    # Create the dialog object.
    my $dialog = new Cdk::Dialog(
        'Highlight' => "</B/R/24>",
        'Message'   => \@mesg,
        'Buttons'   => \@buttons,
        'Xpos'      => "CENTER",
        'Ypos'      => "CENTER",
    );

    # Activate the object.
    my $button = $dialog->activate();

    # Check the results.
    if ( !defined $button ) {
        popupLabel( ["<C>Escape hit. No button selected."] );
        return undef;
    }
    else {
        if ( $button eq 0 ) {
            return 0;
        }
        return -1;
    }
}

sub drawlabel {
    my @mesg = @_;

    $label = new Cdk::Label(
        'Message' => \@mesg,
        'Ypos'    => 8
    );

    $label->draw();
    $label->wait();
    $label->erase();
    return $label;
}

# XXX starts here

sub do_sysstats {
    my @out = ();
    @out = readpipe "$CONKY -i 1 ";
    @out = (@out);
    drawlabel(@out);
}

my @EXPORT = qw(
  do_first do_second do_third do_stats confirmdialog passdialog);
