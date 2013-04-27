(*
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
 * $Log: load.sml,v $
 * Revision 1.2  1998/06/03 11:46:15  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
use "system.sml";
use "sys/time.sml";
use "sys/sys.sig";
use "sys/sys_mlworks.sml";
use "sys/location.sml";
use "sys/hasher.sml";
use "sys/link-sys.sml";
use "pretty/formatter.sig";
use "pretty/formatter.fun";
use "pretty/link-pretty.sml";
use "mlyacc/base.sml";
use "lam/term.sig";
use "lam/uutils.sig";
use "lam/trail.sig";
use "lam/sb.sig";
use "lam/reduce.sig";
use "lam/symbols.sig";
use "lam/print.sig";
use "lam/uutils.fun";
use "lam/skeleton.sig";
use "lam/constraints.sig";
use "lam/unify_skeleton.sig";
use "lam/switch.sig";
use "lam/unify.sig";
use "lam/basic.sig";
use "lam/unify_skeleton.fun";
use "lam/unify_llambda.fun";
use "lam/type_recon.sig";
use "lam/type_depend.sig";
use "lam/naming.sig";
use "lam/equal.sig";
use "lam/type_recon.fun";
use "lam/trail.fun";
use "lam/term.fun";
use "lam/symtab.sig";
use "lam/sign.sig";
use "lam/symtab_init.fun";
use "hash/hash.sig";
use "lam/symtab.fun";
use "lam/symbols_mono.fun";
use "lam/skeleton.fun";
use "lam/simplify_equals.fun";
use "lam/sign.fun";
use "lam/sb.fun";
use "lam/redundancy.sig";
use "lam/redundancy.fun";
use "lam/reduce.fun";
use "lam/print_var_verbose.fun";
use "lam/print_var.fun";
use "lam/print_term.fun";
use "lam/print_norm.fun";
use "lam/print_extend.fun";
use "lam/print_ellide.fun";
use "lam/parse.sig";
use "lam/naming.fun";
use "lam/interface.sig";
use "lam/interface.fun";
use "lam/equal.fun";
use "lam/constraints_datatypes.fun";
use "lam/constraints.fun";
use "lam/basic.fun";
use "lam/absyn.sig";
use "lam/absyn.fun";
use "hash/hash.sml";
use "elf/progtab.sig";
use "elf/store.sig";
use "elf/solver.sig";
use "elf/elf_front_end.sig";
use "elf/store.fun";
use "elf/specials.sig";
use "elf/specials.fun";
use "elf/solver_stats.sig";
use "elf/solver_stats.fun";
use "elf/solver.fun";
use "elf/progtab.fun";
use "elf/parse_core.fun";
use "elf/grammar/elf_grm.sig";
use "elf/grammar/elf_lex.sml";
use "elf/elf_absyn.sig";
use "elf/grammar/elf_grm.sml";
use "elf/elf_parse.sig";
use "elf/elf_parse.fun";
use "elf/elf_front_end.fun";
use "elf/elf_depend.fun";
use "elf/elf_absyn.fun";
use "elf/elf.sig";
use "elf/elf.fun";
use "elf/link-elf.sml";
