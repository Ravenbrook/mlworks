/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * Constants to do with the Harlequin Dylan registration mechanism
 *
 * $Log: dylan_mklic.h,v $
 * Revision 1.5  1999/06/16 23:56:50  palter
 * Add 2.1 as a valid release ...
 *
 * Revision 1.4  1998/09/29  20:33:59  palter
 * Recognize 1.1.1, 1.2, and 2.0 releases.
 *
 * Revision 1.3  1998/06/04  17:27:38  palter
 * Recognize 1.0.1 and 1.1 releases
 *
 * Revision 1.2  1998/02/25  23:39:34  palter
 * New serial number based licensing scheme
 *
 * Revision 1.1  1997/11/20  16:22:07  palter
 * new unit
 * Generator of license keys for Harlequin Dylan
 *
 *
 */

#ifndef dylan_mklic_h
#define dylan_mklic_h

#define RELEASE_1_0   "0100"
#define RELEASE_1_0_1 "0101"
#define RELEASE_1_1   "0110"
#define RELEASE_1_1_1 "0111"
#define RELEASE_1_2   "0120"
#define RELEASE_2_0   "0200"
#define RELEASE_2_1   "0210"

#define PERSONAL      "HDPER"
#define PROFESSIONAL  "HDPRO"
#define ENTERPRISE    "HDENT"
#define INTERNAL      "HDTNG"

/* Users are given a serial number and a license key.

   The serial number format is "HDeee-rrrr-ppppssssssss" where
     "eee" is PER, PRO, ENT, or TNG representing the Personal, Professional,
       Enterprise, or Internal editions, respectively.
     "rrrr" is the release of the product.
     "pppp" is a three or four digit prefix.  For serial numbers generated 
       on the fly by the Web ordering system, this is the month and last two
       digits of the year (e.g., "298" or "1203").  For serial numbers
       generated in batches for inclusion with prepackaged product, this is
       a value in the range "2000" to "9999", inclusive.
     "ssssssss" is a nine or eight digit serial number.  (The total number
       of digits in the prefix plus serial number is always 12.)  It is the
       number of tenths of a second since the beginning of the month in
       which the serial number was generated.  (For batches, the first serial
       number is computed as given; the remaining numbers in the batch are
       just the following numbers in sequence.)

   The license key format is "kkkkkkkkkkkkeeee" where
     "eee" is a hexadecimal encoding of the serial number's expiration date.
       If the serial number does not expire, "0000" is used.  Otherwise, the
       value encoded is
         512 * (year - 1990) + 32 * month + day-of-month
     "kkkkkkkkkkkk" are hex digits 8 through 19 (i.e., 12 digits) of the NIST
       SHA hash of serial number and encoded expiration date.

   For example,

      dylan_mklic personal 1.0 none
        Serial number: HDPER-0100-298021447160
        License key: 64814d3fea240000

      dylan_mklic batch 5 2001 professional 1.0 60
	HDPRO-0100-200121447700  0f69d2e2c77d109a
	HDPRO-0100-200121447701  d7d97a2670d9109a
	HDPRO-0100-200121447702  5731f641bf8a109a
	HDPRO-0100-200121447703  3468d056ed52109a
	HDPRO-0100-200121447704  407277380e18109a
 */

#define CHECK_CHARS_START  8
#define CHECK_CHARS_LENGTH 12

#endif
