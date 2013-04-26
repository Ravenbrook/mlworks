##############################################################################
### This is a perl script which gets evaluated as a trigger within HOPE
###
### $HopeName: MLW!trigger.pl(trunk.6) $
### $Id: trigger.pl,v 1.8 2002/12/17 15:17:37 johnk Exp $
##############################################################################

$EmailChangesTo = 'johnh';

@MyEmailText       = ();
@MyMiddleEmailText = ();
%MyEmailArgs       = ();
%MyTriggerArgs     = ();
$DoEmail           = 0;

&processObjects;

### Post trigger
if ($MyTriggerArgs{'TRIGGERphase'} eq 'post') {
    # Send the email
    &email(*MyEmailArgs, *MyEmailText) if ($DoEmail);

    &exitOK;

} else {
    &exitOK;
}

##############################################################################
#### parse all objects
##############################################################################

sub processObjects {
    local($key, $val);

    %MyTriggerArgs = (); # For safety, reset this as well

    while (&decodeTriggerArgs(*MyTriggerArgs)) {

        # Ignore some commands.
        next if ($MyTriggerArgs{'TRIGGERcommand'} eq 'claim'    ||
                 $MyTriggerArgs{'TRIGGERcommand'} eq 'checkout' ||
                 $MyTriggerArgs{'TRIGGERcommand'} eq 'abandon'
                 );

        next if (!($MyTriggerArgs{'COMMANDcompound'} =~ /^MLW/));

        $DoEmail = 1;

        # Munge arguments
        $MyTriggerArgs{'COMMANDbranch'} = 'trunk'
            if ($MyTriggerArgs{'COMMANDbranch'} eq '.');

        ## crude subject line experimental
        local($b,$c,$u,$v, $subj);
        $b = $MyTriggerArgs{'COMMANDbranch'};
        $c = $MyTriggerArgs{'COMMANDcompound'};
        $u = $MyTriggerArgs{'COMMANDunit'};
        $v = $MyTriggerArgs{'COMMANDunitversion'};

        if (defined $MyTriggerArgs{'COMMANDbugnumber'}) {
            $subj = "[REQUEST $MyTriggerArgs{'COMMANDbugnumber'}] " .
                    "HOPE $MyTriggerArgs{'TRIGGERcommand'} of " .
                    (length($u) ? "$c($b)!$u($v)" : "$c($b)"); }
        else {
            $subj = "HOPE $MyTriggerArgs{'TRIGGERcommand'} of " .
                    (length($u) ? "$c($b)!$u($v)" : "$c($b)"); }

        %MyEmailArgs = ('To'     , $EmailChangesTo,
                        'From'   , $MyTriggerArgs{'HOPEclientusername'},
                        'Subject', $subj);

        @MyMiddleEmailText = ();

        # Go over each repeating argument
        foreach $key (sort(keys(%MyTriggerArgs))) {

           # skip repeating arguments we are really not interested in
           next if ($key eq 'HOPEclientdir'      ||
                    $key eq 'HOPEclientname'     ||
                    $key eq 'HOPEclientos'       ||
                    $key eq 'HOPEclientusername' ||
                    $key eq 'HOPEservername'     ||
                    $key eq 'HOPEserverversion'  ||
                    $key eq 'TRIGGERcompound'    ||
                    $key eq 'TRIGGERcompounddir' ||
                    $key eq 'TRIGGERphase'       ||
                    $key eq 'TRIGGERrundir'      ||
                    $key eq 'TRIGGERcommand'     ||
                    $key eq 'TRIGGERtest'        ||
                    # the below are not that useful either!
                    $key eq 'COMMANDdate'        ||
                    $key eq 'COMMANDfilename'    ||
                    $key eq 'COMMANDlocal'       ||
                    $key eq 'COMMANDrecursive'   ||
                    # skip what we handle below
                    $key eq 'COMMANDbranch'      ||
                    $key eq 'COMMANDcompound'    ||
                    $key eq 'COMMANDunit'        ||
                    $key eq 'COMMANDreason'      ||
                    $key eq 'COMMANDbugnumber'   ||
                    $key eq 'COMMANDnewunitversion' ||
                    $key eq 'COMMANDunitversion'
                    );


           ##########################################
           ### Command switch
           ##########################################

           if ($MyTriggerArgs{'TRIGGERcommand'} eq 'checkin') {
           ##########################################

               # skip what we handle above
               next if ($key eq 'COMMANDforcedcheckin'  ||
                        # $key eq 'COMMANDbugnumber'    ||
                        $key eq 'COMMANDuseclaimreason' ||
                        $key eq 'COMMANDdelete'         ||
                        $key eq 'COMMANDuser'
                       );


           } elsif ($MyTriggerArgs{'TRIGGERcommand'} eq 'add') {
           ##########################################


           } elsif ($MyTriggerArgs{'TRIGGERcommand'} eq 'set') {
           ##########################################

               local(%set_attr, $set_attr, $set_val);
               %set_attr = split(',', $MyTriggerArgs{'COMMANDattributes'});
               while (($set_attr, $set_val) = each %set_attr) {
                   push(@MyMiddleEmailText,
                        sprintf("    %-23s %s",$set_attr,$set_val));
               }

               # skip what we handle above
               next if ($key eq 'COMMANDattributes');

               # catch anything else we might have missed
               push(@MyMiddleEmailText,
                    sprintf("    %-23s %s",$key,$MyTriggerArgs{$key}));


           } elsif ($MyTriggerArgs{'TRIGGERcommand'} eq 'remove') {
           ##########################################


           } elsif ($MyTriggerArgs{'TRIGGERcommand'} eq 'branch') {
           ##########################################

           } elsif ($MyTriggerArgs{'TRIGGERcommand'} eq 'checkpoint') {
           ##########################################

           }

           ##########################################
           # catch anything else we might have missed! missing command or
           # even a field within a command! Make sure you leave this here! 
           push(@MyMiddleEmailText,
                sprintf("    %-23s %s",$key,$MyTriggerArgs{$key}));
           ##########################################
        } # End of command switch

        push(@MyEmailText, "o $MyTriggerArgs{'COMMANDcompound'}(" .
                             "$MyTriggerArgs{'COMMANDbranch'})!" .
                             "$MyTriggerArgs{'COMMANDunit'}(" .
                             "$MyTriggerArgs{'COMMANDunitversion'})");
        # shove in that reason
        if (defined $MyTriggerArgs{'COMMANDreason'}) {

            # indent the reason a little
            local(@TheReason) = &unpackLines($MyTriggerArgs{'COMMANDreason'});
            foreach $line (@TheReason) {
                push(@MyEmailText, "  $line");
            }
        }

        push(@MyEmailText, @MyMiddleEmailText);
        push(@MyEmailText, "\n");
    }

    # Insert some text at the beginning of of the email!
    unshift(@MyEmailText,
            "\n" .
            "$MyTriggerArgs{'TRIGGERcommand'} command executed by " .
            "$MyTriggerArgs{'HOPEclientusername'}" .
            "\n");
}


