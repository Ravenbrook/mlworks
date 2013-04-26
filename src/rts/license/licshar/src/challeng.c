/* $HopeName: $
 *
 * $Log: challeng.c,v $
 * Revision 1.6  1999/01/04 09:03:04  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.5  1994/05/17  21:50:28  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
   1993-Oct-9-14:38 chrism
        include netinet/in.h for htonl on snake
   1993-Oct-8-16:03 chrism
        add byteordering so that works properly on big and little
        endians
1992-Oct-16-13:22 chrism = adding std types
1992-Oct-7-12:23 chrism = Created

*/
#include "std.h"

#include "platform.h"

#ifdef WIN32
#include <winsock2.h>
#endif

#ifdef UNIX
#include <netinet/in.h>
#endif

#include "ls.h"
#include "md4.h"
#include "challeng.h"

/* 
 * Take up the challenge of the license server client, 
 * and return our response.
 */

uint32 fXOR();

/* Store WORD at PTR, *** ALWAYS LSB first ie at lowest address ****/

#ifdef highbytefirst
#define STORE_W(ptr, word) \
(ptr)[0] = (word); \
(ptr)[1] = ((word) >> 8); \
(ptr)[2] = ((word) >> 16); \
(ptr)[3] = ((word) >> 24)
  /* hi byte first */
#else
#define STORE_W(ptr, word) \
  (ptr)[0] = ((word) >> 24);  \
(ptr)[1] = ((word) >> 16); \
  (ptr)[2] = ((word) >> 8); \
(ptr)[3] = (word)
    /* lo byte first */
#endif

void do_challenge(uint32 data_len, uint8 *data, uint32 secret_len, 
                  uint32 *secretp, uint8 *out, MDstruct *MDp)
{
  uint32 secret = *secretp;
  uint8 xor_bytes[MAX_CHUNK];
  uint8 *xorbuf = xor_bytes;
  uint32  xor_len = 0;
  
  secret = htonl( secret );
  
  if( data_len > 0){
    
    xor_len = fXOR(data_len, data, secret_len, &secret, xor_bytes);
    
    while (xor_len >=64){
      MDupdate(MDp, xorbuf, 512);
      xor_len -= 64;
      xorbuf += 64;
    }
    /****** If passed a full buffer return. NB Must be called again to
     *   complete in this case.
     */
    if( data_len == MAX_CHUNK ) return; 
  }
  
  /* Only does this on last bit of data */
  
  MDupdate(MDp, xorbuf, xor_len << 3);

  STORE_W(out,    MDp->buffer[0]);
  STORE_W(out+4,  MDp->buffer[1]);
  STORE_W(out+8,  MDp->buffer[2]);
  STORE_W(out+12, MDp->buffer[3]);
}
        
/*
 * implementation of the fXOR() algorithm for the license server
 * 
 */

uint32 fXOR(uint32 clen, uint8 *challenge, uint32 slen, uint8 *secret, uint8 *result)
{
  uint32 i, j;
  
  if (slen > clen)
    {
      for (i = 0, j = 0; i < slen; i ++)
        {
          result[i] = secret[i] ^ challenge[j++];
          if (j >= clen) j = 0;
        }
      return slen;
    }
  else
    {
      for (i = 0, j = 0; i < clen; i ++)
        {
          result[i] = secret[j++] ^ challenge[i];
          if( j >= slen) j = 0;
        }
      return clen;
    }
  /*NOTREACHED*/
}

