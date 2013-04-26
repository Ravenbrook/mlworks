#include <Xm/Xm.h>
#include <Xm/Label.h>
#include <stdlib.h>
#include <stdio.h>   /* SOLARIS */


/* Based on Young 2nd Edition */

void demo_box(char *str)
{
   Widget         shell, msg;
   XtAppContext   app;
   XmString       xmstr;
   int            argc;
   char           **argv = NULL;

   argc = 0;

printf("demo_box : started \n");
printf("demo_box : str = %s\n", str);

   shell = XtAppInitialize(&app, "DemoBox", NULL, 0, &argc, argv, NULL, NULL, 0);

printf("demo_box : XtAppInitialize called ...\n");

   xmstr = XmStringCreateLtoR(str, XmFONTLIST_DEFAULT_TAG);

printf("demo_box : XmStringCreatedLtoR called ...\n");

   msg = XtVaCreateManagedWidget( "message",
                                  xmLabelWidgetClass, shell,
                                  XmNlabelString,     xmstr,
                                  XmNx,   200,
                                  XmNy,   300,
                                  NULL );

printf("demo_box : XtVaCreatedManagedWidget called ...\n");

   XmStringFree ( xmstr );

printf("demo_box : XmStringFree called ...\n");

   XtRealizeWidget( shell );

printf("demo_box : XmRealizeWidget called ...\n");

   XtAppMainLoop( app );

printf("demo_box : XtAppMainLoop called ...\n");

}