##############################################################################
#### support routines
##############################################################################

sub unpackLines {
  local($line) = @_;
  local(@lines, $oneline);

  while ($line =~ /([^\\])\\n/) {  # find a linebreak
     $oneline = "$`$1";
     $line = $';
     $oneline =~ s/\\\\/\\/g;
     push(@lines, $oneline);
  }
  push(@lines, $line);
  return (@lines);
}

sub exitOK {
    exit 0;
}
sub exitAbort {
    exit 1;
}

sub email {
    local (*emailargs, *text) = @_;
    local ($SendMail, *MAIL);

    $SendMail = '/usr/lib/sendmail';

    return undef unless open (MAIL, "| $SendMail -t");

    if (length($emailargs{'From'})) {
        print MAIL "From: $emailargs{'From'}\n";
    }
    if (length($emailargs{'To'})) {
        print MAIL "To: $emailargs{'To'}\n";
    } else {
        return undef;
    }
    if (length($emailargs{'Reply-To'})) {
        print MAIL "Reply-To: $emailargs{'Reply-To'}\n";
    }
    if (length($emailargs{'Cc'})) {
        print MAIL "Cc: $emailargs{'Cc'}\n";
    }
    if (length($emailargs{'Bcc'})) {
        print MAIL "Bcc: $emailargs{'Bcc'}\n";
    }
    if (length($emailargs{'Subject'})) {
        print MAIL "Subject: $emailargs{'Subject'}\n";
    }

    foreach (@text) {
        print MAIL "$_\n";
    }

    print MAIL "\n";
    close MAIL;

    return 1;
}

#############################################################################
###                                 END OF SCRIPT
#############################################################################
1;

### RCS $Log: trigger.pl,v $
### RCS Revision 1.8  2002/12/17 15:17:37  johnk
### RCS Automatic checkin:
### RCS changed attribute _mode to '0444'
### RCS
# Revision 1.6  1999/02/03  11:43:19  mitchell
# Remove Jo and Jon from the mailing list
#
# Revision 1.5  1998/02/22  16:03:10  mitchell
# Filter out compounds not starting with MLW
#
# Revision 1.4  1998/02/06  12:58:56  mitchell
# Move request number to front of summary
#
# Revision 1.3  1998/01/30  16:23:52  mitchell
# Start sending mail to all ML developers.
#
# Revision 1.2  1998/01/30  10:43:34  mitchell
# ** No reason given. **
# Added request ID to mail maessage
#
# Revision 1.1  1998/01/29  10:17:59  mitchell
# new unit
# New trigger based on the one in the D compound
#








