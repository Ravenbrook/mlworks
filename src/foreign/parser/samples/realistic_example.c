/*
 * Foreign Interface parser: Realistic sample file
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: realistic_example.c,v $
 * Revision 1.1  1997/08/22 09:44:34  brucem
 * new unit
 * Test for Foreign Interface parser based on Unix ndbm.h.
 *
 *
 */

  typedef struct {} DBM;

  typedef struct {
    char * dptr;
    int    dsize;
  } datum;

  const int DBM_INSERT = 0;
  const int DBM_REPLACE = 1;

  DBM   * dbm_open(char * , int, int);
  void    dbm_close(DBM *);
  datum   dbm_fetch(DBM *, datum);
  datum   dbm_firstkey(DBM *);
  datum   dbm_nextkey(DBM *);
  int     dbm_delete(DBM *, datum);
  int     dbm_store(DBM *, datum, datum, int);
  int	  dbm_error(DBM *);
  int	  dbm_clearerr(DBM *);
