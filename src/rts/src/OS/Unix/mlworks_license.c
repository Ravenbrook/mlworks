/* === LICENSE VALIDATION ===
 *
 * Standalone license-code tty/gui validator for Unix
 *
 *
 * $Log: mlworks_license.c,v $
 * Revision 1.3  1998/07/30 14:30:04  mitchell
 * [Bug #30435]
 * Give warning dialog a more informative window name
 *
 * Revision 1.2  1998/07/21  11:53:32  jkbrook
 * [Bug #30435]
 * Lower-case names before hashing (as in Win32 version)
 *
 * Revision 1.1  1998/07/15  15:08:21  jkbrook
 * new unit
 * [Bug #30435]
 * Standalone license-validator and dot-file writer
 *
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#include <stdlib.h>
#include <ctype.h>
#include <Xm/LabelG.h>
#include <Xm/RowColumn.h>
#include <Xm/PushBG.h>
#include <Xm/MessageB.h>
#include <Xm/Text.h>
#include <Xm/PanedW.h>
#include <Xm/Form.h>

#include "license.h"
#include "validate_license.h"
#include "mlw_mklic.h"

extern void gui_license(int argc, char *argv[]);

static char *massage_string(char* str)
{
  char *result;
  char *cp1, *cp2, *cp3;
  int len;

  len = strlen(str);
  result = malloc(len + 1);
  if (result == NULL)
    fprintf(stderr,"malloc failed\n");

  for (cp1 = str; isspace(*cp1); cp1++);
  for (cp2 = str+len-1; isspace(*cp2); cp2--);
  for (cp3 = result; cp1 <= cp2; cp1++, cp3++)
    *cp3 = *cp1;

  *cp3 = '\0';
  return result;
}


/* License validation and installation */

/* TTY version */

static void print_license_result (enum license_check_result lcr);

static void tty_license()
{
    int BUF_SIZE = 1024;

    char * massaged_name;
    char * massaged_code;
    char * license_name;
    char * license_code;
    char * output;

    int len,p;
    enum license_check_result license_validation_result = INVALID; /* default */

    license_name = malloc(BUF_SIZE);
    license_code = malloc(BUF_SIZE);

    printf("Licence name: ");
    fgets(license_name, BUF_SIZE, stdin);
    massaged_name = massage_string(license_name);
    len = strlen(massaged_name);
    for (p = 0; p < len; p++) {
      massaged_name[p] = tolower(massaged_name[p]);  
    };

    printf("Licence code: ");
    fgets(license_code, BUF_SIZE, stdin);
    massaged_code = massage_string(license_code);

  if (strlen(massaged_name) || strlen(massaged_code)) {
    license_validation_result = license_validate(massaged_name, massaged_code);

    if (license_validation_result == OK) {
      output = malloc(strlen(massaged_name) + DATE_CHARS + EDITION_CHARS);

      /* output to .mlworks_user*: (exp date ^ edition ^ name) */

      strcpy(output,"\0");

      strncat(output,license_code+CHECK_CHARS+EDITION_CHARS+DATE_CHARS,DATE_CHARS);
      strncat(output,license_code+CHECK_CHARS,EDITION_CHARS);
      strcat(output,license_name);


      license_store(output);

      free(output);
      exit(EXIT_SUCCESS);
    } else print_license_result(license_validation_result);
  } else
      exit(EXIT_SUCCESS);
}



/* GUI version */

Widget toplevel, text_name, text_code;
XtAppContext app;

static void validate_cb(Widget widget, XtPointer client_data, XtPointer call_data);

static void quit_cb(Widget widget, XtPointer client_data, XtPointer call_data)
{
  exit(EXIT_FAILURE);
}

void gui_license(int argc, char *argv[])
{
  Widget pane, form, button_widget, label, rc;
  Dimension h;


  XtSetLanguageProc (NULL, NULL, NULL);

  toplevel = XtVaAppInitialize (&app, "LicenseEntry", NULL, 0,
                                &argc, argv, NULL, NULL);

  pane = XtVaCreateWidget ("pane",
    xmPanedWindowWidgetClass, toplevel,
    XmNsashWidth, 1,
    XmNsashHeight, 1,
    NULL);

  rc = XtVaCreateWidget ("rowcol", xmRowColumnWidgetClass, pane,
    XmNnumColumns, 1,
    XmNorientation, XmVERTICAL,
    NULL);

  label = XtVaCreateManagedWidget ("License name:",
    xmLabelGadgetClass, rc, NULL);

  text_name = XtVaCreateManagedWidget ("text", xmTextWidgetClass, rc,
    XmNvalue, "", NULL);

  label = XtVaCreateManagedWidget ("License code:",
    xmLabelGadgetClass, rc, NULL);

  text_code = XtVaCreateManagedWidget ("text", xmTextWidgetClass, rc,
    XmNvalue, "", NULL);

  XtManageChild (rc);

  form = XtVaCreateWidget ("form", xmFormWidgetClass, pane,
    XmNfractionBase, 10,
    NULL);

  button_widget = XtVaCreateManagedWidget ("Validate",
    xmPushButtonGadgetClass, form,
    XmNtopAttachment, XmATTACH_FORM,
    XmNbottomAttachment, XmATTACH_FORM,
    XmNleftAttachment, XmATTACH_POSITION,
    XmNleftPosition, 0,
    XmNrightAttachment, XmATTACH_POSITION,
    XmNrightPosition, 5,
    XmNshowAsDefault,  True,
    XmNdefaultButtonShadowThickness, 1,
    NULL);

  XtAddCallback (button_widget, XmNactivateCallback, validate_cb, NULL);

  button_widget = XtVaCreateManagedWidget ("Quit",
    xmPushButtonGadgetClass, form,
    XmNtopAttachment, XmATTACH_FORM,
    XmNbottomAttachment, XmATTACH_FORM,
    XmNleftAttachment, XmATTACH_POSITION,
    XmNleftPosition, 5,
    XmNrightAttachment, XmATTACH_POSITION,
    XmNrightPosition, 10,
    XmNshowAsDefault,  False,
    XmNdefaultButtonShadowThickness, 1,
    NULL);

  XtAddCallback (button_widget, XmNactivateCallback, quit_cb, NULL);

  XtManageChild (form);
  XtVaGetValues (button_widget, XmNheight, &h, NULL);
  XtVaSetValues (form, XmNpaneMaximum, h, XmNpaneMinimum, h, NULL);

  XtManageChild (pane);

  XtRealizeWidget (toplevel);
  XtAppMainLoop (app);
}

