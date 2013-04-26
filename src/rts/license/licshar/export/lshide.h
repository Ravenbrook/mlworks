/* $HopeName: $
 *
 *  $Log: lshide.h,v $
 *  Revision 1.3  1999/01/04 09:03:00  jamesr
 *  [Bug #30447]
 *  modifications for NT
 *
 * Revision 1.2  1994/06/07  11:28:11  chrism
 * add rcs log
 *
   
   Change history:
    1994-May-27-10:23 chrism
   	Created in licshar
1992-Dec-18-06:10 chrism = obscure signatures and secrets
1992-Dec-18-05:16 chrism = Created

*/
#ifndef _LSHIDE_H
#define _LSHIDE_H

/* Function redefinitions to obscure symbol table */

#if ! (defined(DEBUG) || defined(NOHIDE))

/* API visible symbols */

#define ls_initialise 	bri_size
#define ls_get_license 	s_datut_err
#define ls_update_lic 	ccumu_dat
#define ls_release_lic 	c1_y_data
#define ls_status 	dev_e1_1
#define ls_get_users 	vanta_size

#define ls_do_request 	ft_elem_1
#define ls_do_update 	thu_sizht
#define ls_get_challenge u_siz2_t
#define ls_get_data 	open_nc_err
#define ls_status_val 	find_r_dev
#define ls_upstatus_val bag_errl
#define ls_xstatus_val 	si_datisk
#define ls_get_status 	csh_query
#define ls_get_context	fru_clas

#define LSRequest	devin_siz
#define LSRelease	c_1_empty
#define LS_Update	c2_e1_dump
#define LSGetMessage	nst_nt_end
#define LSQueryLicense	cnt_min_tx

/*  End of API visible symbols */

#define ls_set_challenge	cwb_err_dat
#define ls_dmy_chalchk		devi_chrnic
#define ls_chalchk		fd_u_dat
#define ls_current_master	fi_sizht

#define ls_message_1	cci_clos_1
#define ls_query_1	rch_optyp
#define ls_release_1	rcsin_op
#define ls_request_1	wkwr_c_dat
#define ls_update_1	awok_op
#define ls_users_1	clos_opsh

#define LSChallenge	psmi1_ch
#define LSClient	bir_cl_swtch
#define LSDcurrenthost	blck_opn
#define LSDhostname	ca_clos_opt
#define LSHandle	humi_closify
#define LSIsecret	mountabl_op
#define LSLast_XStatus	pff_dat_1
#define LSNdaemons	halo_sizraph
#define LSNode_data	pmbttl_op
#define LSStatus	opmbo_closy
#define LSUpStatus	stimtabl
#define LSUpdate	pxp_datict
#define LS_Current_Master	f_oparful

#define ls_current_server	uxpu_dat
#define ls_find_server		uxp_daticb
#define ls_get_client	fi_datu1_u
#define ls_get_node_info	ter_break
#define ls_get_port	opn_p_fil

#define LSHQNs		quy_list_op
#define LSInfo		not_lost_pag
#define LSNhosts	bld1_even
#define LicenceSystem	bld2_odd
#define Retry_Timeout	temp_pgb_opt
#define Timeout		updat_ca_clos
#define Update_Retry_Timeout	free_rcsin_op
#define Update_Timeout	bir_1_under

#define store_domain	hndl_halo_err
 
#define free_ls_admin_out tran_awok
#define xdr_addrs	tmp_int_fru

#define xdr_level	lck_bir_out
#define xdr_locknode	mount_wkwr

#define xdr_ls_admin_in	ok1_siz_err
#define xdr_ls_admin_out	max_thru_gb1
#define xdr_ls_product_data	updat_gb1
#define xdr_ls_server_data	locat_quy_list
#define xdr_pfiledat	push_halo_stck
#define xdr_license	find_fru_dat
#define xdr_licensep	hclas_stor
  
#define free_ls_msg_out	psb_info_hld
#define free_ls_query_out	wait_tool_crt
#define free_ls_request_out	loc_len_chr1
#define free_ls_update_out	pass_ov2_bir
#define free_ls_users_out	no_err_ring_op
#define free_ls_verify_data	hndl_ter_brk
#define xdr_ls_challenge_in	util_syntx
#define xdr_ls_challenge_out	nam_currnt_fdd
#define xdr_ls_domain		exe_remot_bp
#define xdr_ls_hqn_state	wait_tst_zerx
#define xdr_ls_msg_out		echo_unkn_par
#define xdr_ls_node_info	lexical_prox
#define xdr_ls_query_in		init_altern_1
#define xdr_ls_query_out	foo_pushd_top
#define xdr_ls_release_in	pop_quy_stk
#define xdr_ls_request_in	loading_wd_stk
#define xdr_ls_request_out	value_encapsit
#define xdr_ls_update_in	quad_lat_spcfy
#define xdr_ls_update_out	expand_halo_stk
#define xdr_ls_users_out	ignore_gb1_err
#define xdr_ls_verify_data	dir_hist_clasfy
#define get_clnt_handle  	mask_hist_stk

#endif

#endif
