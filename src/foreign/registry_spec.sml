
require "__stub_gen_input";
require "__stub_gen";

local

  open StubGenInput

  val --> = CfunctionT
  infix 2 -->
  val op * = CptrT
  nonfix *
  val :- = Cdecl
  infix 1 :-
  val A = CdefaultAT 	(* Default argument declaration *)
  val N = Normal 		(* Result type *)

  val CstringT = CarrayT (NONE, CcharT SIGNED)

  val c_int = CintT (SIGNED, INT)
  val c_uint = CintT (UNSIGNED, INT)
  val c_long = CintT (SIGNED, LONG)
  val c_ulong = CintT (UNSIGNED, LONG)
  val c_char = CcharT SIGNED
  val c_uchar = CcharT UNSIGNED
  val c_short = CintT (SIGNED, SHORT)

  val HKEY = CstructT "HKEY"
  val VALENT = CstructT "VALENT"
  val securityAttr = CstructT "SECURITY_ATTRIBUTES"

  fun testResult funStr = 
	Exception(c_long, "$ <> ERROR_SUCCESS", 
		  "RegistryError (\"" ^funStr^ "failed with value: \" ^ C'.Long.toString $)")

in

  val input = 
	[CstructD ("HKEY", []),
	 CstructD ("VALENT", 
	    [("ve_valuename", CstringT),
	     ("ve_valuelen", c_ulong),
	     ("ve_valueptr", c_ulong),
	     ("ve_type", c_ulong)]),
	 CstructD ("SECURITY_ATTRIBUTES", 
	    [("nLength", c_ulong),
	     ("lpSecurityDescriptor", *CvoidT),
	     ("bInheritHandle", c_int)]),

	 CexnD ("RegistryError of string"),

	 Cdecl ("ERROR_SUCCESS", c_long),

	 Cdecl ("HKEY_CLASSES_ROOT", HKEY),
	 Cdecl ("HKEY_CURRENT_USER", HKEY),
	 Cdecl ("HKEY_LOCAL_MACHINE", HKEY),
	 Cdecl ("HKEY_USERS", HKEY),

	 Cdecl ("KEY_ALL_ACCESS", c_ulong),
	 Cdecl ("KEY_CREATE_LINK", c_ulong),
	 Cdecl ("KEY_CREATE_SUB_KEY", c_ulong),
	 Cdecl ("KEY_ENUMERATE_SUB_KEYS", c_ulong),
	 Cdecl ("KEY_EXECUTE", c_ulong),
	 Cdecl ("KEY_NOTIFY", c_ulong),
	 Cdecl ("KEY_QUERY_VALUE", c_ulong),
	 Cdecl ("KEY_READ", c_ulong),
	 Cdecl ("KEY_SET_VALUE", c_ulong),
	 Cdecl ("KEY_WRITE", c_ulong),

	 Cdecl ("REG_BINARY", c_ulong),
	 Cdecl ("REG_DWORD", c_ulong),
	 Cdecl ("REG_DWORD_LITTLE_ENDIAN", c_ulong),
	 Cdecl ("REG_DWORD_BIG_ENDIAN", c_ulong),
	 Cdecl ("REG_EXPAND_SZ", c_ulong),
	 Cdecl ("REG_LINK", c_ulong),
	 Cdecl ("REG_MULTI_SZ", c_ulong),
	 Cdecl ("REG_NONE", c_ulong),
	 Cdecl ("REG_RESOURCE_LIST", c_ulong),
	 Cdecl ("REG_SZ", c_ulong),

	 Cdecl ("REG_WHOLE_HIVE_VOLATILE", c_ulong),

	 "MoveFile" :- [A CstringT, A CstringT] --> N c_int,
	 "RegCloseKey" :- [A HKEY] --> testResult "RegCloseKey",
	 "RegConnectRegistry" :- 
	    [A CstringT, A HKEY, A ( *HKEY)] --> testResult "RegConnectRegistry",
	 "RegCreateKey" :- 
	    [A HKEY, A CstringT, CptrAT (HKEY, OUT)] --> testResult "RegCreateKey",
	 "RegDeleteKey" :- [A HKEY, A CstringT] --> testResult "RegDeleteKey",
	 "RegDeleteValue" :- [A HKEY, A CstringT] --> testResult "RegDeleteValue",
	 "RegEnumKey" :-
	    [A HKEY, A c_ulong, A CstringT, A c_ulong] --> testResult "RegEnumKey",
	 "RegEnumValue" :-
	    [A HKEY, A c_ulong, A CstringT, A ( *c_ulong), A ( *c_ulong), CptrAT (c_ulong, OUT), A ( *c_uchar), A ( *c_ulong)] --> testResult "RegEnumValue",
	 "RegFlushKey" :- [A HKEY] --> testResult "RegFlushKey",
	 "RegLoadKey" :- [A HKEY, A CstringT, A CstringT] --> testResult "RegLoadKey",
	 "RegOpenKey" :-
	    [A HKEY, A CstringT, CptrAT (HKEY, OUT)] --> testResult "RegOpenKey",
	 "RegOpenKeyEx" :-
	    [A HKEY, A CstringT, A c_ulong, A c_ulong, CptrAT (HKEY, OUT)] --> 
		testResult "RegOpenKey",
	 "RegQueryMultipleValues" :-
	    [A HKEY, A (CarrayT (NONE, VALENT)), A c_ulong, A CstringT, A ( *c_ulong)] -->
		testResult "RegQueryMultipleValues",
	 "RegQueryValueEx" :-
	    [A HKEY, A CstringT, A ( *c_ulong), CptrAT (c_ulong, OUT),
		CptrAT (CstringT, IN_OUT), CptrAT (c_long, IN_OUT)] -->
		testResult "RegQueryValueEx",
	 "RegReplaceKey" :-
	    [A HKEY, A CstringT, A CstringT, A CstringT] --> testResult "RegReplaceKey",
	 "RegRestoreKey" :- 
	    [A HKEY, A CstringT, A c_ulong] --> testResult "RegRestoreKey",
	 "RegSaveKey" :-
	    [A HKEY, A CstringT, A ( *securityAttr)] --> testResult "RegSaveKey",
	 "RegSetValue" :-
	    [A HKEY, A CstringT, A c_ulong, A CstringT, A c_ulong] -->
		testResult "RegSetValue",
	 "RegSetValueEx" :-
	    [A HKEY, A CstringT, A c_ulong, A c_ulong, A ( *(CconstT c_uchar)), A c_ulong]
	     --> testResult "RegSetValueEx",
	 "RegUnLoadKey" :- [A HKEY, A CstringT] --> testResult "RegUnLoadKey"]

  fun genRegistryFiles () = 
	StubGen.generateStubs
	       {name="winreg", 
		input=input, 
		c_lib_name="winreg_stub.dll", 
		c_headers=["<windows.h>"], 
		ann_fn_args=true}

end

