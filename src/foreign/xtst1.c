#include <Xm/Xm.h>
#include <Xm/Label.h>
#include <stdlib.h>
#include <stdio.h>


/* Based on Young 2nd Edition */


static Widget       the_shell;
static XtAppContext the_app;


void init_app(char *name)
{
   int            argc   = 0;
   char           **argv = NULL;

printf("init_app : started \n");

   the_shell = XtAppInitialize(&the_app, name, NULL, 0, &argc, argv, NULL, NULL, 0);

printf("init_app : XtAppInitialize called ...\n");

printf("init_app : Calling XtAppMainLoop ...\n");

   XtAppMainLoop( the_app );
}


void demo_box(char *str)
{
   Widget         msg;
   XmString       xmstr;

   xmstr = XmStringCreateLtoR( str, XmFONTLIST_DEFAULT_TAG);

printf("demo_box : XmStringCreatedLtoR called ...\n");

   msg = XtVaCreateManagedWidget( "message",
                                  xmLabelWidgetClass, the_shell,
                                  XmNlabelString,     xmstr,
                                  XmNx,   200,
                                  XmNy,   300,
                                  NULL );

printf("demo_box : XtVaCreatedManagedWidget called ...\n");

   XmStringFree ( xmstr );

printf("demo_box : XmStringFree called ...\n");

   XtRealizeWidget( msg );

printf("demo_box : XmRealizeWidget called ...\n");

}
