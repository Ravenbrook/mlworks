The ndbm example consists of creating a simple telephone database
which uses ndbm to store the telephone numbers.  It shows the
following parts of the foreign interface :-

 - calling C functions from ML.
 - passing C structures by value from ML to C.
 - returning C structures by value from C to ML.
 - passing pointers to C structures from ML to C.
 - returning pointers to C structures from C to ML.
 - allocating C structures from within ML.
 - creating a standalone executable which uses a dynamically loaded
   library.
 - calling routines defined in libc.


The first step to running the example is to follow the instructions
in the README contained in enclosing directory about how set up any
necessary values that the example requires and building the library
that the example requires.

Once the library has been built, start MLWorks and create a listener
and load in the phones code into MLWorks by doing :- 

	Shell.File.loadSource "__phones";

This should create an executable called 'phones' which is a simple
telephone database.

For example, to create a database called 'phones.db' using the data in
the file phones.dat, use the '-c' option :-

  $ ./phones -pass args -c phones.dat phones.db args

To check that the data has been read in correctly, you can dump it out
again using the '-d' option :-

  $ ./phones -pass args -d phones.db args
  matthew 3869
  andrew 8053
  dave 1564
  jon 3838

To locate the number of person, use the '-l' option :-

  $ ./phones -pass args -l andrew phones.db args
  andrew 8053

If the person is not in the database :-

  $ ./phones -pass args -l stephen phones.db args
  Sorry, no number available for stephen

or you only use a prefix of the name :-

  $ ./phones -pass args -l mat phones.db args
  Sorry, no number available for mat

then you get a message indicating the person is not in the database.


To remove a person from the database, use the '-r' option :-

  $ ./phones -pass args -r andrew phones.db args

If all goes well as in the above case, then no output is generated.
If you try and remove the entry for a person that does not exist, then
a message indicating that the person is not in the database is output.

  $ ./phones -pass args -r stephen phones.db args
  Sorry, cannot remove stephenb from phones.db since stephen is not in the database


To add a person to the database, use the '-a' option :-

  $ ./phones -pass args -a stephen 8021 phones.db args

If person with that name is already in the database, then the entry
is not added :-

  $ ./phones -pass args -a andrew 7645 phones.db args
  Sorry, cannot add andrew since it is already in the database

To change a person's number you must remove them and then add add them
with the new number.  As an exercise, try modifying the code so that
adding an item always overwrites the existing entry.
