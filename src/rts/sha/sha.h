#ifndef SHA_H
#define SHA_H

/* NIST Secure Hash Algorithm */
/* heavily modified from Peter C. Gutmann's implementation */

/* Useful defines & typedefs */

typedef unsigned char BYTE;
typedef unsigned long ULONG;

#define SHA_BLOCKSIZE		64
#define SHA_DIGESTSIZE		20

typedef struct {
    ULONG digest[5];		/* message digest */
    ULONG count_lo, count_hi;	/* 64-bit bit count */
    ULONG data[16];		/* SHA data buffer */
} SHA_INFO;

void sha_init(SHA_INFO *);
void sha_update(SHA_INFO *, BYTE *, int);
void sha_final(SHA_INFO *);

void sha_string(SHA_INFO *, char *, int);
void sha_stream(SHA_INFO *, FILE *);
void sha_print(SHA_INFO *);
char *sha_sprint(SHA_INFO *);

#endif /* SHA_H */
