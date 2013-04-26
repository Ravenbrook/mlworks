(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
  $Date: 1999/06/16 09:53:17 $
  $Revision: 1.1 $
   Purpose of this file: Functions related to Text Widget Annotations 
                         in Widget Tree

   *********************************************************************** *)

require "basic_types";
require "paths";
require "annotation";
require "widget_tree";
require "annotation_tree_sig";

structure AnnotationTree : ANNOTATION_TREE =
struct


local open BasicTypes in


exception ANNOTATION_TREE of string

fun get wid tn =
    let
	val widg = WidgetTree.getWidgetGUI wid
	val an  = Annotation.get widg tn
    in
	an
    end

fun upd wid tn an =
    let
	val widg  = WidgetTree.getWidgetGUI wid
	val nwidg = Annotation.upd widg tn an
    in
	WidgetTree.updWidgetGUI nwidg
    end


(* ### das ist noch falsch !!! *)
(* jetzt ist es besser --- aber ist es auch wirklich richtig ? *)
fun add wid (an as (TAWidget _)) =
    let
	val (win,p) = Paths.getIntPathGUI wid
	val np      = p ^ ".txt." ^ (Annotation.selAnnotationWidId an)
	val wids    = Annotation.selAnnotationWidgets an
	val widg    = WidgetTree.getWidgetGUI wid
	val nwidg   = Annotation.add WidgetTree.packWidget widg an
    in
	(WidgetTree.updWidgetGUI nwidg;
	 app (WidgetTree.addWidgetPathAssGUI win np) wids)
    end
  | add wid an =
    let
	val widg  = WidgetTree.getWidgetGUI wid
	val nwidg = Annotation.add WidgetTree.packWidget widg an
    in
	WidgetTree.updWidgetGUI nwidg
    end

fun delete wid tn =
    let
	val widg           = WidgetTree.getWidgetGUI wid
	val nwidg          = Annotation.delete WidgetTree.deleteWidgetGUI widg tn
    in
	WidgetTree.updWidgetGUI nwidg
    end


end

fun getConfigure wid tn =
    let
	val widg = WidgetTree.getWidgetGUI wid
	val an   = Annotation.get widg tn
	val cl   = Annotation.selAnnotationConfigure an
    in
	cl
    end

fun addConfigure wid tn cf =
    let
	val widg  = WidgetTree.getWidgetGUI wid
	val nwidg = Annotation.addAnnotationConfigure widg tn cf
    in
	WidgetTree.updWidgetGUI nwidg
    end

fun getBinding wid tn =
    let
	val widg = WidgetTree.getWidgetGUI wid
	val an   = Annotation.get widg tn
	val bl   = Annotation.selAnnotationBinding an
    in
	bl
    end

fun addBinding wid tn bi =
    let
	val widg  = WidgetTree.getWidgetGUI wid
	val nwidg = Annotation.addAnnotationBinding widg tn bi
    in
	WidgetTree.updWidgetGUI nwidg
    end


fun readSelection wid =
    let
	val widg = WidgetTree.getWidgetGUI wid
	val ml   = Annotation.readSelection widg
    in
	ml
    end

fun readMarks wid =
    let
	val widg = WidgetTree.getWidgetGUI wid
	val ml   = Annotation.readMarks widg
    in
	ml
    end



end