static void message(const char *message);

static void print_license_result (enum license_check_result lcr)
{
   switch (lcr) {
     case INVALID: 
       printf(LICENSE_ERROR_INVALID);
       break;
     case INSTALLDATE: 
       printf(LICENSE_ERROR_INSTALL);
       break;
     case EXPIRED: 
       printf(LICENSE_ERROR_EXPIRED);
       break;
     case ILLEGAL_CHARS: 
       printf(LICENSE_ERROR_CHARS);
       break;
     case OK: 
       printf("OK");
       break;
     case WRONG_EDITION: 
       printf(LICENSE_ERROR_VERSION);
       break;
     case NOT_FOUND: 
       printf("NOT_FOUND");
       break;
     case INTERNAL_ERROR: 
       printf("INTERNAL_ERROR");
       break;
    };

}

static void message_license_result (enum license_check_result lcr)
{
   switch (lcr) {
     case INVALID: 
       message (LICENSE_ERROR_INVALID);
       break;
     case INSTALLDATE: 
       message(LICENSE_ERROR_INSTALL);
       break;
     case EXPIRED: 
       message(LICENSE_ERROR_EXPIRED);
       break;
     case ILLEGAL_CHARS: 
       message(LICENSE_ERROR_CHARS);
       break;
     case OK: 
       message("OK");
       break;
     case WRONG_EDITION: 
       message(LICENSE_ERROR_VERSION);
       break;
     case NOT_FOUND: 
       message("NOT_FOUND");
       break;
     case INTERNAL_ERROR: 
       message("INTERNAL_ERROR");
       break;
    };
}

static void validate_cb(Widget widget, XtPointer client_data, XtPointer call_data)
{
  char *name;
  char *code;
  enum license_check_result license_validation_result = INVALID; /* default */
  char * output = NULL;

  name = XmTextGetString(text_name);
  code = XmTextGetString(text_code);


  if (strlen(name) || strlen(code)) {
     /* input empty => personal edition -- do nothing */

     license_validation_result = license_validate(name, code);

     if (license_validation_result == OK) {
        output = malloc(strlen(name) + DATE_CHARS + EDITION_CHARS);

        /* output to .mlworks_user*: (exp date ^ edition ^ name) */

        strcpy(output,"\0");
        strncat(output,code+CHECK_CHARS+EDITION_CHARS+DATE_CHARS,DATE_CHARS);
        strncat(output,code+CHECK_CHARS,EDITION_CHARS);
        strcat(output,name);

        license_store(output);

        free(output);
        exit(EXIT_SUCCESS); 
     } else message_license_result(license_validation_result);
  } else 
     exit(EXIT_SUCCESS);

  free(output);

  XtFree(name); XtFree(code);
}


/* A simple utility for displaying a modal message box */

static void message_dlg_callback
  (Widget widget, XtPointer client_data, XtPointer call_data)
{
  int *confirmation = (int *)client_data;
  XmAnyCallbackStruct *cbs = (XmAnyCallbackStruct *) call_data;
  *confirmation = (cbs->reason == XmCR_CANCEL);
}

static void message(const char *message)
{
    static Widget dialog;
    XmString text;
    static int confirmation;

    if (!dialog) {
      Arg args[5];
      int n = 0;
      XmString ok = XmStringCreateLocalized((char *)("OK"));
      XtSetArg(args[n], XmNautoUnmanage, False); n++;
      XtSetArg(args[n], XmNcancelLabelString, ok); n++;
      dialog = XmCreateMessageDialog(toplevel, (char *)("license_warning"), args, n);
      XtAddCallback(dialog, XmNcancelCallback,
                    message_dlg_callback, &confirmation);
      XtUnmanageChild(XmMessageBoxGetChild(dialog, XmDIALOG_OK_BUTTON));
      XtUnmanageChild(XmMessageBoxGetChild(dialog, XmDIALOG_HELP_BUTTON));
    }
    confirmation = 0;
    text = XmStringCreateLocalized((char *)message);
    XtVaSetValues(dialog, XmNmessageString, text,
                  XmNdialogStyle, XmDIALOG_FULL_APPLICATION_MODAL, NULL);
    XmStringFree (text);
    XtManageChild(dialog);
    XtPopup(XtParent(dialog), XtGrabNone);

    while (confirmation == 0) XtAppProcessEvent(app, XtIMAll);
    XtPopdown(XtParent(dialog));
}

void main(int argc, char *argv[])
{
  char * got_name;
  char * got_code;

  /* Allocate twice as much space as needed for a legal licence code */

  int license_input_buffer = 2 * 
                             (CHECK_CHARS + (2 * DATE_CHARS) + EDITION_CHARS);

  got_name = malloc(license_input_buffer);
  got_code = malloc(license_input_buffer);
  
  if (getenv("DISPLAY") == NULL)
    tty_license(got_name, got_code);
  else
    gui_license(argc, argv);
}
