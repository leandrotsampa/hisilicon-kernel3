/****************************************************************************
 * Ralink Tech Inc.
 * 4F, No. 2 Technology 5th Rd.
 * Science-based Industrial Park
 * Hsin-chu, Taiwan, R.O.C.
 * (c) Copyright 2002, Ralink Technology, Inc.
 *
 * All rights reserved. Ralink's source code is an unpublished work and the
 * use of a copyright notice does not imply otherwise. This source code
 * contains confidential trade secret material of Ralink Tech. Any attemp
 * or participation in deciphering, decoding, reverse engineering or in any
 * way altering the source code is stricitly prohibited, unless the prior
 * written consent of Ralink Technology, Inc. is obtained.
 ****************************************************************************

    Module Name:
	cmm_profile.c

    Abstract:

    Revision History:
    Who          When          What
    ---------    ----------    ----------------------------------------------
 */

#include "rt_config.h"

#define ETH_MAC_ADDR_STR_LEN 17	/* in format of xx:xx:xx:xx:xx:xx */

/* We assume the s1 is a sting, s2 is a memory space with 6 bytes. and content of s1 will be changed.*/
BOOLEAN rtstrmactohex(PSTRING s1, PSTRING s2)
{
	int i = 0;
	PSTRING ptokS = s1, ptokE = s1;

	if (strlen(s1) != ETH_MAC_ADDR_STR_LEN)
		return FALSE;

	while ((*ptokS) != '\0') {
		ptokE = strchr(ptokS, ':');
		if (ptokE != NULL)
			*ptokE++ = '\0';
		if ((strlen(ptokS) != 2) || (!isxdigit(*ptokS)) || (!isxdigit(*(ptokS + 1))))
			break;	/* fail */
		AtoH(ptokS, (PUCHAR) & s2[i++], 1);
		ptokS = ptokE;
		if (ptokS == NULL)
			break;
		if (i == 6)
			break;	/* parsing finished */
	}

	return (i == 6 ? TRUE : FALSE);

}

#define ASC_LOWER(_x)	((((_x) >= 0x41) && ((_x) <= 0x5a)) ? (_x) + 0x20 : (_x))
/* we assume the s1 and s2 both are strings.*/
BOOLEAN rtstrcasecmp(PSTRING s1, PSTRING s2)
{
	PSTRING p1 = s1, p2 = s2;
	CHAR c1, c2;

	if (strlen(s1) != strlen(s2))
		return FALSE;

	while (*p1 != '\0') {
		c1 = ASC_LOWER(*p1);
		c2 = ASC_LOWER(*p2);
		if (c1 != c2)
			return FALSE;
		p1++;
		p2++;
	}

	return TRUE;
}

/* we assume the s1 (buffer) and s2 (key) both are strings.*/
PSTRING rtstrstruncasecmp(PSTRING s1, PSTRING s2)
{
	INT l1, l2, i;
	char temp1, temp2;

	l2 = strlen(s2);
	if (!l2)
		return (char *)s1;

	l1 = strlen(s1);

	while (l1 >= l2) {
		l1--;

		for (i = 0; i < l2; i++) {
			temp1 = *(s1 + i);
			temp2 = *(s2 + i);

			if (('a' <= temp1) && (temp1 <= 'z'))
				temp1 = 'A' + (temp1 - 'a');
			if (('a' <= temp2) && (temp2 <= 'z'))
				temp2 = 'A' + (temp2 - 'a');

			if (temp1 != temp2)
				break;
		}

		if (i == l2)
			return (char *)s1;

		s1++;
	}

	return NULL;		/* not found */
}

 /**
  * strstr - Find the first substring in a %NUL terminated string
  * @s1: The string to be searched
  * @s2: The string to search for
  */
const char *rtstrstr(const char *s1, const char *s2)
{
	INT l1, l2;

	l2 = strlen(s2);
	if (!l2)
		return s1;

	l1 = strlen(s1);

	while (l1 >= l2) {
		l1--;
		if (!memcmp(s1, s2, l2))
			return s1;
		s1++;
	}

	return NULL;
}

/**
 * rstrtok - Split a string into tokens
 * @s: The string to be searched
 * @ct: The characters to search for
 * * WARNING: strtok is deprecated, use strsep instead. However strsep is not compatible with old architecture.
 */
PSTRING __rstrtok;
PSTRING rstrtok(PSTRING s, const PSTRING ct)
{
	PSTRING sbegin, send;

	sbegin = s ? s : __rstrtok;
	if (!sbegin)
		return NULL;

	sbegin += strspn(sbegin, ct);
	if (*sbegin == '\0') {
		__rstrtok = NULL;
		return NULL;
	}

	send = strpbrk(sbegin, ct);
	if (send && *send != '\0')
		*send++ = '\0';

	__rstrtok = send;

	return sbegin;
}

#ifdef CONFIG_AP_SUPPORT
/**
 * delimitcnt - return the count of a given delimiter in a given string.
 * @s: The string to be searched.
 * @ct: The delimiter to search for.
 * Notice : We suppose the delimiter is a single-char string(for example : ";").
 */
static INT delimitcnt(PSTRING s, PSTRING ct)
{
	INT count = 0;
	/* point to the beginning of the line */
	PSTRING token = s;

	for (;;) {
		token = strpbrk(token, ct);	/* search for delimiters */

		if (token == NULL) {
			/* advanced to the terminating null character */
			break;
		}
		/* skip the delimiter */
		++token;

		/*
		 * Print the found text: use len with %.*s to specify field width.
		 */

		/* accumulate delimiter count */
		++count;
	}
	return count;
}
#endif /* CONFIG_AP_SUPPORT */

/*
  * converts the Internet host address from the standard numbers-and-dots notation
  * into binary data.
  * returns nonzero if the address is valid, zero if not.
  */
int rtinet_aton(PSTRING cp, unsigned int *addr)
{
	unsigned int val;
	int base, n;
	STRING c;
	unsigned int parts[4];
	unsigned int *pp = &parts[0];

	for (;;) {
		/*
		 * Collect number up to ``.''.
		 * Values are specified as for C:
		 *     0x=hex, 0=octal, other=decimal.
		 */
		val = 0;
		base = 10;
		if (*cp == '0') {
			if (*++cp == 'x' || *cp == 'X')
				base = 16, cp++;
			else
				base = 8;
		}
		while ((c = *cp) != '\0') {
			if (isdigit((unsigned char)c)) {
				val = (val * base) + (c - '0');
				cp++;
				continue;
			}
			if (base == 16 && isxdigit((unsigned char)c)) {
				val = (val << 4) +
				    (c + 10 - (islower((unsigned char)c) ? 'a' : 'A'));
				cp++;
				continue;
			}
			break;
		}
		if (*cp == '.') {
			/*
			 * Internet format: a.b.c.d a.b.c   (with c treated as 16-bits)
			 * a.b     (with b treated as 24 bits)
			 */
			if (pp >= parts + 3 || val > 0xff)
				return 0;
			*pp++ = val, cp++;
		} else
			break;
	}

	/*
	 * Check for trailing junk.
	 */
	while (*cp)
		if (!isspace((unsigned char)*cp++))
			return 0;

	/*
	 * Concoct the address according to the number of parts specified.
	 */
	n = pp - parts + 1;
	switch (n) {

	case 1:		/* a -- 32 bits */
		break;

	case 2:		/* a.b -- 8.24 bits */
		if (val > 0xffffff)
			return 0;
		val |= parts[0] << 24;
		break;

	case 3:		/* a.b.c -- 8.8.16 bits */
		if (val > 0xffff)
			return 0;
		val |= (parts[0] << 24) | (parts[1] << 16);
		break;

	case 4:		/* a.b.c.d -- 8.8.8.8 bits */
		if (val > 0xff)
			return 0;
		val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
		break;

	default:
		break;
	}

	*addr = OS_HTONL(val);
	return 1;

}

/*
    ========================================================================

    Routine Description:
	Find key section for Get key parameter.

    Arguments:
	buffer                      Pointer to the buffer to start find the key section
	section                     the key of the secion to be find

    Return Value:
	NULL                        Fail
	Others                      Success
    ========================================================================
*/
static const char *RTMPFindSection(IN const char *buffer)
{
	STRING temp_buf[32];
	const char *ptr;

	strcpy(temp_buf, "Default");

	ptr = rtstrstr(buffer, temp_buf);
	if (ptr != NULL)
		return (ptr + strlen("\n"));
	else
		return NULL;
}

/*
    ========================================================================

    Routine Description:
	Get key parameter.

    Arguments:
	key			Pointer to key string
	dest			Pointer to destination
	destsize		The datasize of the destination
	buffer		Pointer to the buffer to start find the key
	bTrimSpace	Set true if you want to strip the space character of the result pattern

    Return Value:
	TRUE                        Success
	FALSE                       Fail

    Note:
	This routine get the value with the matched key (case case-sensitive)
	For SSID and security key related parameters, we SHALL NOT trim the space(' ') character.
    ========================================================================
*/
INT RTMPGetKeyParameter(IN const char *key,
			OUT PSTRING dest,
			IN INT destsize, IN const char *buffer, IN BOOLEAN bTrimSpace)
{
	PSTRING pMemBuf, temp_buf1 = NULL, temp_buf2 = NULL;
	const char *start_ptr, *end_ptr;
	const char *ptr;
	const char *offset = NULL;
	INT len, keyLen;

	keyLen = strlen(key);
	os_alloc_mem_suspend(NULL, (PUCHAR *) &pMemBuf, MAX_PARAM_BUFFER_SIZE * 2);
	if (pMemBuf == NULL)
		return FALSE;

	memset(pMemBuf, 0, MAX_PARAM_BUFFER_SIZE * 2);
	temp_buf1 = pMemBuf;
	temp_buf2 = (PSTRING) (pMemBuf + MAX_PARAM_BUFFER_SIZE);

	/*find section */
	offset = RTMPFindSection(buffer);
	if (offset == NULL) {
		os_free_mem(NULL, (PUCHAR) pMemBuf);
		return FALSE;
	}

	strcpy(temp_buf1, "\n");
	strcat(temp_buf1, key);
	strcat(temp_buf1, "=");

	/*search key */
	start_ptr = rtstrstr(offset, temp_buf1);
	if (start_ptr == NULL) {
		os_free_mem(NULL, (PUCHAR) pMemBuf);
		return FALSE;
	}

	start_ptr += strlen("\n");
	end_ptr = rtstrstr(start_ptr, "\n");
	if (end_ptr == NULL)
		end_ptr = start_ptr + strlen(start_ptr);

	if (end_ptr < start_ptr) {
		os_free_mem(NULL, (PUCHAR) pMemBuf);
		return FALSE;
	}

	NdisMoveMemory(temp_buf2, start_ptr, end_ptr - start_ptr);
	temp_buf2[end_ptr - start_ptr] = '\0';

	start_ptr = rtstrstr(temp_buf2, "=");
	if (start_ptr == NULL) {
		os_free_mem(NULL, (PUCHAR) pMemBuf);
		return FALSE;
	}
	ptr = (start_ptr + 1);
	/*trim special characters, i.e.,  TAB or space */
	while (*start_ptr != 0x00) {
		if (((*ptr == ' ') && bTrimSpace) || (*ptr == '\t'))
			ptr++;
		else
			break;
	}
	len = strlen(start_ptr);

	memset(dest, 0x00, destsize);
	strncpy(dest, ptr, ((len >= destsize) ? destsize : len));

	os_free_mem(NULL, (PUCHAR) pMemBuf);

	return TRUE;
}

#ifdef DOT1X_SUPPORT
/*
    ========================================================================

    Routine Description:
	Get multiple key parameter.

    Arguments:
	key                         Pointer to key string
	dest                        Pointer to destination
	destsize                    The datasize of the destination
	buffer                      Pointer to the buffer to start find the key

    Return Value:
	TRUE                        Success
	FALSE                       Fail

    Note:
	This routine get the value with the matched key (case case-sensitive)
    ========================================================================
*/
static INT RTMPGetKeyParameterWithOffset(IN PSTRING key,
					 OUT PSTRING dest,
					 OUT USHORT * end_offset,
					 IN INT destsize, IN PSTRING buffer, IN BOOLEAN bTrimSpace)
{
	PSTRING temp_buf1 = NULL;
	PSTRING temp_buf2 = NULL;
	PSTRING start_ptr;
	PSTRING end_ptr;
	PSTRING ptr;
	PSTRING offset = 0;
	INT len;

	if (*end_offset >= MAX_INI_BUFFER_SIZE)
		return FALSE;

	os_alloc_mem(NULL, (PUCHAR *) &temp_buf1, MAX_PARAM_BUFFER_SIZE);

	if (temp_buf1 == NULL)
		return FALSE;

	os_alloc_mem(NULL, (PUCHAR *) &temp_buf2, MAX_PARAM_BUFFER_SIZE);
	if (temp_buf2 == NULL) {
		os_free_mem(NULL, (PUCHAR) temp_buf1);
		return FALSE;
	}

	/*find section              */
	if (*end_offset == 0) {
		offset = RTMPFindSection(buffer);
		if (offset == NULL) {
			os_free_mem(NULL, (PUCHAR) temp_buf1);
			os_free_mem(NULL, (PUCHAR) temp_buf2);
			return FALSE;
		}
	} else
		offset = buffer + (*end_offset);

	strcpy(temp_buf1, "\n");
	strcat(temp_buf1, key);
	strcat(temp_buf1, "=");

	/*search key */
	start_ptr = rtstrstr(offset, temp_buf1);
	if (start_ptr == NULL) {
		os_free_mem(NULL, (PUCHAR) temp_buf1);
		os_free_mem(NULL, (PUCHAR) temp_buf2);
		return FALSE;
	}

	start_ptr += strlen("\n");
	end_ptr = rtstrstr(start_ptr, "\n");
	if (end_ptr == NULL)
		end_ptr = start_ptr + strlen(start_ptr);

	if (end_ptr < start_ptr) {
		os_free_mem(NULL, (PUCHAR) temp_buf1);
		os_free_mem(NULL, (PUCHAR) temp_buf2);
		return FALSE;
	}

	*end_offset = end_ptr - buffer;

	NdisMoveMemory(temp_buf2, start_ptr, end_ptr - start_ptr);
	temp_buf2[end_ptr - start_ptr] = '\0';
	len = strlen(temp_buf2);
	strcpy(temp_buf1, temp_buf2);
	start_ptr = rtstrstr(temp_buf1, "=");
	if (start_ptr == NULL) {
		os_free_mem(NULL, (PUCHAR) temp_buf1);
		os_free_mem(NULL, (PUCHAR) temp_buf2);
		return FALSE;
	}

	strcpy(temp_buf2, start_ptr + 1);
	ptr = temp_buf2;
	/*trim space or tab */
	while (*ptr != 0x00) {
		if ((bTrimSpace && (*ptr == ' ')) || (*ptr == '\t'))
			ptr++;
		else
			break;
	}

	len = strlen(ptr);
	memset(dest, 0x00, destsize);
	strncpy(dest, ptr, len >= destsize ? destsize : len);

	os_free_mem(NULL, (PUCHAR) temp_buf1);
	os_free_mem(NULL, (PUCHAR) temp_buf2);
	return TRUE;
}
#endif /* DOT1X_SUPPORT */

static void parse_ack_policy(RTMP_ADAPTER *pAd, PSTRING tmp, const char *src)
{
	PSTRING ptr;
	INT32 i;
	INT ret;
	LONG longtmp;
	/*AckPolicy for AC_BK, AC_BE, AC_VI, AC_VO, [MCC] */
	if (RTMPGetKeyParameter("AckPolicy", tmp, 32, src, TRUE)) {
		for (i = 0, ptr = rstrtok(tmp, ";");
			ptr && i < ARRAY_SIZE(pAd->CommonCfg.AckPolicy);
			ptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(ptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			pAd->CommonCfg.AckPolicy[i] = (UCHAR) longtmp;

			DBGPRINT(RT_DEBUG_OFF, ("AckPolicy[%d]=%d\n", i,
				pAd->CommonCfg.AckPolicy[i]));
		}
	}
}

#ifdef CONFIG_STA_SUPPORT
static inline void RTMPSetSTADefKeyId(RTMP_ADAPTER *pAd, ULONG KeyIdx)
{
	if ((KeyIdx >= 1) && (KeyIdx <= 4))
		pAd->StaCfg.wdev.DefaultKeyId = (UCHAR) (KeyIdx - 1);
	else
		pAd->StaCfg.wdev.DefaultKeyId = 0;
}
#endif /* CONFIG_STA_SUPPORT */

static int rtmp_parse_key_buffer_from_file(IN PRTMP_ADAPTER pAd, IN PSTRING buffer,
					   IN ULONG KeyType, IN INT BSSIdx, IN INT KeyIdx)
{
	PSTRING keybuff;
	/*INT                   i = BSSIdx, idx = KeyIdx, retVal; */
	ULONG KeyLen;
	/*UCHAR         CipherAlg = CIPHER_WEP64; */
	CIPHER_KEY *pSharedKey;

	keybuff = buffer;
	KeyLen = strlen(keybuff);
	pSharedKey = &pAd->SharedKey[BSSIdx][KeyIdx];

	if (((KeyType != 0) && (KeyType != 1)) ||
	    ((KeyType == 0) && (KeyLen != 10) && (KeyLen != 26)) ||
	    ((KeyType == 1) && (KeyLen != 5) && (KeyLen != 13))) {
		DBGPRINT(RT_DEBUG_ERROR, ("Key%dStr is Invalid key length(%ld) or Type(%ld)\n",
					  KeyIdx + 1, KeyLen, KeyType));
		return FALSE;
	} else {
		return RT_CfgSetWepKey(pAd, buffer, pSharedKey, KeyIdx);
	}

}

static void rtmp_read_key_parms_from_file(IN PRTMP_ADAPTER pAd, PSTRING tmpbuf, const char *buffer)
{
	STRING tok_str[16];
	PSTRING macptr;
	INT i = 0, idx;
	ULONG KeyType[HW_BEACON_MAX_NUM];
	ULONG KeyIdx;
	INT ret;
	LONG longtmp;

	NdisZeroMemory(KeyType, sizeof(KeyType));

	/*DefaultKeyID */
	if (RTMPGetKeyParameter("DefaultKeyID", tmpbuf, 25, buffer, TRUE)) {
#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
			for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
			     macptr = rstrtok(NULL, ";"), i++) {
				if (i >= pAd->ApCfg.BssidNum)
					break;
				ret = os_strtol(macptr, 10, &longtmp);
				if (ret < 0) {
					DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
						 __func__, __LINE__, ret));
					return;
				}

				KeyIdx = longtmp;
				if ((KeyIdx >= 1) && (KeyIdx <= 4))
					pAd->ApCfg.MBSSID[i].wdev.DefaultKeyId =
					    (UCHAR) (KeyIdx - 1);
				else
					pAd->ApCfg.MBSSID[i].wdev.DefaultKeyId = 0;

				DBGPRINT(RT_DEBUG_TRACE,
					 ("I/F(ra%d) DefaultKeyID(0~3)=%d\n", i,
					  pAd->ApCfg.MBSSID[i].wdev.DefaultKeyId));
			}
		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			KeyIdx = longtmp;
			RTMPSetSTADefKeyId(pAd, KeyIdx);

			DBGPRINT(RT_DEBUG_TRACE,
				 ("DefaultKeyID(0~3)=%d\n", pAd->StaCfg.wdev.DefaultKeyId));
		}
#endif /* CONFIG_STA_SUPPORT */
	}

	for (idx = 0; idx < 4; idx++) {
		snprintf(tok_str, sizeof(tok_str), "Key%dType", idx + 1);
		/*Key1Type */
		if (RTMPGetKeyParameter(tok_str, tmpbuf, 128, buffer, TRUE)) {
			for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
			     macptr = rstrtok(NULL, ";"), i++) {
				/*
				   do sanity check for KeyType length;
				   or in station mode, the KeyType length > 1,
				   the code will overwrite the stack of caller
				   (RTMPSetProfileParameters) and cause srcbuf = NULL
				 */
				if (i < MAX_MBSSID_NUM(pAd)) {
					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0) {
						DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
							 __func__, __LINE__, ret));
						return;
					}
					KeyType[i] = longtmp;
				}
			}
#ifdef CONFIG_AP_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
				if (TRUE) {
					BOOLEAN bKeyxStryIsUsed = FALSE;

					/* GPRINT(RT_DEBUG_TRACE, ("pAd->ApCfg.BssidNum=%d\n", pAd->ApCfg.BssidNum)); */
					for (i = 0; i < pAd->ApCfg.BssidNum; i++) {
						snprintf(tok_str, sizeof(tok_str), "Key%dStr%d",
							 idx + 1, i + 1);
						if (RTMPGetKeyParameter
						    (tok_str, tmpbuf, 128, buffer, FALSE)) {
							rtmp_parse_key_buffer_from_file(pAd, tmpbuf,
											KeyType[i],
											i, idx);

							if (bKeyxStryIsUsed == FALSE)
								bKeyxStryIsUsed = TRUE;
						}
					}

					if (bKeyxStryIsUsed == FALSE) {
						snprintf(tok_str, sizeof(tok_str), "Key%dStr",
							 idx + 1);
						if (RTMPGetKeyParameter
						    (tok_str, tmpbuf, 128, buffer, FALSE)) {
							if (pAd->ApCfg.BssidNum == 1) {
								rtmp_parse_key_buffer_from_file(pAd,
												tmpbuf,
												KeyType
												[BSS0],
												BSS0,
												idx);
							} else {
								/* Anyway, we still do the
								legacy dissection of the
								whole KeyxStr string. */
								for (i = 0, macptr =
								     rstrtok(tmpbuf, ";"); macptr;
								     macptr =
								     rstrtok(NULL, ";"), i++) {
									rtmp_parse_key_buffer_from_file
									    (pAd, macptr,
									     KeyType[i], i, idx);
								}
							}
						}
					}
				}
			}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
				snprintf(tok_str, sizeof(tok_str), "Key%dStr", idx + 1);
				if (RTMPGetKeyParameter(tok_str, tmpbuf, 128, buffer, FALSE)) {
					rtmp_parse_key_buffer_from_file(pAd, tmpbuf, KeyType[BSS0],
									BSS0, idx);
				}
			}
#endif /* CONFIG_STA_SUPPORT */
		}
	}
}

#ifdef CONFIG_AP_SUPPORT

#ifdef APCLI_SUPPORT
static void rtmp_read_ap_client_from_file(IN PRTMP_ADAPTER pAd,
					  IN PSTRING tmpbuf, IN const char *buffer)
{
	PSTRING macptr = NULL;
	INT i = 0, j = 0, idx;
	UCHAR macAddress[MAC_ADDR_LEN];
	PAPCLI_STRUCT pApCliEntry = NULL;
	ULONG KeyIdx;
	STRING tok_str[16];
	ULONG KeyType[MAX_APCLI_NUM];
	ULONG KeyLen;
	struct wifi_dev *wdev;
	INT ret;
	LONG longtmp;

	NdisZeroMemory(KeyType, sizeof(KeyType));

	/*ApCliEnable */
	if (RTMPGetKeyParameter("ApCliEnable", tmpbuf, 128, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
		     macptr = rstrtok(NULL, ";"), i++) {
			pApCliEntry = &pAd->ApCfg.ApCliTab[i];
			if ((strncmp(macptr, "0", 1) == 0))
				pApCliEntry->Enable = FALSE;
			else if ((strncmp(macptr, "1", 1) == 0))
				pApCliEntry->Enable = TRUE;
			else
				pApCliEntry->Enable = FALSE;

			if (pApCliEntry->Enable) {
				/*pApCliEntry->WpaState = SS_NOTUSE; */
				/*pApCliEntry->PortSecured = WPA_802_1X_PORT_NOT_SECURED; */
				/*NdisZeroMemory(pApCliEntry->ReplayCounter, LEN_KEY_DESC_REPLAY); */
			}
			DBGPRINT(RT_DEBUG_TRACE,
				 ("ApCliEntry[%d].Enable=%d\n", i, pApCliEntry->Enable));
		}
	}
#ifdef APCLI_CONNECTION_TRIAL
	if (RTMPGetKeyParameter("ApCliTrialCh", tmpbuf, 128, buffer, TRUE)) {
		for (i = 0; i < MAX_APCLI_NUM; i++) {
			pApCliEntry = &pAd->ApCfg.ApCliTab[i];
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			pApCliEntry->TrialCh = (UCHAR) longtmp;
			DBGPRINT(RT_DEBUG_TRACE, ("TrialChannel=%d\n", pApCliEntry->TrialCh));
		}

	}
#endif /* APCLI_CONNECTION_TRIAL */

	/*ApCliSsid */
	if (RTMPGetKeyParameter("ApCliSsid", tmpbuf, MAX_PARAM_BUFFER_SIZE, buffer, FALSE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
		     macptr = rstrtok(NULL, ";"), i++) {
			pApCliEntry = &pAd->ApCfg.ApCliTab[i];

			/*Ssid acceptable strlen must be less than 32 and bigger than 0. */
			pApCliEntry->CfgSsidLen = (UCHAR) strlen(macptr);
			if (pApCliEntry->CfgSsidLen > 32) {
				pApCliEntry->CfgSsidLen = 0;
				continue;
			}
			if (pApCliEntry->CfgSsidLen > 0) {
				memcpy(&pApCliEntry->CfgSsid, macptr, pApCliEntry->CfgSsidLen);
				pApCliEntry->Valid = FALSE;	/* it should be set when successfuley association */
			} else {
				NdisZeroMemory(&(pApCliEntry->CfgSsid), MAX_LEN_OF_SSID);
				continue;
			}
			DBGPRINT(RT_DEBUG_TRACE,
				 ("ApCliEntry[%d].CfgSsidLen=%d, CfgSsid=%s\n", i,
				  pApCliEntry->CfgSsidLen, pApCliEntry->CfgSsid));
		}
	}

	/*ApCliBssid */
	if (RTMPGetKeyParameter("ApCliBssid", tmpbuf, MAX_PARAM_BUFFER_SIZE, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
		     macptr = rstrtok(NULL, ";"), i++) {
			pApCliEntry = &pAd->ApCfg.ApCliTab[i];

			if (strlen(macptr) != 17)	/*Mac address acceptable format 01:02:03:04:05:06 length 17 */
				continue;
			if (strcmp(macptr, "00:00:00:00:00:00") == 0)
				continue;
			for (j = 0; j < MAC_ADDR_LEN; j++) {
				AtoH(macptr, &macAddress[j], 1);
				macptr = macptr + 3;
			}
			memcpy(pApCliEntry->CfgApCliBssid, &macAddress, MAC_ADDR_LEN);
			pApCliEntry->Valid = FALSE;	/* it should be set when successfuley association */
		}
	}

	/*ApCliAuthMode */
	if (RTMPGetKeyParameter("ApCliAuthMode", tmpbuf, 255, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
		     macptr = rstrtok(NULL, ";"), i++) {
			pApCliEntry = &pAd->ApCfg.ApCliTab[i];
			wdev = &pApCliEntry->wdev;

			if ((strncmp(macptr, "WEPAUTO", 7) == 0)
			    || (strncmp(macptr, "wepauto", 7) == 0))
				wdev->AuthMode = Ndis802_11AuthModeAutoSwitch;
			else if ((strncmp(macptr, "SHARED", 6) == 0)
				 || (strncmp(macptr, "shared", 6) == 0))
				wdev->AuthMode = Ndis802_11AuthModeShared;
			else if ((strncmp(macptr, "WPAPSK", 6) == 0)
				 || (strncmp(macptr, "wpapsk", 6) == 0))
				wdev->AuthMode = Ndis802_11AuthModeWPAPSK;
			else if ((strncmp(macptr, "WPA2PSK", 7) == 0)
				 || (strncmp(macptr, "wpa2psk", 7) == 0))
				wdev->AuthMode = Ndis802_11AuthModeWPA2PSK;
			else
				wdev->AuthMode = Ndis802_11AuthModeOpen;

			/*pApCliEntry->PortSecured = WPA_802_1X_PORT_NOT_SECURED; */

			DBGPRINT(RT_DEBUG_TRACE,
				 ("I/F(apcli%d) ApCli_AuthMode=%d\n", i, wdev->AuthMode));
			RTMPMakeRSNIE(pAd, wdev->AuthMode, wdev->WepStatus,
				      (i + MIN_NET_DEVICE_FOR_APCLI));
		}

	}

	/*ApCliEncrypType */
	if (RTMPGetKeyParameter("ApCliEncrypType", tmpbuf, 255, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
		     macptr = rstrtok(NULL, ";"), i++) {
			pApCliEntry = &pAd->ApCfg.ApCliTab[i];
			wdev = &pApCliEntry->wdev;

			wdev->WepStatus = Ndis802_11WEPDisabled;
			if ((strncmp(macptr, "WEP", 3) == 0) || (strncmp(macptr, "wep", 3) == 0)) {
				if (wdev->AuthMode < Ndis802_11AuthModeWPA)
					wdev->WepStatus = Ndis802_11WEPEnabled;
			} else if ((strncmp(macptr, "TKIP", 4) == 0)
				   || (strncmp(macptr, "tkip", 4) == 0)) {
				if (wdev->AuthMode >= Ndis802_11AuthModeWPA)
					wdev->WepStatus = Ndis802_11Encryption2Enabled;
			} else if ((strncmp(macptr, "AES", 3) == 0)
				   || (strncmp(macptr, "aes", 3) == 0)) {
				if (wdev->AuthMode >= Ndis802_11AuthModeWPA)
					wdev->WepStatus = Ndis802_11Encryption3Enabled;
			} else {
				wdev->WepStatus = Ndis802_11WEPDisabled;
			}

			pApCliEntry->PairCipher = wdev->WepStatus;
			pApCliEntry->GroupCipher = wdev->WepStatus;
			pApCliEntry->bMixCipher = FALSE;

			/*pApCliEntry->PortSecured = WPA_802_1X_PORT_NOT_SECURED; */

			DBGPRINT(RT_DEBUG_TRACE,
				 ("I/F(apcli%d) APCli_EncrypType = %d\n", i, wdev->WepStatus));
			RTMPMakeRSNIE(pAd, wdev->AuthMode, wdev->WepStatus,
				      (i + MIN_NET_DEVICE_FOR_APCLI));
		}

	}

	/*ApCliWPAPSK */
	if (RTMPGetKeyParameter("ApCliWPAPSK", tmpbuf, 255, buffer, FALSE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
		     macptr = rstrtok(NULL, ";"), i++) {
			int retval = TRUE;

			pApCliEntry = &pAd->ApCfg.ApCliTab[i];

			if ((strlen(macptr) < 8) || (strlen(macptr) > 64)) {
				DBGPRINT(RT_DEBUG_ERROR,
					 ("APCli_WPAPSK_KEY, key string required 8 ~ 64 characters!!!\n"));
				continue;
			}

			NdisMoveMemory(pApCliEntry->PSK, macptr, strlen(macptr));
			pApCliEntry->PSKLen = strlen(macptr);
			DBGPRINT(RT_DEBUG_TRACE,
				 ("I/F(apcli%d) APCli_WPAPSK_KEY=%s, Len=%d\n", i, pApCliEntry->PSK,
				  pApCliEntry->PSKLen));

			if ((pApCliEntry->wdev.AuthMode != Ndis802_11AuthModeWPAPSK) &&
			    (pApCliEntry->wdev.AuthMode != Ndis802_11AuthModeWPA2PSK)) {
				retval = FALSE;
			}
			{
				retval =
				    RT_CfgSetWPAPSKKey(pAd, macptr, strlen(macptr),
						       (PUCHAR) pApCliEntry->CfgSsid,
						       (INT) pApCliEntry->CfgSsidLen,
						       pApCliEntry->PMK);
			}
			if (retval == TRUE) {
				/* Start STA supplicant WPA state machine */
				DBGPRINT(RT_DEBUG_TRACE,
					 ("Start AP-client WPAPSK state machine\n"));
				/*pApCliEntry->WpaState = SS_START;                             */
			}

			/*RTMPMakeRSNIE(pAd, pApCliEntry->AuthMode, pApCliEntry->WepStatus,
			(i + MIN_NET_DEVICE_FOR_APCLI));*/
#ifdef DBG
			DBGPRINT(RT_DEBUG_TRACE, ("I/F(apcli%d) PMK Material =>\n", i));

			for (j = 0; j < 32; j++) {
				DBGPRINT(RT_DEBUG_OFF, ("%02x:", pApCliEntry->PMK[j]));
				if ((j % 16) == 15)
					DBGPRINT(RT_DEBUG_OFF, ("\n"));
			}
			DBGPRINT(RT_DEBUG_OFF, ("\n"));
#endif /* endif */
		}
	}

	/*ApCliDefaultKeyID */
	if (RTMPGetKeyParameter("ApCliDefaultKeyID", tmpbuf, 255, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
		     macptr = rstrtok(NULL, ";"), i++) {
			wdev = &pAd->ApCfg.ApCliTab[i].wdev;
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			KeyIdx = longtmp;
			if ((KeyIdx >= 1) && (KeyIdx <= 4))
				wdev->DefaultKeyId = (UCHAR) (KeyIdx - 1);
			else
				wdev->DefaultKeyId = 0;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("I/F(apcli%d) DefaultKeyID(0~3)=%d\n", i, wdev->DefaultKeyId));
		}
	}

	/*ApCliKeyXType, ApCliKeyXStr */
	for (idx = 0; idx < 4; idx++) {
		snprintf(tok_str, sizeof(tok_str), "ApCliKey%dType", idx + 1);
		/*ApCliKey1Type */
		if (RTMPGetKeyParameter(tok_str, tmpbuf, 128, buffer, TRUE)) {
			for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
				macptr = rstrtok(NULL, ";"), i++) {
				ret = os_strtol(macptr, 10, &longtmp);
				if (ret < 0) {
					DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
						 __func__, __LINE__, ret));
					return;
				}
				KeyType[i] = longtmp;
			}

			snprintf(tok_str, sizeof(tok_str), "ApCliKey%dStr", idx + 1);
			/*ApCliKey1Str */
			if (RTMPGetKeyParameter(tok_str, tmpbuf, 512, buffer, FALSE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";");
				     (macptr && i < MAX_APCLI_NUM);
				     macptr = rstrtok(NULL, ";"), i++) {
					pApCliEntry = &pAd->ApCfg.ApCliTab[i];
					KeyLen = strlen(macptr);
					if (((KeyType[i] == 0) && (KeyLen != 10) && (KeyLen != 26))
					    || ((KeyType[i] != 0) && (KeyLen != 5)
						&& (KeyLen != 13))) {
						DBGPRINT(RT_DEBUG_ERROR,
							 ("I/F(apcli%d) Key%dStr is Invalid key length!\n",
							  i, idx + 1));
					} else {
						if (RT_CfgSetWepKey
						    (pAd, macptr, &pApCliEntry->SharedKey[idx],
						     idx) != TRUE)
							DBGPRINT(RT_DEBUG_ERROR,
								 ("RT_CfgSetWepKey fail!\n"));
					}
				}
			}
		}
	}

	/* ApCliTxMode */
	if (RTMPGetKeyParameter("ApCliTxMode", tmpbuf, 25, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
		     macptr = rstrtok(NULL, ";"), i++) {
			wdev = &pAd->ApCfg.ApCliTab[i].wdev;

			wdev->DesiredTransmitSetting.field.FixedTxMode =
			    RT_CfgSetFixedTxPhyMode(macptr);
			DBGPRINT(RT_DEBUG_TRACE, ("I/F(apcli%d) Tx Mode = %d\n", i,
						  wdev->DesiredTransmitSetting.field.FixedTxMode));
		}
	}

	/* ApCliTxMcs */
	if (RTMPGetKeyParameter("ApCliTxMcs", tmpbuf, 50, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_APCLI_NUM);
		     macptr = rstrtok(NULL, ";"), i++) {
			wdev = &pAd->ApCfg.ApCliTab[i].wdev;

			wdev->DesiredTransmitSetting.field.MCS =
			    RT_CfgSetTxMCSProc(macptr, &wdev->bAutoTxRateSwitch);

			DBGPRINT(RT_DEBUG_TRACE, ("I/F(apcli%d) Tx MCS = %s(%d)\n", i,
						  (wdev->DesiredTransmitSetting.field.MCS ==
						   MCS_AUTO ? "AUTO" : ""),
						  wdev->DesiredTransmitSetting.field.MCS));
		}
	}
#ifdef WSC_AP_SUPPORT

	/* Wsc4digitPinCode = TRUE use 4-digit Pin code, otherwise 8-digit Pin code */
	if (RTMPGetKeyParameter("ApCli_Wsc4digitPinCode", tmpbuf, 32, buffer, TRUE)) {
		ret = os_strtol(macptr, 10, &longtmp);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}
		if (longtmp != 0)	/* Enable */
			pAd->ApCfg.ApCliTab[0].WscControl.WscEnrollee4digitPinCode = TRUE;
		else		/* Disable */
			pAd->ApCfg.ApCliTab[0].WscControl.WscEnrollee4digitPinCode = FALSE;

		DBGPRINT(RT_DEBUG_TRACE,
			 ("I/F(apcli%d) ApCli_Wsc4digitPinCode=%d\n", i,
			  pAd->ApCfg.ApCliTab[0].WscControl.WscEnrollee4digitPinCode));
	}
#endif /* WSC_AP_SUPPORT */

#ifdef UAPSD_SUPPORT
	/*APSDCapable */
	if (RTMPGetKeyParameter("ApCliAPSDCapable", tmpbuf, 10, buffer, TRUE)) {
		pAd->ApCfg.FlgApCliIsUapsdInfoUpdated = TRUE;

		for (i = 0, macptr = rstrtok(tmpbuf, ";");
		     (macptr && i < MAX_APCLI_NUM); macptr = rstrtok(NULL, ";"), i++) {
			pApCliEntry = &pAd->ApCfg.ApCliTab[i];
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			pApCliEntry->UapsdInfo.bAPSDCapable = (UCHAR) longtmp;

			DBGPRINT(RT_DEBUG_ERROR, ("ApCliAPSDCapable[%d]=%d\n", i,
				pApCliEntry->UapsdInfo.bAPSDCapable));
		}
	}
#endif /* UAPSD_SUPPORT */

	/* ApCliNum */
	if (RTMPGetKeyParameter("ApCliNum", tmpbuf, 10, buffer, TRUE)) {
		ret = os_strtol(tmpbuf, 10, &longtmp);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}
		if (longtmp <= MAX_APCLI_NUM) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			pAd->ApCfg.ApCliNum = longtmp;
		}
		DBGPRINT(RT_DEBUG_TRACE, ("I/F(apcli) ApCliNum=%d\n", pAd->ApCfg.ApCliNum));
	}
}
#endif /* APCLI_SUPPORT */

static void rtmp_read_acl_parms_from_file(IN PRTMP_ADAPTER pAd, PSTRING tmpbuf, const char *buffer)
{
	STRING tok_str[32];
	PSTRING macptr;
	INT i = 0, j = 0, idx;
	UCHAR macAddress[MAC_ADDR_LEN];
	INT ret;
	LONG longtmp;

	memset(macAddress, 0, MAC_ADDR_LEN);
	for (idx = 0; idx < MAX_MBSSID_NUM(pAd); idx++) {
		memset(&pAd->ApCfg.MBSSID[idx].AccessControlList, 0, sizeof(RT_802_11_ACL));
		/* AccessPolicyX */
		snprintf(tok_str, sizeof(tok_str), "AccessPolicy%d", idx);
		if (RTMPGetKeyParameter(tok_str, tmpbuf, 10, buffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			switch (longtmp) {
			case 1:	/* Allow All, and the AccessControlList is positive now. */
				pAd->ApCfg.MBSSID[idx].AccessControlList.Policy = 1;
				break;
			case 2:	/* Reject All, and the AccessControlList is negative now. */
				pAd->ApCfg.MBSSID[idx].AccessControlList.Policy = 2;
				break;
			case 0:	/* Disable, don't care the AccessControlList. */
			default:
				pAd->ApCfg.MBSSID[idx].AccessControlList.Policy = 0;
				break;
			}
			DBGPRINT(RT_DEBUG_TRACE,
				 ("%s=%ld\n", tok_str,
				  pAd->ApCfg.MBSSID[idx].AccessControlList.Policy));
		}
		/* AccessControlListX */
		snprintf(tok_str, sizeof(tok_str), "AccessControlList%d", idx);
		if (RTMPGetKeyParameter(tok_str, tmpbuf, MAX_PARAM_BUFFER_SIZE, buffer, TRUE)) {
			for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				macptr = rstrtok(NULL, ";"), i++) {
				/* Mac address acceptable format 01:02:03:04:05:06 length 17 */
				if (strlen(macptr) != 17)
					continue;

				ASSERT(pAd->ApCfg.MBSSID[idx].AccessControlList.Num <=
				       MAX_NUM_OF_ACL_LIST);

				for (j = 0; j < MAC_ADDR_LEN; j++) {
					AtoH(macptr, &macAddress[j], 1);
					macptr = macptr + 3;
				}

				if (pAd->ApCfg.MBSSID[idx].AccessControlList.Num ==
				    MAX_NUM_OF_ACL_LIST) {
					DBGPRINT(RT_DEBUG_WARN,
					("The AccessControlList is full, and no more entry can join the list!\n"));
					DBGPRINT(RT_DEBUG_WARN,
						 ("The last entry of ACL is %02x:%02x:%02x:%02x:%02x:%02x\n",
						  macAddress[0], macAddress[1], macAddress[2],
						  macAddress[3], macAddress[4], macAddress[5]));

					break;
				}

				pAd->ApCfg.MBSSID[idx].AccessControlList.Num++;
				NdisMoveMemory(pAd->ApCfg.MBSSID[idx].AccessControlList.
					       Entry[(pAd->ApCfg.MBSSID[idx].AccessControlList.Num -
						      1)].Addr, macAddress, MAC_ADDR_LEN);
			}
			DBGPRINT(RT_DEBUG_TRACE,
				 ("%s=Get %ld Mac Address\n", tok_str,
				  pAd->ApCfg.MBSSID[idx].AccessControlList.Num));
		}
	}
}

/*
    ========================================================================

    Routine Description:
	In kernel mode read parameters from file

    Arguments:
	src                     the location of the file.
	dest                        put the parameters to the destination.
	Length                  size to read.

    Return Value:
	None

    Note:

    ========================================================================
*/
static void rtmp_read_ap_wmm_parms_from_file(IN PRTMP_ADAPTER pAd,
					     PSTRING tmpbuf, const char *buffer)
{
	PSTRING macptr;
	INT i = 0;
	INT ret;
	LONG longtmp;
	/*WmmCapable */
	if (RTMPGetKeyParameter("WmmCapable", tmpbuf, 32, buffer, TRUE)) {
		BOOLEAN bEnableWmm = FALSE;

		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			if (i >= pAd->ApCfg.BssidNum)
				break;
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			if (longtmp != 0) {
				pAd->ApCfg.MBSSID[i].wdev.bWmmCapable = TRUE;
				bEnableWmm = TRUE;
#ifdef MULTI_CLIENT_SUPPORT
				pAd->CommonCfg.bWmm = TRUE;
#endif /* MULTI_CLIENT_SUPPORT */
			} else {
				pAd->ApCfg.MBSSID[i].wdev.bWmmCapable = FALSE;
			}

			if (bEnableWmm) {
				pAd->CommonCfg.APEdcaParm.bValid = TRUE;
				pAd->ApCfg.BssEdcaParm.bValid = TRUE;
			} else {
				pAd->CommonCfg.APEdcaParm.bValid = FALSE;
				pAd->ApCfg.BssEdcaParm.bValid = FALSE;
			}

			pAd->ApCfg.MBSSID[i].bWmmCapableOrg = pAd->ApCfg.MBSSID[i].wdev.bWmmCapable;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("I/F(ra%d) WmmCapable=%d\n", i,
				  pAd->ApCfg.MBSSID[i].wdev.bWmmCapable));
		}
	}
	/*DLSCapable */
	if (RTMPGetKeyParameter("DLSCapable", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			if (i >= pAd->ApCfg.BssidNum)
				break;
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			if (longtmp != 0) {	/*Enable */
				pAd->ApCfg.MBSSID[i].bDLSCapable = TRUE;
			} else {	/*Disable */

				pAd->ApCfg.MBSSID[i].bDLSCapable = FALSE;
			}

			DBGPRINT(RT_DEBUG_TRACE,
				 ("I/F(ra%d) DLSCapable=%d\n", i,
				  pAd->ApCfg.MBSSID[i].bDLSCapable));
		}
	}
	/*APAifsn */
	if (RTMPGetKeyParameter("APAifsn", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			pAd->CommonCfg.APEdcaParm.Aifsn[i] = (UCHAR) longtmp;
			DBGPRINT(RT_DEBUG_TRACE,
				 ("APAifsn[%d]=%d\n", i, pAd->CommonCfg.APEdcaParm.Aifsn[i]));
		}
	}
	/*APCwmin */
	if (RTMPGetKeyParameter("APCwmin", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			pAd->CommonCfg.APEdcaParm.Cwmin[i] = (UCHAR) longtmp;

#ifdef MULTI_CLIENT_SUPPORT
			/* record profile cwmin */
			if (i == 0)
				pAd->CommonCfg.APCwmin = pAd->CommonCfg.APEdcaParm.Cwmin[0];
#endif /* MULTI_CLIENT_SUPPORT */

			DBGPRINT(RT_DEBUG_TRACE,
				 ("APCwmin[%d]=%d\n", i, pAd->CommonCfg.APEdcaParm.Cwmin[i]));
		}
	}
	/*APCwmax */
	if (RTMPGetKeyParameter("APCwmax", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			pAd->CommonCfg.APEdcaParm.Cwmax[i] = (UCHAR) longtmp;

#ifdef MULTI_CLIENT_SUPPORT
			/* record profile cwmax */
			if (i == 0)
				pAd->CommonCfg.APCwmax = pAd->CommonCfg.APEdcaParm.Cwmax[0];
#endif /* MULTI_CLIENT_SUPPORT */

			DBGPRINT(RT_DEBUG_TRACE,
				 ("APCwmax[%d]=%d\n", i, pAd->CommonCfg.APEdcaParm.Cwmax[i]));
		}
	}
	/*APTxop */
	if (RTMPGetKeyParameter("APTxop", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			pAd->CommonCfg.APEdcaParm.Txop[i] = (USHORT) longtmp;
			DBGPRINT(RT_DEBUG_TRACE,
				 ("APTxop[%d]=%d\n", i, pAd->CommonCfg.APEdcaParm.Txop[i]));
		}
	}
	/*APACM*/ if (RTMPGetKeyParameter("APACM", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			pAd->CommonCfg.APEdcaParm.bACM[i] = (BOOLEAN) longtmp;
			DBGPRINT(RT_DEBUG_TRACE,
				 ("APACM[%d]=%d\n", i, pAd->CommonCfg.APEdcaParm.bACM[i]));
		}
	}
	/*BSSAifsn */
	if (RTMPGetKeyParameter("BSSAifsn", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			pAd->ApCfg.BssEdcaParm.Aifsn[i] = (UCHAR) longtmp;
			DBGPRINT(RT_DEBUG_TRACE,
				 ("BSSAifsn[%d]=%d\n", i, pAd->ApCfg.BssEdcaParm.Aifsn[i]));
		}
	}
	/*BSSCwmin */
	if (RTMPGetKeyParameter("BSSCwmin", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			pAd->ApCfg.BssEdcaParm.Cwmin[i] = (UCHAR) longtmp;

#ifdef MULTI_CLIENT_SUPPORT
			/* record profile cwmin */
			if (i == 0)
				pAd->CommonCfg.BSSCwmin = pAd->ApCfg.BssEdcaParm.Cwmin[0];
#endif /* MULTI_CLIENT_SUPPORT */

			DBGPRINT(RT_DEBUG_TRACE,
				 ("BSSCwmin[%d]=%d\n", i, pAd->ApCfg.BssEdcaParm.Cwmin[i]));
		}
	}
	/*BSSCwmax */
	if (RTMPGetKeyParameter("BSSCwmax", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("os_strtol error\n"));
				return;
			}
			pAd->ApCfg.BssEdcaParm.Cwmax[i] = (UCHAR) longtmp;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("BSSCwmax[%d]=%d\n", i, pAd->ApCfg.BssEdcaParm.Cwmax[i]));
		}
	}
	/*BSSTxop */
	if (RTMPGetKeyParameter("BSSTxop", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			pAd->ApCfg.BssEdcaParm.Txop[i] = (USHORT) longtmp;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("BSSTxop[%d]=%d\n", i, pAd->ApCfg.BssEdcaParm.Txop[i]));
		}
	}
	/*BSSACM*/ if (RTMPGetKeyParameter("BSSACM", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			pAd->ApCfg.BssEdcaParm.bACM[i] = (BOOLEAN) longtmp;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("BSSACM[%d]=%d\n", i, pAd->ApCfg.BssEdcaParm.bACM[i]));
		}
	}

	parse_ack_policy(pAd, tmpbuf, buffer);	/* "AckPolicy" */

#ifdef UAPSD_SUPPORT
	/*APSDCapable */
	if (RTMPGetKeyParameter("APSDCapable", tmpbuf, 10, buffer, TRUE)) {

		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			if (i < HW_BEACON_MAX_NUM) {
				ret = os_strtol(macptr, 10, &longtmp);
				if (ret < 0) {
					DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
						 __func__, __LINE__, ret));
					return;
				}
				pAd->ApCfg.MBSSID[i].UapsdInfo.bAPSDCapable = (UCHAR) longtmp;
				DBGPRINT(RT_DEBUG_ERROR, ("APSDCapable[%d]=%d\n", i,
							  pAd->ApCfg.MBSSID[i].UapsdInfo.
							  bAPSDCapable));
			}
		}

		if (i == 1) {
			/*
			   Old format in UAPSD settings: only 1 parameter
			   i.e. UAPSD for all BSS is enabled or disabled.
			 */
			for (i = 1; i < HW_BEACON_MAX_NUM; i++) {
				pAd->ApCfg.MBSSID[i].UapsdInfo.bAPSDCapable =
				    pAd->ApCfg.MBSSID[0].UapsdInfo.bAPSDCapable;
				DBGPRINT(RT_DEBUG_ERROR, ("APSDCapable[%d]=%d\n", i,
							  pAd->ApCfg.MBSSID[i].UapsdInfo.
							  bAPSDCapable));
			}
		}
#ifdef APCLI_SUPPORT
		if (pAd->ApCfg.FlgApCliIsUapsdInfoUpdated == FALSE) {
			/*
			   Backward:
			   All UAPSD for AP Client interface is same as MBSS0
			   when we can not find "ApCliAPSDCapable".
			   When we find "ApCliAPSDCapable" hereafter, we will over-write.
			 */
			for (i = 0; i < MAX_APCLI_NUM; i++) {
				pAd->ApCfg.ApCliTab[i].UapsdInfo.bAPSDCapable =
				    pAd->ApCfg.MBSSID[0].UapsdInfo.bAPSDCapable;
				DBGPRINT(RT_DEBUG_ERROR, ("default ApCliAPSDCapable[%d]=%d\n",
							  i,
							  pAd->ApCfg.ApCliTab[i].UapsdInfo.
							  bAPSDCapable));
			}
		}
#endif /* APCLI_SUPPORT */
	}
#endif /* UAPSD_SUPPORT */
}

#ifdef DOT1X_SUPPORT
/*
    ========================================================================

    Routine Description:
	In kernel mode read parameters from file

    Arguments:
	src                     the location of the file.
	dest                        put the parameters to the destination.
	Length                  size to read.

    Return Value:
	None

    Note:

    ========================================================================
*/
static void rtmp_read_radius_parms_from_file(IN PRTMP_ADAPTER pAd, PSTRING tmpbuf, PSTRING buffer)
{
	STRING tok_str[16];
	PSTRING macptr;
	UINT32 ip_addr;
	INT i = 0;
	BOOLEAN bUsePrevFormat = FALSE;
	USHORT offset;
	INT count[HW_BEACON_MAX_NUM];
	INT ret;
	LONG longtmp;

	/* own_ip_addr */
	if (RTMPGetKeyParameter("own_ip_addr", tmpbuf, 32, buffer, TRUE))
		Set_OwnIPAddr_Proc(pAd, tmpbuf);

	/* session_timeout_interval */
	if (RTMPGetKeyParameter("session_timeout_interval", tmpbuf, 32, buffer, TRUE)) {
		ret = os_strtol(tmpbuf, 10, &longtmp);
		if (ret < 0)
			return FALSE;
		pAd->ApCfg.session_timeout_interval = longtmp;

		DBGPRINT(RT_DEBUG_TRACE,
			("session_timeout_interval=%d\n", pAd->ApCfg.session_timeout_interval));
	}

	/* quiet_interval */
	if (RTMPGetKeyParameter("quiet_interval", tmpbuf, 32, buffer, TRUE)) {
		ret = os_strtol(tmpbuf, 10, &longtmp);
		if (ret < 0)
			return FALSE;
		pAd->ApCfg.quiet_interval = longtmp;

		DBGPRINT(RT_DEBUG_TRACE, ("quiet_interval=%d\n", pAd->ApCfg.quiet_interval));
	}

	/* EAPifname */
	if (RTMPGetKeyParameter("EAPifname", tmpbuf, 256, buffer, TRUE))
		Set_EAPIfName_Proc(pAd, tmpbuf);

	/* PreAuthifname */
	if (RTMPGetKeyParameter("PreAuthifname", tmpbuf, 256, buffer, TRUE))
		Set_PreAuthIfName_Proc(pAd, tmpbuf);

	/*PreAuth */
	if (RTMPGetKeyParameter("PreAuth", tmpbuf, 10, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			if (i >= pAd->ApCfg.BssidNum)
				break;

			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			if (longtmp != 0)	/*Enable */
				pAd->ApCfg.MBSSID[i].PreAuth = TRUE;
			else	/*Disable */
				pAd->ApCfg.MBSSID[i].PreAuth = FALSE;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("I/F(ra%d) PreAuth=%d\n", i, pAd->ApCfg.MBSSID[i].PreAuth));
		}
	}

	/*IEEE8021X */
	if (RTMPGetKeyParameter("IEEE8021X", tmpbuf, 32, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr; macptr = rstrtok(NULL, ";"), i++) {
			if (i >= pAd->ApCfg.BssidNum)
				break;

			ret = os_strtol(macptr, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			if (longtmp != 0)	/*Enable */
				pAd->ApCfg.MBSSID[i].wdev.IEEE8021X = TRUE;
			else	/*Disable */
				pAd->ApCfg.MBSSID[i].wdev.IEEE8021X = FALSE;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("IF(ra%d), IEEE8021X=%d\n", i,
				  pAd->ApCfg.MBSSID[i].wdev.IEEE8021X));
		}
	}

	/* RADIUS_Server */
	offset = 0;
	/*if (RTMPGetKeyParameter("RADIUS_Server", tmpbuf, 256, buffer, TRUE)) */
	while (RTMPGetKeyParameterWithOffset("RADIUS_Server", tmpbuf, &offset, 256, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_MBSSID_NUM(pAd));
		     macptr = rstrtok(NULL, ";"), i++) {
			if (rtinet_aton(macptr, &ip_addr)
			    && pAd->ApCfg.MBSSID[i].radius_srv_num < MAX_RADIUS_SRV_NUM) {
				INT srv_idx = pAd->ApCfg.MBSSID[i].radius_srv_num;

				pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].radius_ip = ip_addr;
				pAd->ApCfg.MBSSID[i].radius_srv_num++;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("IF(ra%d), radius_ip(seq-%d)=%s(%x)\n", i,
					  pAd->ApCfg.MBSSID[i].radius_srv_num, macptr,
					  pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].radius_ip));
			}
		}
	}
	/* RADIUS_Port */
	/*if (RTMPGetKeyParameter("RADIUS_Port", tmpbuf, 128, buffer, TRUE)) */
	offset = 0;
	memset(&count[0], 0, sizeof(count));
	while (RTMPGetKeyParameterWithOffset("RADIUS_Port", tmpbuf, &offset, 128, buffer, TRUE)) {
		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_MBSSID_NUM(pAd));
		     macptr = rstrtok(NULL, ";"), i++) {
			if (count[i] < pAd->ApCfg.MBSSID[i].radius_srv_num) {
				INT srv_idx = count[i];

				ret = os_strtol(macptr, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].radius_port =
				    (UINT32) longtmp;
				count[i]++;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("IF(ra%d), radius_port(seq-%d)=%d\n", i, count[i],
					  pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].
					  radius_port));
			}
		}
	}
	/* RADIUS_Key */
	/*if (RTMPGetKeyParameter("RADIUS_Key", tmpbuf, 640, buffer, FALSE)) */
	offset = 0;
	memset(&count[0], 0, sizeof(count));
	while (RTMPGetKeyParameterWithOffset("RADIUS_Key", tmpbuf, &offset, 640, buffer, FALSE)) {
		if (strlen(tmpbuf) > 0)
			bUsePrevFormat = TRUE;

		for (i = 0, macptr = rstrtok(tmpbuf, ";"); (macptr && i < MAX_MBSSID_NUM(pAd));
		     macptr = rstrtok(NULL, ";"), i++) {
			if (strlen(macptr) > 0 && (count[i] < pAd->ApCfg.MBSSID[i].radius_srv_num)) {
				INT srv_idx = count[i];

				pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].radius_key_len =
				    strlen(macptr);
				NdisMoveMemory(pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].
					       radius_key, macptr, strlen(macptr));
				count[i]++;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("IF(ra%d), radius_key(seq-%d)=%s, len=%d\n", i, count[i],
					  pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].radius_key,
					  pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].
					  radius_key_len));
			}
		}
	}

	/* NasIdX, X indicate the interface index(1~8) */
	for (i = 0; i < pAd->ApCfg.BssidNum; i++) {
		snprintf(tok_str, sizeof(tok_str), "NasId%d", i + 1);
		if (RTMPGetKeyParameter(tok_str, tmpbuf, 33, buffer, FALSE)) {
			if (strlen(tmpbuf) > 0) {
				pAd->ApCfg.MBSSID[i].NasIdLen = strlen(tmpbuf);
				NdisMoveMemory(pAd->ApCfg.MBSSID[i].NasId, tmpbuf, strlen(tmpbuf));
				DBGPRINT(RT_DEBUG_TRACE, ("IF-ra%d NAS-ID=%s, len=%d\n", i,
							  pAd->ApCfg.MBSSID[i].NasId,
							  pAd->ApCfg.MBSSID[i].NasIdLen));
			}
		}
	}

	if (!bUsePrevFormat) {
		for (i = 0; i < MAX_MBSSID_NUM(pAd); i++) {
			INT srv_idx = 0;

			snprintf(tok_str, sizeof(tok_str), "RADIUS_Key%d", i + 1);

			/* RADIUS_KeyX (X=1~MAX_MBSSID_NUM) */
			/*if (RTMPGetKeyParameter(tok_str, tmpbuf, 128, buffer, FALSE))                 */
			offset = 0;
			while (RTMPGetKeyParameterWithOffset
			       (tok_str, tmpbuf, &offset, 128, buffer, FALSE)) {
				if (strlen(tmpbuf) > 0
				    && (srv_idx < pAd->ApCfg.MBSSID[i].radius_srv_num)) {
					pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].
					    radius_key_len = strlen(tmpbuf);
					NdisMoveMemory(pAd->ApCfg.MBSSID[i].
						       radius_srv_info[srv_idx].radius_key, tmpbuf,
						       strlen(tmpbuf));
					DBGPRINT(RT_DEBUG_TRACE,
						 ("IF(ra%d), update radius_key(seq-%d)=%s, len=%d\n",
						  i, srv_idx + 1,
						  pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].
						  radius_key,
						  pAd->ApCfg.MBSSID[i].radius_srv_info[srv_idx].
						  radius_key_len));
					srv_idx++;
				}
			}
		}
	}
}
#endif /* DOT1X_SUPPORT */

static int rtmp_parse_wpapsk_buffer_from_file(IN PRTMP_ADAPTER pAd, IN PSTRING buffer,
					      IN INT BSSIdx)
{
	PSTRING tmpbuf = buffer;
	INT i = BSSIdx;
	/*UCHAR         keyMaterial[40]; */
	ULONG len = strlen(tmpbuf);
	int ret = 0;

	DBGPRINT(RT_DEBUG_TRACE, ("I/F(ra%d) WPAPSK_KEY=%s\n", i, tmpbuf));

	ret =
	    RT_CfgSetWPAPSKKey(pAd, tmpbuf, len, (PUCHAR) pAd->ApCfg.MBSSID[i].Ssid,
			       pAd->ApCfg.MBSSID[i].SsidLen, pAd->ApCfg.MBSSID[i].PMK);
	if (ret == FALSE)
		return FALSE;

	/* Keep this key string */
	strcpy(pAd->ApCfg.MBSSID[i].WPAKeyString, tmpbuf);

#ifdef WSC_AP_SUPPORT
	NdisZeroMemory(pAd->ApCfg.MBSSID[i].WscControl.WpaPsk, 64);
	pAd->ApCfg.MBSSID[i].WscControl.WpaPskLen = 0;
	if ((len >= 8) && (len <= 64)) {
		NdisMoveMemory(pAd->ApCfg.MBSSID[i].WscControl.WpaPsk, tmpbuf, len);
		pAd->ApCfg.MBSSID[i].WscControl.WpaPskLen = len;
	}
#endif /* WSC_AP_SUPPORT */
	return ret;
}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
static void rtmp_read_sta_wmm_parms_from_file(IN PRTMP_ADAPTER pAd,
					      PSTRING tmpbuf, const char *buffer)
{
	BOOLEAN bWmmEnable = FALSE;
	INT ret;
	LONG longtmp;
	/*WmmCapable */
	if (RTMPGetKeyParameter("WmmCapable", tmpbuf, 32, buffer, TRUE)) {
		ret = os_strtol(tmpbuf, 10, &longtmp);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (longtmp != 0) {	/*Enable */
			pAd->CommonCfg.bWmmCapable = TRUE;
			bWmmEnable = TRUE;
		} else {	/*Disable */

			pAd->CommonCfg.bWmmCapable = FALSE;
		}

		pAd->StaCfg.wdev.bWmmCapable = pAd->CommonCfg.bWmmCapable;

		DBGPRINT(RT_DEBUG_TRACE, ("WmmCapable=%d\n", pAd->CommonCfg.bWmmCapable));
	}
#ifdef QOS_DLS_SUPPORT
	/*DLSCapable */
	if (RTMPGetKeyParameter("DLSCapable", tmpbuf, 32, buffer, TRUE)) {
		ret = os_strtol(tmpbuf, 10, &longtmp);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}
		if (longtmp != 0) {	/*Enable */
			pAd->CommonCfg.bDLSCapable = TRUE;
		} else {	/*Disable */

			pAd->CommonCfg.bDLSCapable = FALSE;
		}

		DBGPRINT(RT_DEBUG_TRACE, ("bDLSCapable=%d\n", pAd->CommonCfg.bDLSCapable));
	}
#endif /* QOS_DLS_SUPPORT */

	parse_ack_policy(pAd, tmpbuf, buffer);	/* "AckPolicy" */

#ifdef UAPSD_SUPPORT
	if (bWmmEnable) {
		/*APSDCapable */
		if (RTMPGetKeyParameter("APSDCapable", tmpbuf, 10, buffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			if (longtmp != 0)	/*Enable */
				pAd->StaCfg.UapsdInfo.bAPSDCapable = TRUE;
			else
				pAd->StaCfg.UapsdInfo.bAPSDCapable = FALSE;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("APSDCapable=%d\n", pAd->StaCfg.UapsdInfo.bAPSDCapable));
		}

		/*MaxSPLength */
		if (RTMPGetKeyParameter("MaxSPLength", tmpbuf, 10, buffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}
			pAd->CommonCfg.MaxSPLength = longtmp;

			DBGPRINT(RT_DEBUG_TRACE, ("MaxSPLength=%d\n", pAd->CommonCfg.MaxSPLength));
		}

		/*APSDAC for AC_BE, AC_BK, AC_VI, AC_VO */
		if (RTMPGetKeyParameter("APSDAC", tmpbuf, 32, buffer, TRUE)) {
			PSTRING macptr;
			BOOLEAN apsd_ac[4] = { FALSE };
			INT i = 0;

			for (i = 0, macptr = rstrtok(tmpbuf, ";");
				macptr && i < ARRAY_SIZE(apsd_ac);
				macptr = rstrtok(NULL, ";"), i++) {

				ret = os_strtol(macptr, 10, &longtmp);
				if (ret < 0) {
					DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
						 __func__, __LINE__, ret));
					return;
				}
				apsd_ac[i] = (BOOLEAN) longtmp;

				DBGPRINT(RT_DEBUG_TRACE, ("APSDAC%d  %d\n", i, apsd_ac[i]));
			}

			if (i < ARRAY_SIZE(apsd_ac))
				DBGPRINT(RT_DEBUG_WARN,
					 ("The number of APSDAC in tmpbuf is less than 4\n"));

			pAd->CommonCfg.bAPSDAC_BE = apsd_ac[0];
			pAd->CommonCfg.bAPSDAC_BK = apsd_ac[1];
			pAd->CommonCfg.bAPSDAC_VI = apsd_ac[2];
			pAd->CommonCfg.bAPSDAC_VO = apsd_ac[3];

			pAd->CommonCfg.bACMAPSDTr[0] = apsd_ac[0];
			pAd->CommonCfg.bACMAPSDTr[1] = apsd_ac[1];
			pAd->CommonCfg.bACMAPSDTr[2] = apsd_ac[2];
			pAd->CommonCfg.bACMAPSDTr[3] = apsd_ac[3];
		}
	}
#endif /* UAPSD_SUPPORT */
}

#ifdef XLINK_SUPPORT
static void rtmp_get_psp_xlink_mode_from_file(IN PRTMP_ADAPTER pAd, char *tmpbuf,
					      const char *buffer)
{
	INT ret;
	LONG Value;
	/* Xlink Mode */
	if (RTMPGetKeyParameter("PSP_XLINK_MODE", tmpbuf, 32, buffer, TRUE)) {
		ret = os_strtol(tmpbuf, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}
		if (Value != 0)	/* enable */
			pAd->StaCfg.PSPXlink = TRUE;
		else		/* disable */
			pAd->StaCfg.PSPXlink = FALSE;

		AsicSetRxFilter(pAd);

		DBGPRINT(RT_DEBUG_TRACE, ("PSP_XLINK_MODE=%d\n", pAd->StaCfg.PSPXlink));
	}
}
#endif /* XLINK_SUPPORT */
#endif /* CONFIG_STA_SUPPORT */

#ifdef DOT11_VHT_AC
static void VHTParametersHook(IN RTMP_ADAPTER *pAd, IN PSTRING pValueStr, IN const char *pInput)
{
	long Value;
	INT ret;

	/* Channel Width */
	if (RTMPGetKeyParameter("VHT_BW", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == VHT_BW_80)
			pAd->CommonCfg.vht_bw = VHT_BW_80;
		else
			pAd->CommonCfg.vht_bw = VHT_BW_2040;

#ifdef MCAST_RATE_SPECIFIC
		if (pAd->CommonCfg.vht_bw == VHT_BW_80)
			pAd->CommonCfg.MCastPhyMode.field.BW = BW_80;
#endif /* MCAST_RATE_SPECIFIC */

		DBGPRINT(RT_DEBUG_TRACE, ("VHT: Channel Width = %s\n",
					  (pAd->CommonCfg.vht_bw ==
					   VHT_BW_80) ? "80 MHz" : "20/40 MHz"));
	}

	/* VHT GI setting */
	if (RTMPGetKeyParameter("VHT_SGI", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == GI_800)
			pAd->CommonCfg.vht_sgi_80 = GI_800;
		else
			pAd->CommonCfg.vht_sgi_80 = GI_400;

		DBGPRINT(RT_DEBUG_TRACE, ("VHT: Short GI for 80Mhz  = %s\n",
					  (pAd->CommonCfg.vht_sgi_80 ==
					   GI_800) ? "Disabled" : "Enable"));
	}

	/* VHT STBC */
	if (RTMPGetKeyParameter("VHT_STBC", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		pAd->CommonCfg.vht_stbc = (Value == 1 ? STBC_USE : STBC_NONE);
		DBGPRINT(RT_DEBUG_TRACE, ("VHT: STBC = %d\n", pAd->CommonCfg.vht_stbc));
	}

	/* bandwidth signaling */
	if (RTMPGetKeyParameter("VHT_BW_SIGNAL", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value >= 0 && Value <= 2)
			pAd->CommonCfg.vht_bw_signal = Value;
		else
			pAd->CommonCfg.vht_bw_signal = BW_SIGNALING_DISABLE;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("VHT: BW SIGNALING = %d\n", pAd->CommonCfg.vht_bw_signal));
	}

	/* Disallow non-VHT connection */
	if (RTMPGetKeyParameter("VHT_DisallowNonVHT", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0)
			pAd->CommonCfg.bNonVhtDisallow = FALSE;
		else
			pAd->CommonCfg.bNonVhtDisallow = TRUE;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("VHT: VHT_DisallowNonVHT = %d\n", pAd->CommonCfg.bNonVhtDisallow));
	}

	/* VHT LDPC */
	if (RTMPGetKeyParameter("VHT_LDPC", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0)
			pAd->CommonCfg.vht_ldpc = FALSE;
		else
			pAd->CommonCfg.vht_ldpc = TRUE;
		DBGPRINT(RT_DEBUG_TRACE, ("VHT: VHT_LDPC = %d\n", pAd->CommonCfg.vht_ldpc));
	}
#ifdef WFA_VHT_PF
	/* VHT highest Tx Rate with LGI */
	if (RTMPGetKeyParameter("VHT_TX_HRATE", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}
		if (Value >= 0 && Value <= 2)
			pAd->CommonCfg.vht_tx_hrate = Value;
		else
			pAd->CommonCfg.vht_tx_hrate = 0;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("VHT: TX HighestRate = %d\n", pAd->CommonCfg.vht_tx_hrate));
	}

	if (RTMPGetKeyParameter("VHT_RX_HRATE", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value >= 0 && Value <= 2)
			pAd->CommonCfg.vht_rx_hrate = Value;
		else
			pAd->CommonCfg.vht_rx_hrate = 0;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("VHT: RX HighestRate = %d\n", pAd->CommonCfg.vht_rx_hrate));
	}

	if (RTMPGetKeyParameter("VHT_MCS_CAP", pValueStr, 25, pInput, TRUE))
		set_vht_nss_mcs_cap(pAd, pValueStr);
#endif /* WFA_VHT_PF */

}

#endif /* DOT11_VHT_AC */

static void HTParametersHook(IN PRTMP_ADAPTER pAd, IN PSTRING pValueStr, IN const char *pInput)
{
	long Value;
	INT ret;
#ifdef CONFIG_AP_SUPPORT
	INT i = 0;
	PSTRING Bufptr;
#endif /* CONFIG_AP_SUPPORT */

	if (RTMPGetKeyParameter("HT_PROTECT", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}
		if (Value == 0)
			pAd->CommonCfg.bHTProtect = FALSE;
		else
			pAd->CommonCfg.bHTProtect = TRUE;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: Protection  = %s\n", (Value == 0) ? "Disable" : "Enable"));
	}

	if (RTMPGetKeyParameter("HT_MIMOPSMode", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}
		if (Value > MMPS_DISABLE) {
			pAd->CommonCfg.BACapability.field.MMPSmode = MMPS_DISABLE;
		} else {
			/*TODO: add mimo power saving mechanism */
			pAd->CommonCfg.BACapability.field.MMPSmode = MMPS_DISABLE;
			/*pAd->CommonCfg.BACapability.field.MMPSmode = Value; */
		}
		DBGPRINT(RT_DEBUG_TRACE, ("HT: MIMOPS Mode  = %d\n", (INT) Value));
	}

	if (RTMPGetKeyParameter("HT_BADecline", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0)
			pAd->CommonCfg.bBADecline = FALSE;
		else
			pAd->CommonCfg.bBADecline = TRUE;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: BA Decline  = %s\n", (Value == 0) ? "Disable" : "Enable"));
	}

	if (RTMPGetKeyParameter("HT_AutoBA", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0) {
			pAd->CommonCfg.BACapability.field.AutoBA = FALSE;
			pAd->CommonCfg.BACapability.field.Policy = BA_NOTUSE;
		} else {
			pAd->CommonCfg.BACapability.field.AutoBA = TRUE;
			pAd->CommonCfg.BACapability.field.Policy = IMMED_BA;
		}
		pAd->CommonCfg.REGBACapability.field.AutoBA =
		    pAd->CommonCfg.BACapability.field.AutoBA;
		pAd->CommonCfg.REGBACapability.field.Policy =
		    pAd->CommonCfg.BACapability.field.Policy;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: Auto BA  = %s\n", (Value == 0) ? "Disable" : "Enable"));
	}

	/* Tx_+HTC frame */
	if (RTMPGetKeyParameter("HT_HTC", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0)
			pAd->HTCEnable = FALSE;
		else
			pAd->HTCEnable = TRUE;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: Tx +HTC frame = %s\n", (Value == 0) ? "Disable" : "Enable"));
	}

	/* Reverse Direction Mechanism */
	if (RTMPGetKeyParameter("HT_RDG", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0) {
			pAd->CommonCfg.bRdg = FALSE;
		} else {
			pAd->HTCEnable = TRUE;
			pAd->CommonCfg.bRdg = TRUE;
		}
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: RDG = %s\n", (Value == 0) ? "Disable" : "Enable(+HTC)"));
	}

	/* Tx A-MSUD ? */
	if (RTMPGetKeyParameter("HT_AMSDU", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		pAd->CommonCfg.BACapability.field.AmsduEnable = (Value == 0) ? FALSE : TRUE;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: Tx A-MSDU = %s\n", (Value == 0) ? "Disable" : "Enable"));
	}
#ifdef WFA_VHT_PF
	if (RTMPGetKeyParameter("FORCE_AMSDU", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		pAd->force_amsdu = (Value == 0) ? FALSE : TRUE;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: FORCE A-MSDU = %s\n", (Value == 0) ? "Disable" : "Enable"));
	}
#endif /* WFA_VHT_PF */

	/* MPDU Density */
	if (RTMPGetKeyParameter("HT_MpduDensity", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}
		if (Value <= 7 && Value >= 0) {
			pAd->CommonCfg.BACapability.field.MpduDensity = Value;
			DBGPRINT(RT_DEBUG_TRACE, ("HT: MPDU Density = %d\n", (INT) Value));
		} else {
			pAd->CommonCfg.BACapability.field.MpduDensity = 4;
			DBGPRINT(RT_DEBUG_TRACE, ("HT: MPDU Density = %d (Default)\n", 4));
		}
	}

	/* Max Rx BA Window Size */
	if (RTMPGetKeyParameter("HT_BAWinSize", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

#ifdef CONFIG_AP_SUPPORT
		/* Intel IOT */
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd)
		    Value = 64;
#endif /* CONFIG_AP_SUPPORT */
		if (Value >= 1 && Value <= 64) {
			pAd->CommonCfg.REGBACapability.field.RxBAWinLimit = Value;
			pAd->CommonCfg.BACapability.field.RxBAWinLimit = Value;
			DBGPRINT(RT_DEBUG_TRACE, ("HT: BA Windw Size = %d\n", (INT) Value));
		} else {
			pAd->CommonCfg.REGBACapability.field.RxBAWinLimit = 64;
			pAd->CommonCfg.BACapability.field.RxBAWinLimit = 64;
			DBGPRINT(RT_DEBUG_TRACE, ("HT: BA Windw Size = 64 (Defualt)\n"));
		}

	}

	/* Guard Interval */
	if (RTMPGetKeyParameter("HT_GI", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == GI_400)
			pAd->CommonCfg.RegTransmitSetting.field.ShortGI = GI_400;
		else
			pAd->CommonCfg.RegTransmitSetting.field.ShortGI = GI_800;

		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: Guard Interval = %s\n", (Value == GI_400) ? "400" : "800"));
	}

	/* HT LDPC */
	if (RTMPGetKeyParameter("HT_LDPC", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0)
			pAd->CommonCfg.ht_ldpc = FALSE;
		else
			pAd->CommonCfg.ht_ldpc = TRUE;
		DBGPRINT(RT_DEBUG_TRACE, ("HT: HT_LDPC = %d\n", pAd->CommonCfg.ht_ldpc));
	}

	/* HT Operation Mode : Mixed Mode , Green Field */
	if (RTMPGetKeyParameter("HT_OpMode", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == HTMODE_GF)
			pAd->CommonCfg.RegTransmitSetting.field.HTMODE = HTMODE_GF;
		else
			pAd->CommonCfg.RegTransmitSetting.field.HTMODE = HTMODE_MM;

		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: Operate Mode = %s\n",
			  (Value == HTMODE_GF) ? "Green Field" : "Mixed Mode"));
	}

	/* Fixed Tx mode : CCK, OFDM */
	if (RTMPGetKeyParameter("FixedTxMode", pValueStr, 25, pInput, TRUE)) {
#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
			for (i = 0, Bufptr = rstrtok(pValueStr, ";");
			     (Bufptr && i < MAX_MBSSID_NUM(pAd));
			     Bufptr = rstrtok(NULL, ";"), i++) {
				pAd->ApCfg.MBSSID[i].wdev.DesiredTransmitSetting.field.FixedTxMode =
				    RT_CfgSetFixedTxPhyMode(Bufptr);
				DBGPRINT(RT_DEBUG_TRACE,
					 ("(IF-ra%d) Fixed Tx Mode = %d\n", i,
					  pAd->ApCfg.MBSSID[i].wdev.DesiredTransmitSetting.field.
					  FixedTxMode));
			}
		}
#endif /* CONFIG_AP_SUPPORT */
#ifdef CONFIG_STA_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
			pAd->StaCfg.wdev.DesiredTransmitSetting.field.FixedTxMode =
			    RT_CfgSetFixedTxPhyMode(pValueStr);
			DBGPRINT(RT_DEBUG_TRACE, ("Fixed Tx Mode = %d\n",
						  pAd->StaCfg.wdev.DesiredTransmitSetting.field.
						  FixedTxMode));
		}
#endif /* CONFIG_STA_SUPPORT */
	}

	/* Channel Width */
	if (RTMPGetKeyParameter("HT_BW", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == BW_40)
			pAd->CommonCfg.RegTransmitSetting.field.BW = BW_40;
		else
			pAd->CommonCfg.RegTransmitSetting.field.BW = BW_20;

		pAd->CommonCfg.default_bw = pAd->CommonCfg.RegTransmitSetting.field.BW;
#ifdef MCAST_RATE_SPECIFIC
		pAd->CommonCfg.MCastPhyMode.field.BW = pAd->CommonCfg.RegTransmitSetting.field.BW;
#endif /* MCAST_RATE_SPECIFIC */

		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: Channel Width = %s\n", (Value == BW_40) ? "40 MHz" : "20 MHz"));
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: default_bw = %s\n", (Value == BW_40) ? "40 MHz" : "20 MHz"));
	}

	if (RTMPGetKeyParameter("HT_EXTCHA", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0)
			pAd->CommonCfg.RegTransmitSetting.field.EXTCHA = EXTCHA_BELOW;
		else
			pAd->CommonCfg.RegTransmitSetting.field.EXTCHA = EXTCHA_ABOVE;

		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: Ext Channel = %s\n", (Value == 0) ? "BELOW" : "ABOVE"));
	}

	/* MSC */
	if (RTMPGetKeyParameter("HT_MCS", pValueStr, 50, pInput, TRUE)) {
#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
			for (i = 0, Bufptr = rstrtok(pValueStr, ";");
			     (Bufptr && i < MAX_MBSSID_NUM(pAd));
			     Bufptr = rstrtok(NULL, ";"), i++) {
				struct wifi_dev *wdev = &pAd->ApCfg.MBSSID[i].wdev;

				ret = os_strtol(Bufptr, 10, &Value);
				if (ret < 0) {
					DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
						 __func__, __LINE__, ret));
					return;
				}

				if ((Value >= 0 && Value <= 23) || (Value == 32))
					wdev->DesiredTransmitSetting.field.MCS = Value;
				else
					wdev->DesiredTransmitSetting.field.MCS = MCS_AUTO;

				DBGPRINT(RT_DEBUG_TRACE, ("(IF-ra%d) HT: MCS = %s(%d)\n", i,
							  (wdev->DesiredTransmitSetting.field.MCS ==
							   MCS_AUTO ? "AUTO" : "Fixed"),
							  wdev->DesiredTransmitSetting.field.MCS));
			}
		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
			struct wifi_dev *wdev = &pAd->StaCfg.wdev;

			ret = os_strtol(pValueStr, 10, &Value);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, ret));
				return;
			}

			if ((Value >= 0 && Value <= 23) || (Value == 32)) {
				wdev->DesiredTransmitSetting.field.MCS = Value;
				wdev->bAutoTxRateSwitch = FALSE;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("HT: MCS = %d\n",
					  wdev->DesiredTransmitSetting.field.MCS));
			} else {
				wdev->DesiredTransmitSetting.field.MCS = MCS_AUTO;
				wdev->bAutoTxRateSwitch = TRUE;
				DBGPRINT(RT_DEBUG_TRACE, ("HT: MCS = AUTO\n"));
			}
		}
#endif /* CONFIG_STA_SUPPORT */
	}

	/* STBC */
	if (RTMPGetKeyParameter("HT_STBC", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == STBC_USE)
			pAd->CommonCfg.RegTransmitSetting.field.STBC = STBC_USE;
		else
			pAd->CommonCfg.RegTransmitSetting.field.STBC = STBC_NONE;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: STBC = %d\n", pAd->CommonCfg.RegTransmitSetting.field.STBC));
	}

	/* 40_Mhz_Intolerant */
	if (RTMPGetKeyParameter("HT_40MHZ_INTOLERANT", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0)
			pAd->CommonCfg.bForty_Mhz_Intolerant = FALSE;
		else
			pAd->CommonCfg.bForty_Mhz_Intolerant = TRUE;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: 40MHZ INTOLERANT = %d\n", pAd->CommonCfg.bForty_Mhz_Intolerant));
	}
	/*HT_TxStream */
	if (RTMPGetKeyParameter("HT_TxStream", pValueStr, 10, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		switch (Value) {
		case 1:
			pAd->CommonCfg.TxStream = 1;
			break;
		case 2:
			pAd->CommonCfg.TxStream = 2;
			break;
		case 3:	/* 3*3 */
		default:
			pAd->CommonCfg.TxStream = 3;

			if (pAd->MACVersion < RALINK_2883_VERSION)
				pAd->CommonCfg.TxStream = 2;	/* only 2 tx streams for RT2860 series */
			break;
		}
		DBGPRINT(RT_DEBUG_TRACE, ("HT: Tx Stream = %d\n", pAd->CommonCfg.TxStream));
	}
	/*HT_RxStream */
	if (RTMPGetKeyParameter("HT_RxStream", pValueStr, 10, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		switch (Value) {
		case 1:
			pAd->CommonCfg.RxStream = 1;
			break;
		case 2:
			pAd->CommonCfg.RxStream = 2;
			break;
		case 3:
		default:
			pAd->CommonCfg.RxStream = 3;

			if (pAd->MACVersion < RALINK_2883_VERSION)
				pAd->CommonCfg.RxStream = 2;	/* only 2 rx streams for RT2860 series */
			break;
		}
		DBGPRINT(RT_DEBUG_TRACE, ("HT: Rx Stream = %d\n", pAd->CommonCfg.RxStream));
	}
#ifdef GREENAP_SUPPORT
	/*Green AP */
	if (RTMPGetKeyParameter("GreenAP", pValueStr, 10, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 0)
			pAd->ApCfg.bGreenAPEnable = FALSE;
		else
			pAd->ApCfg.bGreenAPEnable = TRUE;
		DBGPRINT(RT_DEBUG_TRACE, ("HT: Green AP= %d\n", pAd->ApCfg.bGreenAPEnable));
	}
#endif /* GREENAP_SUPPORT */
	/* HT_DisallowTKIP */
	if (RTMPGetKeyParameter("HT_DisallowTKIP", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		if (Value == 1)
			pAd->CommonCfg.HT_DisallowTKIP = TRUE;
		else
			pAd->CommonCfg.HT_DisallowTKIP = FALSE;

		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: Disallow TKIP mode = %s\n",
			  (pAd->CommonCfg.HT_DisallowTKIP == TRUE) ? "ON" : "OFF"));
	}

	if (RTMPGetKeyParameter("OBSSScanParam", pValueStr, 32, pInput, TRUE)) {
		int ObssScanValue, idx;
		PSTRING macptr;

		for (idx = 0, macptr = rstrtok(pValueStr, ";"); macptr;
		     macptr = rstrtok(NULL, ";"), idx++) {
			ret = os_strtol(macptr, 10, &Value);
			if (ret < 0) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					__func__, __LINE__, ret));
				return;
			}

			ObssScanValue = Value;
			switch (idx) {
			case 0:
				if (ObssScanValue < 5 || ObssScanValue > 1000) {
					DBGPRINT(RT_DEBUG_ERROR,
					("Invalid OBSSScanParam for Dot11OBssScanPassiveDwell(%d), should in range 5~1000\n",
					ObssScanValue));
				} else {
					/* Unit : TU. 5~1000 */
					pAd->CommonCfg.Dot11OBssScanPassiveDwell = ObssScanValue;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("OBSSScanParam for Dot11OBssScanPassiveDwell=%d\n",
						  ObssScanValue));
				}
				break;
			case 1:
				if (ObssScanValue < 10 || ObssScanValue > 1000) {
					DBGPRINT(RT_DEBUG_ERROR,
					("Invalid OBSSScanParam for Dot11OBssScanActiveDwell(%d), should in range 10~1000\n",
					ObssScanValue));
				} else {
					/* Unit : TU. 10~1000 */
					pAd->CommonCfg.Dot11OBssScanActiveDwell = ObssScanValue;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("OBSSScanParam for Dot11OBssScanActiveDwell=%d\n",
						  ObssScanValue));
				}
				break;
			case 2:
				pAd->CommonCfg.Dot11BssWidthTriggerScanInt = ObssScanValue;	/* Unit : Second */
				DBGPRINT(RT_DEBUG_TRACE,
					 ("OBSSScanParam for Dot11BssWidthTriggerScanInt=%d\n",
					  ObssScanValue));
				break;
			case 3:
				if (ObssScanValue < 200 || ObssScanValue > 10000) {
					DBGPRINT(RT_DEBUG_ERROR,
					("Invalid OBSSScanParam for Dot11OBssScanPassiveTotalPerChannel(%d), should in range 200~10000\n",
						  ObssScanValue));
				} else {
					/* Unit : TU. 200~10000 */
					pAd->CommonCfg.Dot11OBssScanPassiveTotalPerChannel
					= ObssScanValue;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("OBSSScanParam for Dot11OBssScanPassiveTotalPerChannel=%d\n",
						  ObssScanValue));
				}
				break;
			case 4:
				if (ObssScanValue < 20 || ObssScanValue > 10000) {
					DBGPRINT(RT_DEBUG_ERROR,
					("Invalid OBSSScanParam for Dot11OBssScanActiveTotalPerChannel(%d), should in range 20~10000\n",
						  ObssScanValue));
				} else {
					/* Unit : TU. 20~10000 */
					pAd->CommonCfg.Dot11OBssScanActiveTotalPerChannel
					= ObssScanValue;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("OBSSScanParam for Dot11OBssScanActiveTotalPerChannel=%d\n",
						  ObssScanValue));
				}
				break;
			case 5:
				pAd->CommonCfg.Dot11BssWidthChanTranDelayFactor = ObssScanValue;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("OBSSScanParam for Dot11BssWidthChanTranDelayFactor=%d\n",
					  ObssScanValue));
				break;
			case 6:
				pAd->CommonCfg.Dot11OBssScanActivityThre = ObssScanValue;	/* Unit : percentage */
				DBGPRINT(RT_DEBUG_TRACE,
					 ("OBSSScanParam for Dot11BssWidthChanTranDelayFactor=%d\n",
					  ObssScanValue));
				break;
			default:
				DBGPRINT(RT_DEBUG_ERROR,
				("Invalid OBSSScanParam idx(%d), should in range 0~6.\n", idx));
				break;
			}
		}

		if (idx != 7) {
			DBGPRINT(RT_DEBUG_ERROR,
				 ("Wrong OBSSScanParamtetrs format in dat file!!!!! Use default value.\n"));
			/* Unit : TU. 5~1000 */
			pAd->CommonCfg.Dot11OBssScanPassiveDwell = dot11OBSSScanPassiveDwell;
			/* Unit : TU. 10~1000 */
			pAd->CommonCfg.Dot11OBssScanActiveDwell = dot11OBSSScanActiveDwell;
			/* Unit : Second*/
			pAd->CommonCfg.Dot11BssWidthTriggerScanInt
			= dot11BSSWidthTriggerScanInterval;
			/* Unit : TU. 200~10000 */
			pAd->CommonCfg.Dot11OBssScanPassiveTotalPerChannel
			= dot11OBSSScanPassiveTotalPerChannel;
			/* Unit : TU. 20~10000 */
			pAd->CommonCfg.Dot11OBssScanActiveTotalPerChannel
			= dot11OBSSScanActiveTotalPerChannel;
			pAd->CommonCfg.Dot11BssWidthChanTranDelayFactor =
			    dot11BSSWidthChannelTransactionDelayFactor;
			pAd->CommonCfg.Dot11OBssScanActivityThre = dot11BSSScanActivityThreshold;
		}
		pAd->CommonCfg.Dot11BssWidthChanTranDelay =
		    (pAd->CommonCfg.Dot11BssWidthTriggerScanInt *
		     pAd->CommonCfg.Dot11BssWidthChanTranDelayFactor);
		DBGPRINT(RT_DEBUG_TRACE,
			 ("OBSSScanParam for Dot11BssWidthChanTranDelay=%ld\n",
			  pAd->CommonCfg.Dot11BssWidthChanTranDelay));
	}

	if (RTMPGetKeyParameter("HT_BSSCoexistence", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				__func__, __LINE__, ret));
			return;
		}

		pAd->CommonCfg.bBssCoexEnable = ((Value == 1) ? TRUE : FALSE);

		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: 20/40 BssCoexSupport = %s\n",
			  (pAd->CommonCfg.bBssCoexEnable == TRUE) ? "ON" : "OFF"));
	}

	if (RTMPGetKeyParameter("HT_BSSCoexApCntThr", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		pAd->CommonCfg.BssCoexApCntThr = Value;
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: 20/40 BssCoexApCntThr = %d\n", pAd->CommonCfg.BssCoexApCntThr));
	}

	if (RTMPGetKeyParameter("BurstMode", pValueStr, 25, pInput, TRUE)) {
		ret = os_strtol(pValueStr, 10, &Value);
		if (ret < 0) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
				 __func__, __LINE__, ret));
			return;
		}

		pAd->CommonCfg.bRalinkBurstMode = ((Value == 1) ? 1 : 0);
		DBGPRINT(RT_DEBUG_TRACE,
			 ("HT: RaBurstMode= %d\n", pAd->CommonCfg.bRalinkBurstMode));
	}

}

#ifdef CONFIG_STA_SUPPORT
static void RTMPSetSTASSID(RTMP_ADAPTER *pAd, PSTRING SSID)
{
	pAd->CommonCfg.SsidLen = (UCHAR) strlen(SSID);
	NdisZeroMemory(pAd->CommonCfg.Ssid, NDIS_802_11_LENGTH_SSID);
	NdisMoveMemory(pAd->CommonCfg.Ssid, SSID, pAd->CommonCfg.SsidLen);
	pAd->CommonCfg.LastSsidLen = pAd->CommonCfg.SsidLen;
	NdisZeroMemory(pAd->CommonCfg.LastSsid, NDIS_802_11_LENGTH_SSID);
	NdisMoveMemory(pAd->CommonCfg.LastSsid, SSID, pAd->CommonCfg.LastSsidLen);
	pAd->MlmeAux.AutoReconnectSsidLen = pAd->CommonCfg.SsidLen;
	NdisZeroMemory(pAd->MlmeAux.AutoReconnectSsid, NDIS_802_11_LENGTH_SSID);
	NdisMoveMemory(pAd->MlmeAux.AutoReconnectSsid, SSID, pAd->MlmeAux.AutoReconnectSsidLen);
	pAd->MlmeAux.SsidLen = pAd->CommonCfg.SsidLen;
	NdisZeroMemory(pAd->MlmeAux.Ssid, NDIS_802_11_LENGTH_SSID);
	NdisMoveMemory(pAd->MlmeAux.Ssid, SSID, pAd->MlmeAux.SsidLen);
}

static void RTMPSetSTAPassPhrase(RTMP_ADAPTER *pAd, PSTRING PassPh)
{
	struct wifi_dev *wdev = &pAd->StaCfg.wdev;
	int ret = TRUE;

	PassPh[strlen(PassPh)] = '\0';	/* make STA can process .$^& for WPAPSK input */

	if ((wdev->AuthMode != Ndis802_11AuthModeWPAPSK) &&
	    (wdev->AuthMode != Ndis802_11AuthModeWPA2PSK) &&
	    (wdev->AuthMode != Ndis802_11AuthModeWPANone)
#ifdef WAPI_SUPPORT
	    && (wdev->AuthMode != Ndis802_11AuthModeWAICERT)
	    && (wdev->AuthMode != Ndis802_11AuthModeWAIPSK)
#endif /* WAPI_SUPPORT */
	    ) {
		ret = FALSE;
	} else {
		ret =
		    RT_CfgSetWPAPSKKey(pAd, PassPh, strlen(PassPh), (PUCHAR) pAd->CommonCfg.Ssid,
				       pAd->CommonCfg.SsidLen, pAd->StaCfg.PMK);
	}

	if (ret == TRUE) {
		RTMPZeroMemory(pAd->StaCfg.WpaPassPhrase, 64);
		RTMPMoveMemory(pAd->StaCfg.WpaPassPhrase, PassPh, strlen(PassPh));
		pAd->StaCfg.WpaPassPhraseLen = strlen(PassPh);

		if ((wdev->AuthMode == Ndis802_11AuthModeWPAPSK) ||
		    (wdev->AuthMode == Ndis802_11AuthModeWPA2PSK)) {
			/* Start STA supplicant state machine */
			pAd->StaCfg.WpaState = SS_START;
		} else if (wdev->AuthMode == Ndis802_11AuthModeWPANone) {
			pAd->StaCfg.WpaState = SS_NOTUSE;
		}
#ifdef WSC_STA_SUPPORT
		NdisZeroMemory(pAd->StaCfg.WscControl.WpaPsk, 64);
		pAd->StaCfg.WscControl.WpaPskLen = 0;
		if ((strlen(PassPh) >= 8) && (strlen(PassPh) <= 64)) {
			NdisMoveMemory(pAd->StaCfg.WscControl.WpaPsk, PassPh, strlen(PassPh));
			pAd->StaCfg.WscControl.WpaPskLen = strlen(PassPh);
		}
#endif /* WSC_STA_SUPPORT */
		DBGPRINT(RT_DEBUG_TRACE, ("%s::(WPAPSK=%s)\n", __func__, PassPh));
	}
}

static inline void RTMPSetSTACipherSuites(RTMP_ADAPTER *pAd,
					  NDIS_802_11_ENCRYPTION_STATUS WepStatus)
{
	/* Update all wepstatus related */
	pAd->StaCfg.PairCipher = WepStatus;
	pAd->StaCfg.GroupCipher = WepStatus;
	pAd->StaCfg.bMixCipher = FALSE;
}

#ifdef CREDENTIAL_STORE

/*RECOVER THE OLD CONNECT INFO */
NDIS_STATUS RecoverConnectInfo(IN RTMP_ADAPTER *pAd)
{
	INT idx;
	char ssidStr[NDIS_802_11_LENGTH_SSID + 1];

	NdisZeroMemory(&ssidStr[0], sizeof(ssidStr));

	RTMP_SEM_LOCK(&pAd->StaCtIf.Lock);
	if ((pAd->StaCtIf.Changeable == FALSE) || (pAd->StaCtIf.SsidLen > NDIS_802_11_LENGTH_SSID)) {
		DBGPRINT(RT_DEBUG_TRACE, (" DRIVER INIT  not need to RecoverConnectInfo()\n"));
		RTMP_SEM_UNLOCK(&pAd->StaCtIf.Lock);
		return 0;
	}
	DBGPRINT(RT_DEBUG_TRACE, ("-->RecoverConnectInfo()\n"));

	NdisMoveMemory(ssidStr, pAd->StaCtIf.Ssid, pAd->StaCtIf.SsidLen);
	RTMPSetSTASSID(pAd, &ssidStr[0]);

	pAd->StaCfg.AuthMode = pAd->StaCtIf.AuthMode;
	pAd->StaCfg.WepStatus = pAd->StaCtIf.WepStatus;
#ifdef WPA_SUPPLICANT_SUPPORT
	pAd->StaCfg.wdev.IEEE8021X = pAd->StaCtIf.IEEE8021X;
	pAd->StaCfg.wpa_supplicant_info.DesireSharedKeyId = pAd->StaCtIf.DefaultKeyId;
#endif /* WPA_SUPPLICANT_SUPPORT // */
	pAd->StaCfg.DefaultKeyId = pAd->StaCtIf.DefaultKeyId;
	NdisMoveMemory(pAd->StaCfg.PMK, pAd->StaCtIf.PMK, 32);
	RTMPMoveMemory(pAd->StaCfg.WpaPassPhrase, pAd->StaCtIf.WpaPassPhrase,
		       pAd->StaCfg.WpaPassPhraseLen);
	pAd->StaCfg.WpaPassPhraseLen = pAd->StaCtIf.WpaPassPhraseLen;
	for (idx = 0; idx < 4; idx++) {
		NdisMoveMemory(&pAd->SharedKey[BSS0][idx], &pAd->StaCtIf.SharedKey[BSS0][idx],
			       sizeof(CIPHER_KEY));
#ifdef WPA_SUPPLICANT_SUPPORT
		NdisMoveMemory(&pAd->StaCfg.wpa_supplicant_info.DesireSharedKey[idx],
			       &pAd->StaCtIf.SharedKey[BSS0][idx], sizeof(CIPHER_KEY));
#endif /* WPA_SUPPLICANT_SUPPORT // */

	}

	if ((pAd->StaCfg.AuthMode == Ndis802_11AuthModeWPAPSK) ||
	    (pAd->StaCfg.AuthMode == Ndis802_11AuthModeWPA2PSK)) {
		/* Start STA supplicant state machine */
		pAd->StaCfg.WpaState = SS_START;
	} else if (pAd->StaCfg.AuthMode == Ndis802_11AuthModeWPANone) {
		pAd->StaCfg.WpaState = SS_NOTUSE;
	}
	RTMP_SEM_UNLOCK(&pAd->StaCtIf.Lock);

	DBGPRINT(RT_DEBUG_TRACE, ("<--RecoverConnectInfo()\n"));

	return 0;
}

/*STORE THE CONNECT INFO*/
NDIS_STATUS StoreConnectInfo(IN RTMP_ADAPTER *pAd)
{
	INT idx;

	DBGPRINT(RT_DEBUG_TRACE, ("-->StoreConnectInfo()\n"));

	RTMP_SEM_LOCK(&pAd->StaCtIf.Lock);
	pAd->StaCtIf.Changeable = TRUE;
	pAd->StaCtIf.SsidLen = pAd->CommonCfg.SsidLen;
	NdisMoveMemory(pAd->StaCtIf.Ssid, pAd->CommonCfg.Ssid, pAd->CommonCfg.SsidLen);
	pAd->StaCtIf.AuthMode = pAd->StaCfg.AuthMode;
	pAd->StaCtIf.WepStatus = pAd->StaCfg.WepStatus;

	pAd->StaCtIf.DefaultKeyId = pAd->StaCfg.DefaultKeyId;
#ifdef WPA_SUPPLICANT_SUPPORT
	pAd->StaCtIf.wpa_supplicant_info.DefaultKeyId = pAd->StaCfg.DesireSharedKeyId;
	pAd->StaCtIf.IEEE8021X = pAd->StaCfg.wdev.IEEE8021X;
#endif /* WPA_SUPPLICANT_SUPPORT // */
	NdisMoveMemory(pAd->StaCtIf.PMK, pAd->StaCfg.PMK, 32);
	RTMPMoveMemory(pAd->StaCtIf.WpaPassPhrase, pAd->StaCfg.WpaPassPhrase,
		       pAd->StaCfg.WpaPassPhraseLen);
	pAd->StaCtIf.WpaPassPhraseLen = pAd->StaCfg.WpaPassPhraseLen;

	for (idx = 0; idx < 4; idx++)
		NdisMoveMemory(&pAd->StaCtIf.SharedKey[BSS0][idx], &pAd->SharedKey[BSS0][idx],
			       sizeof(CIPHER_KEY));

	RTMP_SEM_UNLOCK(&pAd->StaCtIf.Lock);

	DBGPRINT(RT_DEBUG_TRACE, ("<--StoreConnectInfo()\n"));

	return 0;
}

#endif /* CREDENTIAL_STORE */

#endif /* CONFIG_STA_SUPPORT */

static void RTMPSetCountryCode(RTMP_ADAPTER *pAd, PSTRING CountryCode)
{
	NdisMoveMemory(pAd->CommonCfg.CountryCode, CountryCode, 2);
	pAd->CommonCfg.CountryCode[2] = ' ';
#ifdef CONFIG_STA_SUPPORT
#ifdef EXT_BUILD_CHANNEL_LIST
	IF_DEV_CONFIG_OPMODE_ON_STA(pAd)
	    NdisMoveMemory(pAd->StaCfg.StaOriCountryCode, CountryCode, 2);
#endif /* EXT_BUILD_CHANNEL_LIST */
#endif /* CONFIG_STA_SUPPORT */
	if (strlen((PSTRING) pAd->CommonCfg.CountryCode) != 0)
		pAd->CommonCfg.bCountryFlag = TRUE;

	DBGPRINT(RT_DEBUG_TRACE, ("CountryCode=%s\n", pAd->CommonCfg.CountryCode));
}

NDIS_STATUS RTMPSetProfileParameters(IN RTMP_ADAPTER *pAd, IN const char *pBuffer)
{
	PSTRING tmpbuf;
	ULONG RtsThresh;
	ULONG FragThresh;
	PSTRING macptr;
	INT i = 0, retval;
	INT ret;
	LONG longtmp;

	os_alloc_vmem(NULL, (UCHAR **) &tmpbuf, MAX_PARAM_BUFFER_SIZE);
	if (tmpbuf == NULL)
		return NDIS_STATUS_FAILURE;

	do {
		/* set file parameter to portcfg */
		if (RTMPGetKeyParameter("MacAddress", tmpbuf, 25, pBuffer, TRUE)) {
			retval = RT_CfgSetMacAddress(pAd, tmpbuf);
			if (retval)
				DBGPRINT(RT_DEBUG_TRACE,
					 ("MacAddress = %02x:%02x:%02x:%02x:%02x:%02x\n",
					  PRINT_MAC(pAd->CurrentAddress)));
		}
		/*CountryRegion */
		if (RTMPGetKeyParameter("CountryRegion", tmpbuf, 25, pBuffer, TRUE)) {
			retval = RT_CfgSetCountryRegion(pAd, tmpbuf, BAND_24G);
			DBGPRINT(RT_DEBUG_TRACE,
				 ("CountryRegion=%d\n", pAd->CommonCfg.CountryRegion));
		}
		/*CountryRegionABand */
		if (RTMPGetKeyParameter("CountryRegionABand", tmpbuf, 25, pBuffer, TRUE)) {
			retval = RT_CfgSetCountryRegion(pAd, tmpbuf, BAND_5G);
			DBGPRINT(RT_DEBUG_TRACE,
				 ("CountryRegionABand=%d\n", pAd->CommonCfg.CountryRegionForABand));
		}

		/* E2pAccessMode */
		if (RTMPGetKeyParameter("E2pAccessMode", tmpbuf, 25, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->E2pAccessMode = (UCHAR)longtmp;
			DBGPRINT(RT_DEBUG_OFF, ("E2pAccessMode=%d\n", pAd->E2pAccessMode));
			RtmpChipOpsEepromHook(pAd, pAd->infType);
		}

		/*CountryCode */
		if (pAd->CommonCfg.bCountryFlag == 0) {
			if (RTMPGetKeyParameter("CountryCode", tmpbuf, 25, pBuffer, TRUE))
				RTMPSetCountryCode(pAd, tmpbuf);
		}
#ifdef EXT_BUILD_CHANNEL_LIST
		/*ChannelGeography */
		if (RTMPGetKeyParameter("ChannelGeography", tmpbuf, 25, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			UCHAR Geography = (UCHAR) longtmp;

			if (Geography <= BOTH) {
				pAd->CommonCfg.Geography = Geography;
				pAd->CommonCfg.CountryCode[2] =
				    (pAd->CommonCfg.Geography ==
				     BOTH) ? ' ' : ((pAd->CommonCfg.Geography == IDOR) ? 'I' : 'O');
#ifdef CONFIG_STA_SUPPORT
#ifdef EXT_BUILD_CHANNEL_LIST
				IF_DEV_CONFIG_OPMODE_ON_STA(pAd)
				    pAd->StaCfg.StaOriGeography = pAd->CommonCfg.Geography;
#endif /* EXT_BUILD_CHANNEL_LIST */
#endif /* CONFIG_STA_SUPPORT */
				DBGPRINT(RT_DEBUG_TRACE,
					 ("ChannelGeography=%d\n", pAd->CommonCfg.Geography));
			}
		} else {
			pAd->CommonCfg.Geography = BOTH;
			pAd->CommonCfg.CountryCode[2] = ' ';
		}
#endif /* EXT_BUILD_CHANNEL_LIST */

#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
#ifdef MBSS_SUPPORT
			/*BSSIDNum; This must read first of other multiSSID field,
			so list this field first in configuration file */
			if (RTMPGetKeyParameter("BssidNum", tmpbuf, 25, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				pAd->ApCfg.BssidNum = (UCHAR) longtmp;
				if (pAd->ApCfg.BssidNum > MAX_MBSSID_NUM(pAd)) {
					pAd->ApCfg.BssidNum = MAX_MBSSID_NUM(pAd);
					DBGPRINT(RT_DEBUG_TRACE,
						 ("BssidNum=%d(MAX_MBSSID_NUM is %d)\n",
						  pAd->ApCfg.BssidNum, MAX_MBSSID_NUM(pAd)));
				} else
					DBGPRINT(RT_DEBUG_TRACE,
						 ("BssidNum=%d\n", pAd->ApCfg.BssidNum));
			}

			if (HW_BEACON_OFFSET > (HW_BEACON_MAX_SIZE(pAd) / pAd->ApCfg.BssidNum)) {
				DBGPRINT(RT_DEBUG_OFF,
				("mbss> fatal error! beacon offset is error in driver! Please re-assign HW_BEACON_OFFSET!\n"));
			}
#else
			pAd->ApCfg.BssidNum = 1;
#endif /* MBSS_SUPPORT */
		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
			/* SSID */
			if (TRUE) {
				STRING tok_str[16];
				UCHAR BssidCountSupposed = 0;
				BOOLEAN bSSIDxIsUsed = FALSE;

				/* PRINT(RT_DEBUG_TRACE, ("pAd->ApCfg.BssidNum=%d\n", pAd->ApCfg.BssidNum)); */
				for (i = 0; i < pAd->ApCfg.BssidNum; i++) {
					snprintf(tok_str, sizeof(tok_str), "SSID%d", i + 1);
					if (RTMPGetKeyParameter
					    (tok_str, tmpbuf, 33, pBuffer, FALSE)) {
						NdisMoveMemory(pAd->ApCfg.MBSSID[i].Ssid, tmpbuf,
							       strlen(tmpbuf));
						pAd->ApCfg.MBSSID[i].Ssid[strlen(tmpbuf)] = '\0';
						pAd->ApCfg.MBSSID[i].SsidLen =
						    strlen((PSTRING) pAd->ApCfg.MBSSID[i].Ssid);
						if (bSSIDxIsUsed == FALSE)
							bSSIDxIsUsed = TRUE;
						DBGPRINT(RT_DEBUG_TRACE,
							 ("SSID[%d]=%s\n", i,
							  pAd->ApCfg.MBSSID[i].Ssid));
					}
				}
				if (bSSIDxIsUsed == FALSE) {
					if (RTMPGetKeyParameter
					    ("SSID", tmpbuf, 256, pBuffer, FALSE)) {
						BssidCountSupposed = delimitcnt(tmpbuf, ";") + 1;
						if (pAd->ApCfg.BssidNum != BssidCountSupposed)
							DBGPRINT_ERR(
							("Your SSIDs no(= %d) does not match BssidNum(= %d)!\n",
							BssidCountSupposed, pAd->ApCfg.BssidNum));
						if (pAd->ApCfg.BssidNum > 1) {
							/* Anyway, we still do the legacy dissection
							of the whole SSID string. */
							for (i = 0, macptr = rstrtok(tmpbuf, ";");
							     macptr;
							     macptr = rstrtok(NULL, ";"), i++) {
								int apidx = 0;

								if (i < pAd->ApCfg.BssidNum)
									apidx = i;
								else
									break;

								NdisMoveMemory(pAd->ApCfg.
									       MBSSID[apidx].Ssid,
									       macptr,
									       strlen(macptr));
								pAd->ApCfg.MBSSID[apidx].
								    Ssid[strlen(macptr)] = '\0';
								pAd->ApCfg.MBSSID[apidx].SsidLen =
								    strlen((PSTRING) pAd->ApCfg.
									   MBSSID[apidx].Ssid);

								DBGPRINT(RT_DEBUG_TRACE,
									 ("SSID[%d]=%s\n", i,
									  pAd->ApCfg.MBSSID[apidx].
									  Ssid));
							}
						} else {
							if ((strlen(tmpbuf) > 0)
							    && (strlen(tmpbuf) <= 32)) {
								NdisMoveMemory(pAd->ApCfg.
									       MBSSID[BSS0].Ssid,
									       tmpbuf,
									       strlen(tmpbuf));
								pAd->ApCfg.MBSSID[BSS0].
								    Ssid[strlen(tmpbuf)] = '\0';
								pAd->ApCfg.MBSSID[BSS0].SsidLen =
								    strlen((PSTRING) pAd->ApCfg.
									   MBSSID[BSS0].Ssid);
								DBGPRINT(RT_DEBUG_TRACE,
									 ("SSID=%s\n",
									  pAd->ApCfg.MBSSID[BSS0].
									  Ssid));
							}
						}
					}
				}
			}
		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
			 /*SSID*/ if (RTMPGetKeyParameter("SSID", tmpbuf, 256, pBuffer, FALSE)) {
				if (strlen(tmpbuf) <= 32) {
					RTMPSetSTASSID(pAd, tmpbuf);
					DBGPRINT(RT_DEBUG_TRACE,
						 ("%s::(SSID=%s)\n", __func__, tmpbuf));
				}
			}
		}
#endif /* CONFIG_STA_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
			/*NetworkType */
			if (RTMPGetKeyParameter("NetworkType", tmpbuf, 25, pBuffer, TRUE)) {
				pAd->bConfigChanged = TRUE;
				if (strcmp(tmpbuf, "Adhoc") == 0)
					pAd->StaCfg.BssType = BSS_ADHOC;
				else	/*Default Infrastructure mode */
					pAd->StaCfg.BssType = BSS_INFRA;
				/* Reset Ralink supplicant to not use, it will be set to start when UI set PMK key */
				pAd->StaCfg.WpaState = SS_NOTUSE;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("%s::(NetworkType=%d)\n", __func__, pAd->StaCfg.BssType));
			}
		}
#endif /* CONFIG_STA_SUPPORT */
		/*Channel */
		if (RTMPGetKeyParameter("Channel", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			if ((UCHAR)longtmp != 0)
				pAd->CommonCfg.Channel = (UCHAR)longtmp;
			else
				pAd->CommonCfg.Channel = 1;
			DBGPRINT(RT_DEBUG_TRACE, ("Channel=%d\n", pAd->CommonCfg.Channel));
			if (pAd->CommonCfg.Channel > 14)
				pAd->Dot11_H.org_ch = pAd->CommonCfg.Channel;
		}

		/*WirelessMode */
		/*Note: BssidNum must be put before WirelessMode in dat file */
		if (RTMPGetKeyParameter("WirelessMode", tmpbuf, 32, pBuffer, TRUE)) {
			UCHAR cfg_mode;

			for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
			     macptr = rstrtok(NULL, ";"), i++) {
				ret = os_strtol(macptr, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				cfg_mode = longtmp;
#ifdef CONFIG_AP_SUPPORT
				if (i >= pAd->ApCfg.BssidNum)
					break;

				pAd->ApCfg.MBSSID[i].wdev.PhyMode = cfgmode_2_wmode(cfg_mode);
				DBGPRINT(RT_DEBUG_TRACE,
					 ("BSS%d PhyMode=%d\n", i,
					  pAd->ApCfg.MBSSID[i].wdev.PhyMode));
#endif /* CONFIG_AP_SUPPORT */

				if (i == 0) {
#ifdef CONFIG_AP_SUPPORT
#ifdef MBSS_SUPPORT
					/* for first time, update all phy mode is same as ra0 */
					{
						UINT32 IdBss;

						for (IdBss = 1; IdBss < pAd->ApCfg.BssidNum;
						     IdBss++)
							pAd->ApCfg.MBSSID[IdBss].wdev.PhyMode =
							    pAd->ApCfg.MBSSID[0].wdev.PhyMode;
					}
#endif /* MBSS_SUPPORT */
#endif /* CONFIG_AP_SUPPORT */
					/* set mode for 1st time */
					RT_CfgSetWirelessMode(pAd, macptr);
				}
#ifdef CONFIG_AP_SUPPORT
#ifdef MBSS_SUPPORT
				else
					RT_CfgSetMbssWirelessMode(pAd, macptr);
#endif /* MBSS_SUPPORT */
#endif /* CONFIG_AP_SUPPORT */
			}

			DBGPRINT(RT_DEBUG_TRACE, ("PhyMode=%d\n", pAd->CommonCfg.PhyMode));
		}

		/*BasicRate */
		if (RTMPGetKeyParameter("BasicRate", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			pAd->CommonCfg.BasicRateBitmap = longtmp;

			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->CommonCfg.BasicRateBitmapOld = longtmp;

			DBGPRINT(RT_DEBUG_TRACE,
				("BasicRate=%ld\n", pAd->CommonCfg.BasicRateBitmap));
		}
		/*BeaconPeriod */
		if (RTMPGetKeyParameter("BeaconPeriod", tmpbuf, 10, pBuffer, TRUE)) {
			USHORT bcn_val;

			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			bcn_val = (USHORT) longtmp;

			/* The acceptable is 20~1000 ms. Refer to WiFi test plan. */
			if (bcn_val >= 20 && bcn_val <= 1000)
				pAd->CommonCfg.BeaconPeriod = bcn_val;
			else
				pAd->CommonCfg.BeaconPeriod = 100;	/* Default value */

#ifdef APCLI_CONNECTION_TRIAL
			pAd->CommonCfg.BeaconPeriod = 200;
#endif /* APCLI_CONNECTION_TRIAL */

			DBGPRINT(RT_DEBUG_TRACE,
				 ("BeaconPeriod=%d\n", pAd->CommonCfg.BeaconPeriod));
		}
#ifdef CONFIG_AP_SUPPORT
#ifdef DFS_SUPPORT
		/*DFSIndoor */
		{
			PRADAR_DETECT_STRUCT pRadarDetect = &pAd->CommonCfg.RadarDetect;
			PDFS_PROGRAM_PARAM pDfsProgramParam = &pRadarDetect->DfsProgramParam;

			if (RTMPGetKeyParameter("DfsIndoor", tmpbuf, 10, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
					pAd->Dot11_H.bDFSIndoor = (USHORT) longtmp;

					DBGPRINT(RT_DEBUG_TRACE,
						("DfsIndoor=%d\n", pAd->Dot11_H.bDFSIndoor));
			}
			{
				INT k = 0;
				/*SymRoundFromCfg */
				if (RTMPGetKeyParameter
					("SymRoundFromCfg", tmpbuf, 10, pBuffer, TRUE)) {
					ret = os_strtol(tmpbuf, 10, &longtmp);
					if (ret < 0)
						return FALSE;
					pRadarDetect->SymRoundFromCfg = (UCHAR) longtmp);
					pRadarDetect->SymRoundCfgValid = 1;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("SymRoundFromCfg=%d\n",
						  pRadarDetect->SymRoundFromCfg));
				}

				/*BusyIdleFromCfg */
				if (RTMPGetKeyParameter
					("BusyIdleFromCfg", tmpbuf, 10, pBuffer, TRUE)) {
					ret = os_strtol(tmpbuf, 10, &longtmp);
					if (ret < 0)
						return FALSE;
					pRadarDetect->BusyIdleFromCfg = (UCHAR) longtmp;
					pRadarDetect->BusyIdleCfgValid = 1;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("BusyIdleFromCfg=%d\n",
						  pRadarDetect->BusyIdleFromCfg));
				}
				/*DfsRssiHighFromCfg */
				if (RTMPGetKeyParameter
					("DfsRssiHighFromCfg", tmpbuf, 10, pBuffer, TRUE)) {
					ret = os_strtol(tmpbuf, 10, &longtmp);
					if (ret < 0)
						return FALSE;
					pRadarDetect->DfsRssiHighFromCfg = longtmp;
					pRadarDetect->DfsRssiHighCfgValid = 1;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("DfsRssiHighFromCfg=%d\n",
						  pRadarDetect->DfsRssiHighFromCfg));
				}

				/*DfsRssiLowFromCfg */
				if (RTMPGetKeyParameter
					("DfsRssiLowFromCfg", tmpbuf, 10, pBuffer, TRUE)) {
					ret = os_strtol(tmpbuf, 10, &longtmp);
					if (ret < 0)
						return FALSE;
					pRadarDetect->DfsRssiLowFromCfg = longtmp;
					pRadarDetect->DfsRssiLowCfgValid = 1;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("DfsRssiLowFromCfg=%d\n",
						  pRadarDetect->DfsRssiLowFromCfg));
				}

				/*DFSParamFromConfig */
				if (RTMPGetKeyParameter
					("DFSParamFromConfig", tmpbuf, 10, pBuffer, TRUE)) {
					ret = os_strtol(tmpbuf, 10, &longtmp);
					if (ret < 0)
						return FALSE;
					pRadarDetect->DFSParamFromConfig = (UCHAR) longtmp;

					DBGPRINT(RT_DEBUG_TRACE,
						 ("DFSParamFromConfig=%d\n",
						  pRadarDetect->DFSParamFromConfig));
				}

				/* DFSParam */
				for (k = 0; k < 4 * pAd->chipCap.DfsEngineNum; k++) {
					STRING tok_str[32];
					INT index;
					UINT8 DfsEngineNum = pAd->chipCap.DfsEngineNum;

					index = (k % DfsEngineNum);
					if (((k - k % DfsEngineNum) / DfsEngineNum) == 0)
						snprintf(tok_str, sizeof(tok_str), "FCCParamCh%d",
							 index);
					else if (((k - k % DfsEngineNum) / DfsEngineNum) == 1)
						snprintf(tok_str, sizeof(tok_str), "CEParamCh%d",
							 index);
					else if (((k - k % DfsEngineNum) / DfsEngineNum) == 2)
						snprintf(tok_str, sizeof(tok_str), "JAPParamCh%d",
							 index);
					else if (((k - k % DfsEngineNum) / DfsEngineNum) == 3)
						snprintf(tok_str, sizeof(tok_str),
							 "JAPW53ParamCh%d", index);

					if (RTMPGetKeyParameter
					    (tok_str, tmpbuf, 128, pBuffer, TRUE)) {
						ULONG DfsParam;

						for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
							macptr = rstrtok(NULL, ";"), i++) {
							ret = os_strtol(macptr, 10, &longtmp);
							if (ret < 0)
								return FALSE;

							DfsParam = longtmp;
							switch (i) {
							case 0:
								pDfsProgramParam->NewDFSTableEntry
								    [k].mode = DfsParam;
								break;
							case 1:
								pDfsProgramParam->NewDFSTableEntry
								    [k].avgLen = DfsParam;
								pDfsProgramParam->NewDFSTableEntry
								    [k].valid = 1;
								break;
							case 2:
								pDfsProgramParam->NewDFSTableEntry
								    [k].ELow = DfsParam;
								break;
							case 3:
								pDfsProgramParam->NewDFSTableEntry
								    [k].EHigh = DfsParam;
								break;
							case 4:
								pDfsProgramParam->NewDFSTableEntry
								    [k].WLow = DfsParam;
								break;
							case 5:
								pDfsProgramParam->NewDFSTableEntry
								    [k].WHigh = DfsParam;
								break;
							case 6:
								pDfsProgramParam->NewDFSTableEntry
								    [k].EpsilonW = DfsParam;
								break;
							case 7:
								pDfsProgramParam->NewDFSTableEntry
								    [k].TLow = DfsParam;
								break;
							case 8:
								pDfsProgramParam->NewDFSTableEntry
								    [k].THigh = DfsParam;
								break;
							case 9:
								pDfsProgramParam->NewDFSTableEntry
								    [k].EpsilonT = DfsParam;
								break;

							case 10:
								pDfsProgramParam->NewDFSTableEntry
								    [k].BLow = DfsParam;
								break;
							case 11:
								pDfsProgramParam->NewDFSTableEntry
								    [k].BHigh = DfsParam;
								break;

							default:
								break;
							}
						}
					}
				}
			}
		}
#endif /* DFS_SUPPORT */
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
			/*DtimPeriod */
			if (RTMPGetKeyParameter("DtimPeriod", tmpbuf, 10, pBuffer, TRUE)) {
				long tmp = 0;

				ret = os_strtol(tmpbuf, 10, &tmp);
				if (ret < 0)
					return FALSE;

				pAd->ApCfg.DtimPeriod[MAIN_MBSSID] = tmp;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("DtimPeriod=%d\n",
					  pAd->ApCfg.DtimPeriod[MAIN_MBSSID]));
			}
		}
#endif /* CONFIG_AP_SUPPORT */
		/*TxPower */
		if (RTMPGetKeyParameter("TxPower", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			pAd->CommonCfg.TxPowerPercentage = (ULONG) longtmp;
#ifdef CONFIG_STA_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_STA(pAd)
			    pAd->CommonCfg.TxPowerDefault = pAd->CommonCfg.TxPowerPercentage;
#endif /* CONFIG_STA_SUPPORT */
			DBGPRINT(RT_DEBUG_TRACE,
				 ("TxPower=%ld\n", pAd->CommonCfg.TxPowerPercentage));
		}
		/*BGProtection */
		if (RTMPGetKeyParameter("BGProtection", tmpbuf, 10, pBuffer, TRUE)) {
			/*#if 0 #ifndef WIFI_TEST */
			/*pAd->CommonCfg.UseBGProtection = 2;
			disable b/g protection for throughput test */
			/*#else */
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			switch (longtmp) {
			case 1:	/*Always On */
				pAd->CommonCfg.UseBGProtection = 1;
				break;
			case 2:	/*Always OFF */
				pAd->CommonCfg.UseBGProtection = 2;
				break;
			case 0:
			 /*AUTO*/ default:
				pAd->CommonCfg.UseBGProtection = 0;
				break;
			}
			/*#endif */
			DBGPRINT(RT_DEBUG_TRACE,
				 ("BGProtection=%ld\n", pAd->CommonCfg.UseBGProtection));
		}
#ifdef CONFIG_AP_SUPPORT
		/*OLBCDetection */
		if (RTMPGetKeyParameter("DisableOLBC", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			switch (longtmp) {
			case 1:	/*disable OLBC Detection */
				pAd->CommonCfg.DisableOLBCDetect = 1;
				break;
			case 0:	/*enable OLBC Detection */
				pAd->CommonCfg.DisableOLBCDetect = 0;
				break;
			default:
				pAd->CommonCfg.DisableOLBCDetect = 0;
				break;
			}
			DBGPRINT(RT_DEBUG_TRACE,
				 ("OLBCDetection=%ld\n", pAd->CommonCfg.DisableOLBCDetect));
		}
#endif /* CONFIG_AP_SUPPORT */
		/*TxPreamble */
		if (RTMPGetKeyParameter("TxPreamble", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			switch (longtmp) {
			case Rt802_11PreambleShort:
				pAd->CommonCfg.TxPreamble = Rt802_11PreambleShort;
				break;
			case Rt802_11PreambleLong:
			default:
				pAd->CommonCfg.TxPreamble = Rt802_11PreambleLong;
				break;
			}
			DBGPRINT(RT_DEBUG_TRACE, ("TxPreamble=%ld\n", pAd->CommonCfg.TxPreamble));
		}
		/*RTSThreshold */
		if (RTMPGetKeyParameter("RTSThreshold", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			RtsThresh = longtmp;
			if ((RtsThresh >= 1) && (RtsThresh <= MAX_RTS_THRESHOLD))
				pAd->CommonCfg.RtsThreshold = (USHORT) RtsThresh;
			else
				pAd->CommonCfg.RtsThreshold = MAX_RTS_THRESHOLD;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("RTSThreshold=%d\n", pAd->CommonCfg.RtsThreshold));
		}
		/*FragThreshold */
		if (RTMPGetKeyParameter("FragThreshold", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			FragThresh = longtmp;
			pAd->CommonCfg.bUseZeroToDisableFragment = FALSE;

			if (FragThresh > MAX_FRAG_THRESHOLD || FragThresh < MIN_FRAG_THRESHOLD) {
				/*illegal FragThresh so we set it to default */
				pAd->CommonCfg.FragmentThreshold = MAX_FRAG_THRESHOLD;
				pAd->CommonCfg.bUseZeroToDisableFragment = TRUE;
			} else if (FragThresh % 2 == 1) {
				/* The length of each fragment shall always be an even
				number of octets, except for the last fragment */
				/* of an MSDU or MMPDU, which may be either an even or
				an odd number of octets. */
				pAd->CommonCfg.FragmentThreshold = (USHORT) (FragThresh - 1);
			} else {
				pAd->CommonCfg.FragmentThreshold = (USHORT) FragThresh;
			}
			/*pAd->CommonCfg.AllowFragSize = (pAd->CommonCfg.FragmentThreshold)
			- LENGTH_802_11 - LENGTH_CRC; */
			DBGPRINT(RT_DEBUG_TRACE,
				 ("FragThreshold=%d\n", pAd->CommonCfg.FragmentThreshold));
		}
		/*TxBurst */
		if (RTMPGetKeyParameter("TxBurst", tmpbuf, 10, pBuffer, TRUE)) {
			/*#ifdef WIFI_TEST */
			/*                                              pAd->CommonCfg.bEnableTxBurst = FALSE; */
			/*#else */
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			if (longtmp != 0)	/*Enable */
				pAd->CommonCfg.bEnableTxBurst = TRUE;
			else	/*Disable */
				pAd->CommonCfg.bEnableTxBurst = FALSE;
			/*#endif */
			DBGPRINT(RT_DEBUG_TRACE, ("TxBurst=%d\n", pAd->CommonCfg.bEnableTxBurst));
		}
#ifdef AGGREGATION_SUPPORT
		/*PktAggregate */
		if (RTMPGetKeyParameter("PktAggregate", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			if (longtmp != 0)	/*Enable */
				pAd->CommonCfg.bAggregationCapable = TRUE;
			else	/*Disable */
				pAd->CommonCfg.bAggregationCapable = FALSE;
#ifdef PIGGYBACK_SUPPORT
			pAd->CommonCfg.bPiggyBackCapable = pAd->CommonCfg.bAggregationCapable;
#endif /* PIGGYBACK_SUPPORT */
			DBGPRINT(RT_DEBUG_TRACE,
				 ("PktAggregate=%d\n", pAd->CommonCfg.bAggregationCapable));
		}
#else
		pAd->CommonCfg.bAggregationCapable = FALSE;
		pAd->CommonCfg.bPiggyBackCapable = FALSE;
#endif /* AGGREGATION_SUPPORT */

		/* WmmCapable */
#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd)
		    rtmp_read_ap_wmm_parms_from_file(pAd, tmpbuf, pBuffer);
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
			rtmp_read_sta_wmm_parms_from_file(pAd, tmpbuf, pBuffer);
#ifdef XLINK_SUPPORT
			rtmp_get_psp_xlink_mode_from_file(pAd, tmpbuf, pBuffer);
#endif /* XLINK_SUPPORT */
		}
#endif /* CONFIG_STA_SUPPORT */

#ifdef CONFIG_AP_SUPPORT
#if defined(RT_CFG80211_P2P_SUPPORT) && defined(SUPPORT_ACS_ALL_CHANNEL_RANK)
		/*AutoChannelSelectAlg */
		if (RTMPGetKeyParameter("AutoChannelSelectAlg", tmpbuf, 10, pBuffer, TRUE)) {
			ChannelSel_Alg SelAlg;

			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			SelAlg = (ChannelSel_Alg) longtmp;

			if (SelAlg > 3 || SelAlg < 0) {
				/* force use default alg */
				pAd->ApCfg.AutoChannelAlg = ChannelAlgCombined;
			} else {
				/*  0: ChannelAlgCombined
				   1: ChannelAlgApCnt
				   2: ChannelAlgCCA
				   3: ChannelAlgRandom
				 */
				pAd->ApCfg.AutoChannelAlg = SelAlg;
			}
			pAd->ApCfg.bAutoChannelAtBootup = TRUE;
			pAd->ApCfg.bAutoChannelScaned = FALSE;
			DBGPRINT(RT_DEBUG_TRACE,
				 ("AutoChannelSelectAlg=%d, AutoChannelAtBootup=%d\n",
				  pAd->ApCfg.AutoChannelAlg, pAd->ApCfg.bAutoChannelAtBootup));
		}
#endif /* SUPPORT_ACS_ALL_CHANNEL_RANK */

		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
			/* MaxStaNum */
			if (RTMPGetKeyParameter("MaxStaNum", tmpbuf, 32, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					if (i >= pAd->ApCfg.BssidNum)
						break;

					ApCfg_Set_MaxStaNum_Proc(pAd, i, macptr);
				}
			}

			/* IdleTimeout */
			if (RTMPGetKeyParameter("IdleTimeout", tmpbuf, 10, pBuffer, TRUE))
				ApCfg_Set_IdleTimeout_Proc(pAd, tmpbuf);

			/*NoForwarding */
			if (RTMPGetKeyParameter("NoForwarding", tmpbuf, 32, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					if (i >= pAd->ApCfg.BssidNum)
						break;

					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					if (longtmp != 0)	/*Enable */
						pAd->ApCfg.MBSSID[i].IsolateInterStaTraffic = TRUE;
					else	/*Disable */
						pAd->ApCfg.MBSSID[i].IsolateInterStaTraffic = FALSE;

					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) NoForwarding=%ld\n", i,
						  pAd->ApCfg.MBSSID[i].IsolateInterStaTraffic));
				}
			}
			/* NoForwardingMBCast */
			if (RTMPGetKeyParameter("NoForwardingMBCast", tmpbuf, 32, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					if (i >= pAd->ApCfg.BssidNum)
						break;

					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					if (longtmp != 0)	/* Enable */
						pAd->ApCfg.MBSSID[i].IsolateInterStaMBCast = TRUE;
					else	/* Disable */
						pAd->ApCfg.MBSSID[i].IsolateInterStaMBCast = FALSE;

					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) NoForwardingMBCast=%d\n", i,
						  pAd->ApCfg.MBSSID[i].IsolateInterStaMBCast));
				}
			}

			/*NoForwardingBTNBSSID */
			if (RTMPGetKeyParameter("NoForwardingBTNBSSID", tmpbuf, 10, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				if (longtmp != 0)	/*Enable */
					pAd->ApCfg.IsolateInterStaTrafficBTNBSSID = TRUE;
				else	/*Disable */
					pAd->ApCfg.IsolateInterStaTrafficBTNBSSID = FALSE;

				DBGPRINT(RT_DEBUG_TRACE,
					 ("NoForwardingBTNBSSID=%ld\n",
					  pAd->ApCfg.IsolateInterStaTrafficBTNBSSID));
			}
			/*HideSSID */
			if (RTMPGetKeyParameter("HideSSID", tmpbuf, 32, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					int apidx = i;

					if (i >= pAd->ApCfg.BssidNum)
						break;

					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;
#ifdef WSC_V2_SUPPORT
					if (longtmp != 0) {

						pAd->ApCfg.MBSSID[apidx].WscControl.WscV2Info.
						    bWpsEnable = FALSE;
					}
#endif /* WSC_V2_SUPPORT */
					pAd->ApCfg.MBSSID[apidx].hidden_ssid = longtmp;

					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) HideSSID=%d\n", i,
						  pAd->ApCfg.MBSSID[apidx].hidden_ssid));
				}
			}

			/*StationKeepAlive */
			if (RTMPGetKeyParameter("StationKeepAlive", tmpbuf, 32, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					int apidx = i;

					if (i >= pAd->ApCfg.BssidNum)
						break;

					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					pAd->ApCfg.MBSSID[apidx].StationKeepAliveTime = longtmp;
#ifdef NOISE_TEST_ADJUST
					if (!pAd->ApCfg.MBSSID[apidx].StationKeepAliveTime)
						pAd->ApCfg.MBSSID[apidx].StationKeepAliveTime = 10;
					else if (pAd->ApCfg.MBSSID[apidx].StationKeepAliveTime ==
						 0xFF)
						pAd->ApCfg.MBSSID[apidx].StationKeepAliveTime = 0;
#endif /* NOISE_TEST_ADJUST */

					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) StationKeepAliveTime=%d\n", i,
						  pAd->ApCfg.MBSSID[apidx].StationKeepAliveTime));
				}
			}

			/*AutoChannelSelect */
			if (RTMPGetKeyParameter("AutoChannelSelect", tmpbuf, 10, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				if (longtmp != 0) {	/*Enable */
					ChannelSel_Alg SelAlg;

					ret = os_strtol(tmpbuf, 10, &longtmp);
					if (ret < 0)
						return FALSE;
					SelAlg = (ChannelSel_Alg) longtmp;

					if (SelAlg > 3 || SelAlg < 0) {
						pAd->ApCfg.bAutoChannelAtBootup = FALSE;
					} else {	/*Enable */

						/*  0: ChannelAlgCombined
						   1: ChannelAlgApCnt
						   2: ChannelAlgCCA
						   3: ChannelAlgRandom
						 */
						pAd->ApCfg.bAutoChannelAtBootup = TRUE;
						pAd->ApCfg.AutoChannelAlg = SelAlg;
					}
				} else	/*Disable */
					pAd->ApCfg.bAutoChannelAtBootup = FALSE;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("AutoChannelAtBootup=%d\n",
					  pAd->ApCfg.bAutoChannelAtBootup));
			}

			/*AutoChannelSkipList */
			if (RTMPGetKeyParameter("AutoChannelSkipList", tmpbuf, 50, pBuffer, FALSE)) {
				pAd->ApCfg.AutoChannelSkipListNum = delimitcnt(tmpbuf, ";") + 1;
				if (pAd->ApCfg.AutoChannelSkipListNum > 10) {
					DBGPRINT(RT_DEBUG_TRACE,
					("Your no. of AutoChannelSkipList( %d ) is larger than 10 (boundary)\n",
					pAd->ApCfg.AutoChannelSkipListNum));
					pAd->ApCfg.AutoChannelSkipListNum = 10;
				}

				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					if (i < pAd->ApCfg.AutoChannelSkipListNum) {
						ret = os_strtol(macptr, 10, &longtmp);
						if (ret < 0)
							return FALSE;
						pAd->ApCfg.AutoChannelSkipList[i] = longtmp;
						DBGPRINT(RT_DEBUG_TRACE,
							 (" AutoChannelSkipList[%d]= %d\n", i,
							  pAd->ApCfg.AutoChannelSkipList[i]));
					} else {
						break;
					}
				}
			}
#ifdef AP_SCAN_SUPPORT
			/*ACSCheckTime */
			if (RTMPGetKeyParameter("ACSCheckTime", tmpbuf, 32, pBuffer, TRUE)) {
				UINT8 Hour;

				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				Hour = longtmp;

				pAd->ApCfg.ACSCheckTime = Hour * 3600;	/* Hour to second */
				DBGPRINT(RT_DEBUG_TRACE, ("ACSCheckTime = %u (hour)\n", Hour));
			}
#endif /* AP_SCAN_SUPPORT */
		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef ED_MONITOR

#ifdef CONFIG_AP_SUPPORT
		/*For AP connected client's count */
		if (RTMPGetKeyParameter("EDCCA_AP_STA_TH", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->ed_sta_threshold = longtmp;
			DBGPRINT(RT_DEBUG_TRACE, ("pAd->ed_sta_threshold = %u\n",
				pAd->ed_sta_threshold));
		}

		/*For APs found in working channel */
		if (RTMPGetKeyParameter("EDCCA_AP_AP_TH", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->ed_ap_threshold = longtmp;
			DBGPRINT(RT_DEBUG_TRACE, ("pAd->ed_ap_threshold = %u\n",
				pAd->ed_ap_threshold));
		}

		/*For APs RSSI found in working channel */
		if (RTMPGetKeyParameter("EDCCA_AP_RSSI_TH", tmpbuf, 32, pBuffer, TRUE)) {
			INT ret = TRUE;

			ret = kstrtol(tmpbuf, 10, &longtmp);
			pAd->ed_rssi_threshold = longtmp;
			DBGPRINT(RT_DEBUG_TRACE, ("pAd->ed_rssi_threshold = %d\n",
				pAd->ed_rssi_threshold));
		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
		/*For STA site survey AP counts */
		if (RTMPGetKeyParameter("EDCCA_STA_SCANED_AP_TH", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->ed_ap_scanned = longtmp;
			DBGPRINT(RT_DEBUG_TRACE, ("pAd->ed_ap_scanned = %u\n",
				pAd->ed_ap_scanned));
		}

		/*For STA found APs in working channel */
		if (RTMPGetKeyParameter("EDCCA_STA_CURRENT_CH_APS_TH", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->ed_current_ch_aps = longtmp;
			DBGPRINT(RT_DEBUG_TRACE,
				("pAd->ed_current_ch_aps = %u\n", pAd->ed_current_ch_aps));
		}

		/*For STA RSSI threhold when linkup */
		if (RTMPGetKeyParameter("EDCCA_STA_RSSI_TH", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->ed_rssi_threshold = longtmp;
			DBGPRINT(RT_DEBUG_TRACE, ("pAd->ed_rssi_threshold = %d\n",
				pAd->ed_rssi_threshold));
		}
#endif /* CONFIG_STA_SUPPORT */

		/* common part for EDCCA config */
		if (RTMPGetKeyParameter("EDCCA_ED_TH", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->ed_threshold = longtmp;
			DBGPRINT(RT_DEBUG_TRACE, ("pAd->ed_threshold = %u\n",
				pAd->ed_threshold));
		}

		if (RTMPGetKeyParameter("EDCCA_FALSE_CCA_TH", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->false_cca_threshold = longtmp;
			DBGPRINT(RT_DEBUG_TRACE, ("pAd->false_cca_threshold = %u\n",
				 pAd->false_cca_threshold));
		}

		if (RTMPGetKeyParameter("EDCCA_BLOCK_CHECK_TH", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->ed_block_tx_threshold = longtmp;
			DBGPRINT(RT_DEBUG_TRACE, ("pAd->ed_block_tx_threshold = %u\n",
				pAd->ed_block_tx_threshold));
		}
#endif /* ED_MONITOR */

		/*ShortSlot */
		if (RTMPGetKeyParameter("ShortSlot", tmpbuf, 10, pBuffer, TRUE)) {
			RT_CfgSetShortSlot(pAd, tmpbuf);
			DBGPRINT(RT_DEBUG_TRACE,
				 ("ShortSlot=%d\n", pAd->CommonCfg.bUseShortSlotTime));
		}
#ifdef TXBF_SUPPORT
		if (pAd->chipCap.FlgHwTxBfCap) {
#if defined(CONFIG_AP_SUPPORT) || defined(STA_ITXBF_SUPPORT)
			/*ITxBfEn */
			if (RTMPGetKeyParameter("ITxBfEn", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
					pAd->CommonCfg.RegTransmitSetting.field.ITxBfEn
						= (longtmp != 0);
				DBGPRINT(RT_DEBUG_TRACE,
					 ("ITxBfEn = %d\n",
					  pAd->CommonCfg.RegTransmitSetting.field.ITxBfEn));

					rtmp_asic_set_bf(pAd);
			}

			/* ITxBfTimeout */
			if (RTMPGetKeyParameter("ITxBfTimeout", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				pAd->CommonCfg.ITxBfTimeout = longtmp;

				DBGPRINT(RT_DEBUG_TRACE,
					("ITxBfTimeout = %ld\n", pAd->CommonCfg.ITxBfTimeout));
			}
#endif /* defined(CONFIG_AP_SUPPORT) || defined(STA_ITXBF_SUPPORT) */

			/* ETxBfEnCond */
			if (RTMPGetKeyParameter("ETxBfEnCond", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				pAd->CommonCfg.ETxBfEnCond = longtmp;

				DBGPRINT(RT_DEBUG_TRACE,
					("ETxBfEnCond = %ld\n", pAd->CommonCfg.ETxBfEnCond));

				if (pAd->CommonCfg.ETxBfEnCond)
					pAd->CommonCfg.RegTransmitSetting.field.TxBF = TRUE;
				else
					pAd->CommonCfg.RegTransmitSetting.field.TxBF = FALSE;
				rtmp_asic_set_bf(pAd);
			}

			/* ETxBfTimeout */
			if (RTMPGetKeyParameter("ETxBfTimeout", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				pAd->CommonCfg.ETxBfTimeout = longtmp;

				DBGPRINT(RT_DEBUG_TRACE,
					("ETxBfTimeout = %ld\n", pAd->CommonCfg.ETxBfTimeout));
			}

			/* ETxBfNoncompress */
			if (RTMPGetKeyParameter("ETxBfNoncompress", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				pAd->CommonCfg.ETxBfNoncompress = longtmp;

				DBGPRINT(RT_DEBUG_TRACE,
					("ETxBfNoncompress = %d\n",
					pAd->CommonCfg.ETxBfNoncompress));
			}

			/* ETxBfIncapable */
			if (RTMPGetKeyParameter("ETxBfIncapable", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				pAd->CommonCfg.ETxBfIncapable = longtmp;

				DBGPRINT(RT_DEBUG_TRACE,
					("ETxBfIncapable = %d\n", pAd->CommonCfg.ETxBfIncapable));
			}
		}
#endif /* TXBF_SUPPORT */

#ifdef PRE_ANT_SWITCH
		/*PreAntSwitch */
		if (RTMPGetKeyParameter("PreAntSwitch", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			pAd->CommonCfg.PreAntSwitch = (longtmp != 0);

			DBGPRINT(RT_DEBUG_TRACE,
				("PreAntSwitch = %d\n", pAd->CommonCfg.PreAntSwitch));
		}
#endif /* PRE_ANT_SWITCH */

#ifdef STREAM_MODE_SUPPORT
		/* StreamMode */
		if (pAd->chipCap.FlgHwStreamMode) {
			if (RTMPGetKeyParameter("StreamMode", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				pAd->CommonCfg.StreamMode = (longtmp & 0x03);

				DBGPRINT(RT_DEBUG_TRACE,
					("StreamMode= %d\n", pAd->CommonCfg.StreamMode));
			}

			/* StreamModeMac */
			for (i = 0; i < STREAM_MODE_STA_NUM; i++) {
				STRING tok_str[32];

				sprintf(tok_str, "StreamModeMac%d", i);

				if (RTMPGetKeyParameter
				    (tok_str, tmpbuf, MAX_PARAM_BUFFER_SIZE, pBuffer, TRUE)) {
					int j;
					/*Mac address acceptable format
					01:02:03:04:05:06 length 17 */
					if (strlen(tmpbuf) != 17)
						continue;

					for (j = 0; j < MAC_ADDR_LEN; j++) {
						AtoH(tmpbuf, &pAd->CommonCfg.StreamModeMac[i][j],
						     1);
						tmpbuf = tmpbuf + 3;
					}
				}
			}

			if (NdisEqualMemory
			    (ZERO_MAC_ADDR, &pAd->CommonCfg.StreamModeMac[0][0], MAC_ADDR_LEN)) {
				/* set default broadcast mac to entry 0 if user not set it */
				NdisMoveMemory(&pAd->CommonCfg.StreamModeMac[0][0], BROADCAST_ADDR,
					       MAC_ADDR_LEN);
			}
		}
#endif /* STREAM_MODE_SUPPORT */

#ifdef DBG_CTRL_SUPPORT
		/*DebugFlags */
		if (RTMPGetKeyParameter("DebugFlags", tmpbuf, 32, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 16, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->CommonCfg.DebugFlags = longtmp;

			DBGPRINT(RT_DEBUG_TRACE,
				("DebugFlags = 0x%02lx\n", pAd->CommonCfg.DebugFlags));
		}
#endif /* DBG_CTRL_SUPPORT */

		/*IEEE80211H */
		if (RTMPGetKeyParameter("IEEE80211H", tmpbuf, 10, pBuffer, TRUE)) {
			for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				macptr = rstrtok(NULL, ";"), i++) {
				ret = os_strtol(macptr, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				if (longtmp != 0)	/*Enable */
					pAd->CommonCfg.bIEEE80211H = TRUE;
				else	/*Disable */
					pAd->CommonCfg.bIEEE80211H = FALSE;

				DBGPRINT(RT_DEBUG_TRACE,
					 ("IEEE80211H=%d\n", pAd->CommonCfg.bIEEE80211H));
			}
		}
#ifdef DFS_SUPPORT
		{
			/*CSPeriod */
			if (RTMPGetKeyParameter("CSPeriod", tmpbuf, 10, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				if (longtmp != 0) {
					ret = os_strtol(tmpbuf, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					pAd->Dot11_H.CSPeriod = longtmp;
				} else
					pAd->Dot11_H.CSPeriod = 0;

				DBGPRINT(RT_DEBUG_TRACE, ("CSPeriod=%d\n", pAd->Dot11_H.CSPeriod));
			}

		}
#endif /* DFS_SUPPORT */

		/*RDRegion */
		if (RTMPGetKeyParameter("RDRegion", tmpbuf, 128, pBuffer, TRUE)) {
			if ((strncmp(tmpbuf, "JAP_W53", 7) == 0)
			    || (strncmp(tmpbuf, "jap_w53", 7) == 0)) {
				pAd->CommonCfg.RDDurRegion = JAP_W53;
				/*pRadarDetect->DfsSessionTime = 15; */
			} else if ((strncmp(tmpbuf, "JAP_W56", 7) == 0)
				   || (strncmp(tmpbuf, "jap_w56", 7) == 0)) {
				pAd->CommonCfg.RDDurRegion = JAP_W56;
				/*pRadarDetect->DfsSessionTime = 13; */
			} else if ((strncmp(tmpbuf, "JAP", 3) == 0)
				   || (strncmp(tmpbuf, "jap", 3) == 0)) {
				pAd->CommonCfg.RDDurRegion = JAP;
				/*pRadarDetect->DfsSessionTime = 5; */
			} else if ((strncmp(tmpbuf, "FCC", 3) == 0)
				   || (strncmp(tmpbuf, "fcc", 3) == 0)) {
				pAd->CommonCfg.RDDurRegion = FCC;
				/*pRadarDetect->DfsSessionTime = 5; */
			} else if ((strncmp(tmpbuf, "CE", 2) == 0)
				   || (strncmp(tmpbuf, "ce", 2) == 0)) {
				pAd->CommonCfg.RDDurRegion = CE;
				/*pRadarDetect->DfsSessionTime = 13; */
			} else {
				pAd->CommonCfg.RDDurRegion = CE;
				/*pRadarDetect->DfsSessionTime = 13; */
			}

			DBGPRINT(RT_DEBUG_TRACE, ("RDRegion=%d\n", pAd->CommonCfg.RDDurRegion));
		} else {
			pAd->CommonCfg.RDDurRegion = CE;
			/*pRadarDetect->DfsSessionTime = 13; */
		}

#ifdef SYSTEM_LOG_SUPPORT
		/*WirelessEvent */
		if (RTMPGetKeyParameter("WirelessEvent", tmpbuf, 10, pBuffer, TRUE)) {
			BOOLEAN FlgIsWEntSup = FALSE;

			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			if (longtmp != 0)
				FlgIsWEntSup = TRUE;

			RtmpOsWlanEventSet(pAd, &pAd->CommonCfg.bWirelessEvent, FlgIsWEntSup);
			DBGPRINT(RT_DEBUG_TRACE,
				 ("WirelessEvent=%d\n", pAd->CommonCfg.bWirelessEvent));
		}
#endif /* SYSTEM_LOG_SUPPORT */

		/*AuthMode */
		if (RTMPGetKeyParameter("AuthMode", tmpbuf, 128, pBuffer, TRUE)) {
#ifdef CONFIG_AP_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";");
				     (macptr && i < pAd->ApCfg.BssidNum);
				     macptr = rstrtok(NULL, ";"), i++) {
					ApCfg_Set_AuthMode_Proc(pAd, i, macptr);
				}
			}
#endif /* CONFIG_AP_SUPPORT */
#ifdef CONFIG_STA_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
				struct wifi_dev *wdev = &pAd->StaCfg.wdev;

				if (rtstrcasecmp(tmpbuf, "WEPAUTO") == TRUE)
					wdev->AuthMode = Ndis802_11AuthModeAutoSwitch;
				else if (rtstrcasecmp(tmpbuf, "SHARED") == TRUE)
					wdev->AuthMode = Ndis802_11AuthModeShared;
				else if (rtstrcasecmp(tmpbuf, "WPAPSK") == TRUE)
					wdev->AuthMode = Ndis802_11AuthModeWPAPSK;
				else if (rtstrcasecmp(tmpbuf, "WPANONE") == TRUE)
					wdev->AuthMode = Ndis802_11AuthModeWPANone;
				else if (rtstrcasecmp(tmpbuf, "WPA2PSK") == TRUE)
					wdev->AuthMode = Ndis802_11AuthModeWPA2PSK;
#ifdef WPA_SUPPLICANT_SUPPORT
				else if (rtstrcasecmp(tmpbuf, "WPA") == TRUE)
					wdev->AuthMode = Ndis802_11AuthModeWPA;
				else if (rtstrcasecmp(tmpbuf, "WPA2") == TRUE)
					wdev->AuthMode = Ndis802_11AuthModeWPA2;
#endif /* WPA_SUPPLICANT_SUPPORT */
#ifdef WAPI_SUPPORT
				else if (rtstrcasecmp(tmpbuf, "WAICERT") == TRUE)
					wdev->AuthMode = Ndis802_11AuthModeWAICERT;
				else if (rtstrcasecmp(tmpbuf, "WAIPSK") == TRUE)
					wdev->AuthMode = Ndis802_11AuthModeWAIPSK;
#endif /* WAPI_SUPPORT */
				else
					wdev->AuthMode = Ndis802_11AuthModeOpen;

				wdev->PortSecured = WPA_802_1X_PORT_NOT_SECURED;

				DBGPRINT(RT_DEBUG_TRACE, ("%s::(AuthMode=%d)\n",
							  __func__, wdev->AuthMode));
			}
#endif /* CONFIG_STA_SUPPORT */
		}
		/*EncrypType */
		if (RTMPGetKeyParameter("EncrypType", tmpbuf, 128, pBuffer, TRUE)) {
#ifdef CONFIG_AP_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
				/*
				   We need to reset the WepStatus of all interfaces as 1 (Ndis802_11WEPDisabled) first.
				   Or it may have problem when some interface enabled but didn't configure it.
				 */
				for (i = 0; i < pAd->ApCfg.BssidNum; i++)
					pAd->ApCfg.MBSSID[i].wdev.WepStatus = Ndis802_11WEPDisabled;

				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					int apidx;
					struct wifi_dev *wdev;

					if (i < HW_BEACON_MAX_NUM)
						apidx = i;
					else
						break;

					wdev = &pAd->ApCfg.MBSSID[apidx].wdev;
					if ((strncmp(macptr, "NONE", 4) == 0)
					    || (strncmp(macptr, "none", 4) == 0))
						wdev->WepStatus = Ndis802_11WEPDisabled;
					else if ((strncmp(macptr, "WEP", 3) == 0)
						 || (strncmp(macptr, "wep", 3) == 0))
						wdev->WepStatus = Ndis802_11WEPEnabled;
					else if ((strncmp(macptr, "TKIPAES", 7) == 0)
						 || (strncmp(macptr, "tkipaes", 7) == 0))
						wdev->WepStatus = Ndis802_11TKIPAESMix;
					else if ((strncmp(macptr, "TKIP", 4) == 0)
						 || (strncmp(macptr, "tkip", 4) == 0))
						wdev->WepStatus = Ndis802_11TKIPEnable;
					else if ((strncmp(macptr, "AES", 3) == 0)
						 || (strncmp(macptr, "aes", 3) == 0))
						wdev->WepStatus = Ndis802_11AESEnable;
#ifdef WAPI_SUPPORT
					else if ((strncmp(macptr, "SMS4", 4) == 0)
						 || (strncmp(macptr, "sms4", 4) == 0))
						wdev->WepStatus = Ndis802_11EncryptionSMS4Enabled;
#endif /* WAPI_SUPPORT */
					else
						wdev->WepStatus = Ndis802_11WEPDisabled;

					/* decide the group key encryption type */
					if (wdev->WepStatus == Ndis802_11TKIPAESMix)
						wdev->GroupKeyWepStatus = Ndis802_11TKIPEnable;
					else
						wdev->GroupKeyWepStatus = wdev->WepStatus;

					/* move to ap.c::APStartUp to process */
					/*RTMPMakeRSNIE(pAd, pAd->ApCfg.MBSSID[apidx].AuthMode,
					wdev->WepStatus, apidx); */
					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) EncrypType=%d\n", i, wdev->WepStatus));
				}
			}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
				struct wifi_dev *wdev = &pAd->StaCfg.wdev;

				if (rtstrcasecmp(tmpbuf, "WEP") == TRUE)
					wdev->WepStatus = Ndis802_11WEPEnabled;
				else if (rtstrcasecmp(tmpbuf, "TKIP") == TRUE)
					wdev->WepStatus = Ndis802_11TKIPEnable;
				else if (rtstrcasecmp(tmpbuf, "AES") == TRUE)
					wdev->WepStatus = Ndis802_11AESEnable;
#ifdef WAPI_SUPPORT
				else if (rtstrcasecmp(tmpbuf, "SMS4") == TRUE)
					wdev->WepStatus = Ndis802_11EncryptionSMS4Enabled;
#endif /* WAPI_SUPPORT */
				else
					wdev->WepStatus = Ndis802_11WEPDisabled;
				RTMPSetSTACipherSuites(pAd, wdev->WepStatus);
				/*RTMPMakeRSNIE(pAd, wdev->AuthMode, wdev->WepStatus, 0); */
				DBGPRINT(RT_DEBUG_TRACE,
					 ("%s::(EncrypType=%d)\n", __func__, wdev->WepStatus));
			}
#endif /* CONFIG_STA_SUPPORT */
		}
#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
			/* WpaMixPairCipher */
			if (RTMPGetKeyParameter("WpaMixPairCipher", tmpbuf, 256, pBuffer, TRUE)) {
				/*
				   In WPA-WPA2 mix mode, it provides a more flexible cipher combination.
				   -    WPA-AES and WPA2-TKIP
				   -    WPA-AES and WPA2-TKIPAES
				   -    WPA-TKIP and WPA2-AES
				   -    WPA-TKIP and WPA2-TKIPAES
				   -    WPA-TKIPAES and WPA2-AES
				   -    WPA-TKIPAES and WPA2-TKIP
				   -    WPA-TKIPAES and WPA2-TKIPAES (default)
				 */
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					struct wifi_dev *wdev;

					/* TODO: shiang, check about the sequence of this paramter and BssNum!! */
					if (i >= HW_BEACON_MAX_NUM)
						break;

					wdev = &pAd->ApCfg.MBSSID[i].wdev;
					if (wdev->AuthMode != Ndis802_11AuthModeWPA1WPA2 &&
					    wdev->AuthMode != Ndis802_11AuthModeWPA1PSKWPA2PSK)
						continue;

					if (wdev->WepStatus != Ndis802_11TKIPAESMix)
						continue;

					if ((strncmp(macptr, "WPA_AES_WPA2_TKIPAES", 20) == 0)
					    || (strncmp(macptr, "wpa_aes_wpa2_tkipaes", 20) == 0))
						wdev->WpaMixPairCipher = WPA_AES_WPA2_TKIPAES;
					else if ((strncmp(macptr, "WPA_AES_WPA2_TKIP", 17) == 0)
						 || (strncmp(macptr, "wpa_aes_wpa2_tkip", 17) == 0))
						wdev->WpaMixPairCipher = WPA_AES_WPA2_TKIP;
					else if ((strncmp(macptr, "WPA_TKIP_WPA2_AES", 17) == 0)
						 || (strncmp(macptr, "wpa_tkip_wpa2_aes", 17) == 0))
						wdev->WpaMixPairCipher = WPA_TKIP_WPA2_AES;
					else if ((strncmp(macptr, "WPA_TKIP_WPA2_TKIPAES", 21) == 0)
						 || (strncmp(macptr, "wpa_tkip_wpa2_tkipaes", 21) ==
						     0))
						wdev->WpaMixPairCipher = WPA_TKIP_WPA2_TKIPAES;
					else if ((strncmp(macptr, "WPA_TKIPAES_WPA2_AES", 20) == 0)
						 || (strncmp(macptr, "wpa_tkipaes_wpa2_aes", 20) ==
						     0))
						wdev->WpaMixPairCipher = WPA_TKIPAES_WPA2_AES;
					else if ((strncmp(macptr, "WPA_TKIPAES_WPA2_TKIPAES", 24) ==
						  0)
						 || (strncmp(macptr, "wpa_tkipaes_wpa2_tkipaes", 24)
						     == 0))
						wdev->WpaMixPairCipher = WPA_TKIPAES_WPA2_TKIPAES;
					else if ((strncmp(macptr, "WPA_TKIPAES_WPA2_TKIP", 21) == 0)
						 || (strncmp(macptr, "wpa_tkipaes_wpa2_tkip", 21) ==
						     0))
						wdev->WpaMixPairCipher = WPA_TKIPAES_WPA2_TKIP;
					else	/*Default */
						wdev->WpaMixPairCipher = WPA_TKIPAES_WPA2_TKIPAES;

					DBGPRINT(RT_DEBUG_OFF,
						 ("I/F(ra%d) MixWPACipher=0x%02x\n", i,
						  wdev->WpaMixPairCipher));
				}
			}

			/*RekeyMethod */
			if (RTMPGetKeyParameter("RekeyMethod", tmpbuf, 128, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					PRT_WPA_REKEY pRekeyInfo = &pAd->ApCfg.MBSSID[i].WPAREKEY;

					if ((strcmp(macptr, "TIME") == 0)
					    || (strcmp(macptr, "time") == 0))
						pRekeyInfo->ReKeyMethod = TIME_REKEY;
					else if ((strcmp(macptr, "PKT") == 0)
						 || (strcmp(macptr, "pkt") == 0))
						pRekeyInfo->ReKeyMethod = PKT_REKEY;
					else if ((strcmp(macptr, "DISABLE") == 0)
						 || (strcmp(macptr, "disable") == 0))
						pRekeyInfo->ReKeyMethod = DISABLE_REKEY;
					else
						pRekeyInfo->ReKeyMethod = DISABLE_REKEY;

					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) ReKeyMethod=%ld\n", i,
						  pRekeyInfo->ReKeyMethod));
				}

				/* Apply to remaining MBSS */
				if (i == 1) {
					for (i = 1; i < pAd->ApCfg.BssidNum; i++) {
						pAd->ApCfg.MBSSID[i].WPAREKEY.ReKeyMethod =
						    pAd->ApCfg.MBSSID[0].WPAREKEY.ReKeyMethod;
						DBGPRINT(RT_DEBUG_TRACE,
							 ("I/F(ra%d) ReKeyMethod=%ld\n", i,
							  pAd->ApCfg.MBSSID[i].WPAREKEY.
							  ReKeyMethod));
					}
				}
			}
			/*RekeyInterval */
			if (RTMPGetKeyParameter("RekeyInterval", tmpbuf, 255, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					ULONG value_interval;
					PRT_WPA_REKEY pRekeyInfo = &pAd->ApCfg.MBSSID[i].WPAREKEY;

					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					value_interval = longtmp;

					if ((value_interval >= 10)
					    && (value_interval < MAX_REKEY_INTER))
						pRekeyInfo->ReKeyInterval = value_interval;
					else	/*Default */
						pRekeyInfo->ReKeyInterval = 3600;

					DBGPRINT(RT_DEBUG_TRACE, ("I/F(ra%d) ReKeyInterval=%ld\n",
								  i, pRekeyInfo->ReKeyInterval));
				}

				/* Apply to remaining MBSS */
				if (i == 1) {
					for (i = 1; i < pAd->ApCfg.BssidNum; i++) {
						pAd->ApCfg.MBSSID[i].WPAREKEY.ReKeyInterval =
						    pAd->ApCfg.MBSSID[0].WPAREKEY.ReKeyInterval;
						DBGPRINT(RT_DEBUG_TRACE,
							 ("I/F(ra%d) ReKeyInterval=%ld\n", i,
							  pAd->ApCfg.MBSSID[i].WPAREKEY.
							  ReKeyInterval));
					}
				}

			}
			/*PMKCachePeriod */
			if (RTMPGetKeyParameter("PMKCachePeriod", tmpbuf, 255, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
					macptr = rstrtok(NULL, ";"), i++) {
					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					pAd->ApCfg.MBSSID[i].PMKCachePeriod = longtmp * 60 * OS_HZ;

					DBGPRINT(RT_DEBUG_TRACE, ("I/F(ra%d) PMKCachePeriod=%ld\n",
								  i,
								  pAd->ApCfg.MBSSID[i].
								  PMKCachePeriod));
				}

				/* Apply to remaining MBSS */
				if (i == 1) {
					for (i = 1; i < pAd->ApCfg.BssidNum; i++) {
						pAd->ApCfg.MBSSID[i].PMKCachePeriod =
						    pAd->ApCfg.MBSSID[0].PMKCachePeriod;

						DBGPRINT(RT_DEBUG_TRACE,
							 ("I/F(ra%d) PMKCachePeriod=%ld\n", i,
							  pAd->ApCfg.MBSSID[i].PMKCachePeriod));
					}
				}
			}

			/*WPAPSK_KEY */
			if (TRUE) {
				STRING tok_str[16];
				BOOLEAN bWPAPSKxIsUsed = FALSE;

				/* DBGPRINT(RT_DEBUG_TRACE, ("pAd->ApCfg.BssidNum=%d\n", pAd->ApCfg.BssidNum)); */
				for (i = 0; i < pAd->ApCfg.BssidNum; i++) {
					snprintf(tok_str, sizeof(tok_str), "WPAPSK%d", i + 1);
					if (RTMPGetKeyParameter
					    (tok_str, tmpbuf, 65, pBuffer, FALSE)) {
						rtmp_parse_wpapsk_buffer_from_file(pAd, tmpbuf, i);

						if (bWPAPSKxIsUsed == FALSE)
							bWPAPSKxIsUsed = TRUE;
					}
				}
				if (bWPAPSKxIsUsed == FALSE) {
					if (RTMPGetKeyParameter
					    ("WPAPSK", tmpbuf, 512, pBuffer, FALSE)) {
						if (pAd->ApCfg.BssidNum == 1) {
							rtmp_parse_wpapsk_buffer_from_file(pAd,
											   tmpbuf,
											   BSS0);
						} else {
							/* Anyway, we still do the legacy
							dissection of the whole WPAPSK
							passphrase. */
							for (i = 0, macptr = rstrtok(tmpbuf, ";");
							     macptr;
							     macptr = rstrtok(NULL, ";"), i++) {
								rtmp_parse_wpapsk_buffer_from_file
								    (pAd, macptr, i);
							}

						}
					}
				}
#ifdef DBG
				for (i = 0; i < pAd->ApCfg.BssidNum; i++) {
					int j;

					DBGPRINT(RT_DEBUG_TRACE, ("I/F(ra%d) WPAPSK Key =>\n", i));
					for (j = 0; j < 32; j++) {
						DBGPRINT(RT_DEBUG_TRACE,
							 ("%02x:", pAd->ApCfg.MBSSID[i].PMK[j]));
						if ((j % 16) == 15)
							DBGPRINT(RT_DEBUG_TRACE, ("\n"));
					}
					DBGPRINT(RT_DEBUG_TRACE, ("\n"));
				}
#endif /* endif */
			}
		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
			if (RTMPGetKeyParameter("WPAPSK", tmpbuf, 512, pBuffer, FALSE))
				RTMPSetSTAPassPhrase(pAd, tmpbuf);
		}
#endif /* CONFIG_STA_SUPPORT */

		/*DefaultKeyID, KeyType, KeyStr */
		rtmp_read_key_parms_from_file(pAd, tmpbuf, pBuffer);

#ifdef WAPI_SUPPORT
		rtmp_read_wapi_parms_from_file(pAd, tmpbuf, pBuffer);
#endif /* WAPI_SUPPORT */

#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
			/*Access Control List */
			rtmp_read_acl_parms_from_file(pAd, tmpbuf, pBuffer);

#ifdef APCLI_SUPPORT
			rtmp_read_ap_client_from_file(pAd, tmpbuf, pBuffer);
#endif /* APCLI_SUPPORT */

#ifdef IGMP_SNOOP_SUPPORT
			/* Igmp Snooping information */
			rtmp_read_igmp_snoop_from_file(pAd, tmpbuf, pBuffer);
#endif /* IGMP_SNOOP_SUPPORT */

#ifdef WDS_SUPPORT
			rtmp_read_wds_from_file(pAd, tmpbuf, pBuffer);
#endif /* WDS_SUPPORT */

#ifdef DOT1X_SUPPORT
			rtmp_read_radius_parms_from_file(pAd, tmpbuf, pBuffer);
#endif /* DOT1X_SUPPORT */

#ifdef IDS_SUPPORT
			rtmp_read_ids_from_file(pAd, tmpbuf, pBuffer);
#endif /* IDS_SUPPORT */

#ifdef MAC_REPEATER_SUPPORT
			if (RTMPGetKeyParameter("MACRepeaterEn", tmpbuf, 10, pBuffer, FALSE)) {
				UINT32 MacReg = 0;

				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				if (longtmp != 0) {	/*Enable */
					pAd->ApCfg.bMACRepeaterEn = TRUE;
					RTMP_IO_READ32(pAd, MAC_ADDR_EXT_EN, &MacReg);
					MacReg |= 1;
					RTMP_IO_WRITE32(pAd, MAC_ADDR_EXT_EN, MacReg);
				} else {	/*Disable */

					pAd->ApCfg.bMACRepeaterEn = FALSE;
					RTMP_IO_READ32(pAd, MAC_ADDR_EXT_EN, &MacReg);
					MacReg &= ~(1);
					RTMP_IO_WRITE32(pAd, MAC_ADDR_EXT_EN, MacReg);
				}
				DBGPRINT(RT_DEBUG_TRACE,
					 ("MACRepeaterEn=%d\n", pAd->ApCfg.bMACRepeaterEn));
			}

			if (RTMPGetKeyParameter("MACRepeaterOuiMode", tmpbuf, 10, pBuffer, FALSE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				INT OuiMode = longtmp;

				if (OuiMode == 1)
					pAd->ApCfg.MACRepeaterOuiMode = 1;
				else if (OuiMode == 2)
					pAd->ApCfg.MACRepeaterOuiMode = 2;	/* customer specific */
				else
					/* use Ap-Client first 3 bytes MAC assress (default) */
					pAd->ApCfg.MACRepeaterOuiMode = 0;

				DBGPRINT(RT_DEBUG_TRACE,
					 ("MACRepeaterOuiMode=%d\n",
					  pAd->ApCfg.MACRepeaterOuiMode));

			}
#endif /* MAC_REPEATER_SUPPORT */
		}

#endif /* CONFIG_AP_SUPPORT */

		HTParametersHook(pAd, tmpbuf, pBuffer);

#ifdef DOT11_VHT_AC
		VHTParametersHook(pAd, tmpbuf, pBuffer);
#endif /* DOT11_VHT_AC */

#ifdef CONFIG_FPGA_MODE
#ifdef CAPTURE_MODE
		if (RTMPGetKeyParameter("cap_support", tmpbuf, 25, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			ULONG cap_support = longtmp;

			pAd->cap_support = cap_support > 0 ? TRUE : FALSE;
			DBGPRINT(RT_DEBUG_OFF, ("%s(): CaptureMode=%d\n",
						__func__, pAd->cap_support));
		}
#endif /* CAPTURE_MODE */
#endif /* CONFIG_FPGA_MODE */

#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
#ifdef WSC_AP_SUPPORT
			STRING tok_str[16] = { 0 };

			for (i = 0; i < pAd->ApCfg.BssidNum; i++) {
				snprintf(tok_str, sizeof(tok_str), "WscDefaultSSID%d", i + 1);
				if (RTMPGetKeyParameter(tok_str, tmpbuf, 33, pBuffer, FALSE)) {
					NdisZeroMemory(&pAd->ApCfg.MBSSID[i].WscControl.
						       WscDefaultSsid, sizeof(NDIS_802_11_SSID));
					NdisMoveMemory(pAd->ApCfg.MBSSID[i].WscControl.
						       WscDefaultSsid.Ssid, tmpbuf, strlen(tmpbuf));
					pAd->ApCfg.MBSSID[i].WscControl.WscDefaultSsid.SsidLength =
					    strlen(tmpbuf);
					DBGPRINT(RT_DEBUG_TRACE,
						 ("WscDefaultSSID[%d]=%s\n", i,
						  pAd->ApCfg.MBSSID[i].WscControl.WscDefaultSsid.
						  Ssid));
				}
			}

			/*WscConfMode */
			if (RTMPGetKeyParameter("WscConfMode", tmpbuf, 10, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
					macptr = rstrtok(NULL, ";"), i++) {
					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					INT WscConfMode = longtmp;

					if (i >= pAd->ApCfg.BssidNum)
						break;

					if (WscConfMode > 0 && WscConfMode < 8)
						pAd->ApCfg.MBSSID[i].WscControl.WscConfMode =
						    WscConfMode;
					else
						pAd->ApCfg.MBSSID[i].WscControl.WscConfMode =
						    WSC_DISABLE;

					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) WscConfMode=%d\n", i,
						  pAd->ApCfg.MBSSID[i].WscControl.WscConfMode));
				}
			}

			/*WscConfStatus */
			if (RTMPGetKeyParameter("WscConfStatus", tmpbuf, 10, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					if (i >= pAd->ApCfg.BssidNum)
						break;

					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					pAd->ApCfg.MBSSID[i].WscControl.WscConfStatus =
					    (INT) longtmp;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) WscConfStatus=%d\n", i,
						  pAd->ApCfg.MBSSID[i].WscControl.WscConfStatus));
				}
			}
			/*WscConfMethods */
			if (RTMPGetKeyParameter("WscConfMethods", tmpbuf, 32, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					if (i >= pAd->ApCfg.BssidNum)
						break;

					ret = os_strtol(macptr, 16, &longtmp);
					if (ret < 0)
						return FALSE;

					pAd->ApCfg.MBSSID[i].WscControl.WscConfigMethods =
					    (USHORT) longtmp;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) WscConfMethods=0x%x\n", i,
						  pAd->ApCfg.MBSSID[i].WscControl.
						  WscConfigMethods));
				}
			}

			/*WscKeyASCII (0:Hex, 1:ASCII(random length), others: ASCII length, default 8) */
			if (RTMPGetKeyParameter("WscKeyASCII", tmpbuf, 10, pBuffer, TRUE)) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					INT Value;

					if (i >= pAd->ApCfg.BssidNum)
						break;

					ret = os_strtol(tmpbuf, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					Value = (INT) longtmp;
					if (Value == 0 || Value == 1)
						pAd->ApCfg.MBSSID[i].WscControl.WscKeyASCII = Value;
					else if (Value >= 8 && Value <= 63)
						pAd->ApCfg.MBSSID[i].WscControl.WscKeyASCII = Value;
					else
						pAd->ApCfg.MBSSID[i].WscControl.WscKeyASCII = 8;
					DBGPRINT(RT_DEBUG_WARN,
						 ("WscKeyASCII=%d\n",
						  pAd->ApCfg.MBSSID[i].WscControl.WscKeyASCII));
				}
			}

			if (RTMPGetKeyParameter("WscSecurityMode", tmpbuf, 50, pBuffer, TRUE)) {
				for (i = 0; i < pAd->ApCfg.BssidNum; i++)
					pAd->ApCfg.MBSSID[i].WscSecurityMode = WPAPSKTKIP;

				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					INT tmpMode = 0;

					if (i >= pAd->ApCfg.BssidNum)
						break;

					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					tmpMode = (INT) longtmp;
					if (tmpMode <= WPAPSKTKIP)
						pAd->ApCfg.MBSSID[i].WscSecurityMode = tmpMode;
					DBGPRINT(RT_DEBUG_TRACE,
						 ("RTMPSetProfileParameters I/F(ra%d) WscSecurityMode=%d\n",
						  i, pAd->ApCfg.MBSSID[i].WscSecurityMode));
				}
			}

			/* WCNTest */
			if (RTMPGetKeyParameter("WCNTest", tmpbuf, 10, pBuffer, TRUE)) {
				BOOLEAN bEn = FALSE;

				if ((strncmp(tmpbuf, "0", 1) == 0))
					bEn = FALSE;
				else
					bEn = TRUE;

				for (i = 0; i < pAd->ApCfg.BssidNum; i++)
					pAd->ApCfg.MBSSID[i].WscControl.bWCNTest = bEn;
				DBGPRINT(RT_DEBUG_TRACE, ("WCNTest=%d\n", bEn));
			}

			/*WSC UUID Str */
			for (i = 0; i < pAd->ApCfg.BssidNum; i++) {
				PWSC_CTRL pWpsCtrl = &pAd->ApCfg.MBSSID[i].WscControl;

				snprintf(tok_str, sizeof(tok_str), "WSC_UUID_Str%d", i + 1);
				if (RTMPGetKeyParameter(tok_str, tmpbuf, 40, pBuffer, FALSE)) {
					NdisMoveMemory(&pWpsCtrl->Wsc_Uuid_Str[0], tmpbuf,
						       strlen(tmpbuf));
					DBGPRINT(RT_DEBUG_TRACE,
						 ("UUID_Str[%d]=%s\n", i + 1,
						  pWpsCtrl->Wsc_Uuid_Str));
				}
			}

			/*WSC UUID Hex */
			for (i = 0; i < pAd->ApCfg.BssidNum; i++) {
				PWSC_CTRL pWpsCtrl = &pAd->ApCfg.MBSSID[i].WscControl;

				snprintf(tok_str, sizeof(tok_str), "WSC_UUID_E%d", i + 1);
				if (RTMPGetKeyParameter(tok_str, tmpbuf, 40, pBuffer, FALSE)) {
					AtoH(tmpbuf, &pWpsCtrl->Wsc_Uuid_E[0], UUID_LEN_HEX);
					DBGPRINT(RT_DEBUG_TRACE, ("Wsc_Uuid_E[%d]", i + 1));
					hex_dump("", &pWpsCtrl->Wsc_Uuid_E[0], UUID_LEN_HEX);
				}
			}

#endif /* WSC_AP_SUPPORT */

		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef CARRIER_DETECTION_SUPPORT
		/*CarrierDetect */
		if (RTMPGetKeyParameter("CarrierDetect", tmpbuf, 128, pBuffer, TRUE)) {
			if ((strncmp(tmpbuf, "0", 1) == 0))
				pAd->CommonCfg.CarrierDetect.Enable = FALSE;
			else if ((strncmp(tmpbuf, "1", 1) == 0))
				pAd->CommonCfg.CarrierDetect.Enable = TRUE;
			else
				pAd->CommonCfg.CarrierDetect.Enable = FALSE;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("CarrierDetect.Enable=%d\n",
				  pAd->CommonCfg.CarrierDetect.Enable));
		} else
			pAd->CommonCfg.CarrierDetect.Enable = FALSE;
#endif /* CARRIER_DETECTION_SUPPORT */

#ifdef CONFIG_STA_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
			/*PSMode */
			if (RTMPGetKeyParameter("PSMode", tmpbuf, 10, pBuffer, TRUE)) {
				if (pAd->StaCfg.BssType == BSS_INFRA) {
					if ((strcmp(tmpbuf, "MAX_PSP") == 0)
					    || (strcmp(tmpbuf, "max_psp") == 0)) {
						/*
						   do NOT turn on PSM bit here, wait until MlmeCheckForPsmChange()
						   to exclude certain situations
						 */
						/*      MlmeSetPsm(pAd, PWR_SAVE); */
						OPSTATUS_SET_FLAG(pAd, fOP_STATUS_RECEIVE_DTIM);
						if (pAd->StaCfg.bWindowsACCAMEnable == FALSE)
							pAd->StaCfg.WindowsPowerMode =
							    Ndis802_11PowerModeMAX_PSP;
						pAd->StaCfg.WindowsBatteryPowerMode =
						    Ndis802_11PowerModeMAX_PSP;
						pAd->StaCfg.DefaultListenCount = 5;
					} else if ((strcmp(tmpbuf, "Fast_PSP") == 0)
						   || (strcmp(tmpbuf, "fast_psp") == 0)
						   || (strcmp(tmpbuf, "FAST_PSP") == 0)) {
						/* do NOT turn on PSM bit here, wait until MlmeCheckForPsmChange() */
						/* to exclude certain situations. */
						OPSTATUS_SET_FLAG(pAd, fOP_STATUS_RECEIVE_DTIM);
						if (pAd->StaCfg.bWindowsACCAMEnable == FALSE)
							pAd->StaCfg.WindowsPowerMode =
							    Ndis802_11PowerModeFast_PSP;
						pAd->StaCfg.WindowsBatteryPowerMode =
						    Ndis802_11PowerModeFast_PSP;
						pAd->StaCfg.DefaultListenCount = 3;
					} else if ((strcmp(tmpbuf, "Legacy_PSP") == 0)
						   || (strcmp(tmpbuf, "legacy_psp") == 0)
						   || (strcmp(tmpbuf, "LEGACY_PSP") == 0)) {
						/* do NOT turn on PSM bit here, wait until MlmeCheckForPsmChange() */
						/* to exclude certain situations. */
						OPSTATUS_SET_FLAG(pAd, fOP_STATUS_RECEIVE_DTIM);
						if (pAd->StaCfg.bWindowsACCAMEnable == FALSE)
							pAd->StaCfg.WindowsPowerMode =
							    Ndis802_11PowerModeLegacy_PSP;
						pAd->StaCfg.WindowsBatteryPowerMode =
						    Ndis802_11PowerModeLegacy_PSP;
						pAd->StaCfg.DefaultListenCount = 3;
#if defined(DOT11Z_TDLS_SUPPORT) || defined(CFG_TDLS_SUPPORT)
						pAd->StaCfg.DefaultListenCount = 1;
#endif /* defined(DOT11Z_TDLS_SUPPORT) || defined(CFG_TDLS_SUPPORT) */
					} else {	/*Default Ndis802_11PowerModeCAM */
						/* clear PSM bit immediately */
						RTMP_SET_PSM_BIT(pAd, PWR_ACTIVE);
						OPSTATUS_SET_FLAG(pAd, fOP_STATUS_RECEIVE_DTIM);
						if (pAd->StaCfg.bWindowsACCAMEnable == FALSE)
							pAd->StaCfg.WindowsPowerMode =
							    Ndis802_11PowerModeCAM;
						pAd->StaCfg.WindowsBatteryPowerMode =
						    Ndis802_11PowerModeCAM;
					}
					DBGPRINT(RT_DEBUG_TRACE,
						 ("PSMode=%ld\n", pAd->StaCfg.WindowsPowerMode));
				}
			}
			/* AutoRoaming by RSSI */
			if (RTMPGetKeyParameter("AutoRoaming", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				if (longtmp == 0)
					pAd->StaCfg.bAutoRoaming = FALSE;
				else
					pAd->StaCfg.bAutoRoaming = TRUE;

				DBGPRINT(RT_DEBUG_TRACE,
					 ("AutoRoaming=%d\n", pAd->StaCfg.bAutoRoaming));
			}
			/* RoamThreshold */
			if (RTMPGetKeyParameter("RoamThreshold", tmpbuf, 32, pBuffer, TRUE)) {
				long lInfo;

				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				lInfo = longtmp;

				if (lInfo > 90 || lInfo < 60)
					pAd->StaCfg.dBmToRoam = -70;
				else
					pAd->StaCfg.dBmToRoam = (CHAR) (-1) * lInfo;

				DBGPRINT(RT_DEBUG_TRACE,
					 ("RoamThreshold=%d  dBm\n", pAd->StaCfg.dBmToRoam));
			}

			if (RTMPGetKeyParameter("TGnWifiTest", tmpbuf, 10, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				if (longtmp == 0)
					pAd->StaCfg.bTGnWifiTest = FALSE;
				else
					pAd->StaCfg.bTGnWifiTest = TRUE;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("TGnWifiTest=%d\n", pAd->StaCfg.bTGnWifiTest));
			}

			/* Beacon Lost Time */
			if (RTMPGetKeyParameter("BeaconLostTime", tmpbuf, 32, pBuffer, TRUE)) {
				ULONG lInfo;

				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				lInfo = (ULONG) longtmp;

				if ((lInfo != 0) && (lInfo <= 60))
					pAd->StaCfg.BeaconLostTime = (lInfo * OS_HZ);
				DBGPRINT(RT_DEBUG_TRACE,
					 ("BeaconLostTime=%ld\n", pAd->StaCfg.BeaconLostTime));
			}

			/* Auto Connet Setting if no SSID                       */
			if (RTMPGetKeyParameter("AutoConnect", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				if (longtmp == 0)
					pAd->StaCfg.bAutoConnectIfNoSSID = FALSE;
				else
					pAd->StaCfg.bAutoConnectIfNoSSID = TRUE;
			}
#ifdef DOT11Z_TDLS_SUPPORT
			if (RTMPGetKeyParameter("TDLSCapable", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				if (longtmp != 0) {	/*Enable */
					pAd->StaCfg.TdlsInfo.bTDLSCapable = TRUE;
				} else {	/*Disable */

					pAd->StaCfg.TdlsInfo.bTDLSCapable = FALSE;
				}

				DBGPRINT(RT_DEBUG_TRACE,
					 ("bTDLSCapable=%d\n", pAd->StaCfg.TdlsInfo.bTDLSCapable));
			}
#ifdef TDLS_AUTOLINK_SUPPORT
			if (RTMPGetKeyParameter("TDLS_AutoLink", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				if (longtmp != 0)	/* Enable */
					pAd->StaCfg.TdlsInfo.TdlsAutoLink = TRUE;
				else	/* Disable */
					pAd->StaCfg.TdlsInfo.TdlsAutoLink = FALSE;

				DBGPRINT(RT_DEBUG_TRACE,
					 ("TdlsAutoLink=%d\n", pAd->StaCfg.TdlsInfo.TdlsAutoLink));
			}
#endif /* TDLS_AUTOLINK_SUPPORT */

			if (RTMPGetKeyParameter("TDLS_SwitchChSupp", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				if (longtmp != 0) {	/* Enable */
					pAd->StaCfg.TdlsInfo.TdlsChSwitchSupp = TRUE;
				} else {	/* Disable */

					pAd->StaCfg.TdlsInfo.TdlsChSwitchSupp = FALSE;
				}

				DBGPRINT(RT_DEBUG_TRACE,
					 ("TdlsSwitchChSupp=%d\n",
					  pAd->StaCfg.TdlsInfo.TdlsChSwitchSupp));
			}

			if (RTMPGetKeyParameter("TDLS_PsmSupp", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				if (longtmp != 0) {	/* Enable */
					pAd->StaCfg.TdlsInfo.TdlsPsmSupp = TRUE;
				} else {	/* Disable */

					pAd->StaCfg.TdlsInfo.TdlsPsmSupp = FALSE;
				}

				DBGPRINT(RT_DEBUG_TRACE,
					 ("TdlsPsmSupp=%d\n", pAd->StaCfg.TdlsInfo.TdlsPsmSupp));
			}
			/* APSDAC for AC_BE, AC_BK, AC_VI, AC_VO */
			if (RTMPGetKeyParameter("TDLS_APSDAC", tmpbuf, 32, pBuffer, TRUE)) {
				BOOLEAN FlgIsAcUapsdEnabled[4];

				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
					macptr = rstrtok(NULL, ";"), i++) {
					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					FlgIsAcUapsdEnabled[i] = (BOOLEAN) longtmp;

					DBGPRINT(RT_DEBUG_TRACE,
						("TDLS APSDAC%d  %d\n", i,
						FlgIsAcUapsdEnabled[i]));
				}

				pAd->CommonCfg.TDLS_bAPSDAC_BE = FlgIsAcUapsdEnabled[0];
				pAd->CommonCfg.TDLS_bAPSDAC_BK = FlgIsAcUapsdEnabled[1];
				pAd->CommonCfg.TDLS_bAPSDAC_VI = FlgIsAcUapsdEnabled[2];
				pAd->CommonCfg.TDLS_bAPSDAC_VO = FlgIsAcUapsdEnabled[3];
			}
			/* MaxSPLength */
			if (RTMPGetKeyParameter("TDLS_MaxSPLength", tmpbuf, 10, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				pAd->CommonCfg.TDLS_MaxSPLength = longtmp;

				DBGPRINT(RT_DEBUG_TRACE,
					("TDLS MaxSPLength=%d\n",
					pAd->CommonCfg.TDLS_MaxSPLength));
			}
#endif /* DOT11Z_TDLS_SUPPORT */

			/* FastConnect */
			if (RTMPGetKeyParameter("FastConnect", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				if (longtmp == 0)
					pAd->StaCfg.bFastConnect = FALSE;
				else
					pAd->StaCfg.bFastConnect = TRUE;

				DBGPRINT(RT_DEBUG_TRACE,
					 ("FastConnect=%d\n", pAd->StaCfg.bFastConnect));
			}
		}
#endif /* CONFIG_STA_SUPPORT */
#ifdef CONFIG_AP_SUPPORT
		IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
#ifdef MCAST_RATE_SPECIFIC
			/* McastPhyMode */
			if (RTMPGetKeyParameter("McastPhyMode", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				UCHAR PhyMode = longtmp;
				/* pAd->CommonCfg.MCastPhyMode.field.BW = pAd->CommonCfg.RegTransmitSetting.field.BW; */
				switch (PhyMode) {
				case MCAST_DISABLE:	/* disable */
					NdisMoveMemory(&pAd->CommonCfg.MCastPhyMode,
						       &pAd->MacTab.Content[MCAST_WCID].HTPhyMode,
						       sizeof(HTTRANSMIT_SETTING));
					break;

				case MCAST_CCK:	/* CCK */
					pAd->CommonCfg.MCastPhyMode.field.MODE = MODE_CCK;
					pAd->CommonCfg.MCastPhyMode.field.BW = BW_20;
					break;

				case MCAST_OFDM:	/* OFDM */
					pAd->CommonCfg.MCastPhyMode.field.MODE = MODE_OFDM;
					pAd->CommonCfg.MCastPhyMode.field.BW = BW_20;
					break;
				case MCAST_HTMIX:	/* HTMIX */
					pAd->CommonCfg.MCastPhyMode.field.MODE = MODE_HTMIX;
					break;
#ifdef DOT11_VHT_AC
				case MCAST_VHT:	/* VHT */
					pAd->CommonCfg.MCastPhyMode.field.MODE = MODE_VHT;
					break;
#endif /* DOT11_VHT_AC */

				default:
					DBGPRINT(RT_DEBUG_OFF,
						 ("Unknown Muticast PhyMode %d\n", PhyMode));
					DBGPRINT(RT_DEBUG_OFF,
						 ("0:Disable 1:CCK, 2:OFDM, 3:HTMIX, 4:VHT\n"));
					break;
				}
			} else
				NdisMoveMemory(&pAd->CommonCfg.MCastPhyMode,
					       &pAd->MacTab.Content[MCAST_WCID].HTPhyMode,
					       sizeof(HTTRANSMIT_SETTING));

			/* McastMcs */
			if (RTMPGetKeyParameter("McastMcs", tmpbuf, 32, pBuffer, TRUE)) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;
				UCHAR Mcs = longtmp;

				switch (pAd->CommonCfg.MCastPhyMode.field.MODE) {
				case MODE_CCK:
					if ((Mcs <= 3) || (Mcs >= 8 && Mcs <= 11))
						pAd->CommonCfg.MCastPhyMode.field.MCS = Mcs;
					else
						DBGPRINT(RT_DEBUG_OFF,
							 ("MCS must in range of 0 ~ 3 and 8 ~ 11 for CCK Mode.\n"));
					break;

				case MODE_OFDM:
					if (Mcs > 7)
						DBGPRINT(RT_DEBUG_OFF,
							 ("MCS must in range from 0 to 7 for OFDM Mode.\n"));
					else
						pAd->CommonCfg.MCastPhyMode.field.MCS = Mcs;
					break;

				default:
					pAd->CommonCfg.MCastPhyMode.field.MCS = Mcs;
					break;
				}
			} else
				pAd->CommonCfg.MCastPhyMode.field.MCS = 0;
#endif /* MCAST_RATE_SPECIFIC */
		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef WSC_INCLUDED

		rtmp_read_wsc_user_parms_from_file(pAd, tmpbuf, pBuffer);

		/* Wsc4digitPinCode = TRUE use 4-digit Pin code, otherwise 8-digit Pin code */
		if (RTMPGetKeyParameter("Wsc4digitPinCode", tmpbuf, 32, pBuffer, TRUE)) {
#ifdef CONFIG_AP_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					if (i >= pAd->ApCfg.BssidNum)
						break;

					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					if (longtmp != 0)	/* Enable */
						pAd->ApCfg.MBSSID[i].WscControl.
							WscEnrollee4digitPinCode = TRUE;
					else	/* Disable */
						pAd->ApCfg.MBSSID[i].WscControl.
						    WscEnrollee4digitPinCode = FALSE;

					DBGPRINT(RT_DEBUG_TRACE,
						 ("I/F(ra%d) Wsc4digitPinCode=%d\n", i,
						  pAd->ApCfg.MBSSID[i].WscControl.
						  WscEnrollee4digitPinCode));
				}

			}
#endif /* CONFIG_AP_SUPPORT // */
#ifdef CONFIG_STA_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				if (longtmp != 0)	/* Enable */
					pAd->StaCfg.WscControl.WscEnrollee4digitPinCode = TRUE;
				else	/* Disable */
					pAd->StaCfg.WscControl.WscEnrollee4digitPinCode = FALSE;

				DBGPRINT(RT_DEBUG_TRACE,
					 ("Wsc4digitPinCode=%d\n",
					  pAd->StaCfg.WscControl.WscEnrollee4digitPinCode));
			}
#endif /* CONFIG_STA_SUPPORT // */
		}

		if (RTMPGetKeyParameter("WscVendorPinCode", tmpbuf, 256, pBuffer, TRUE)) {
			PWSC_CTRL pWscContrl;
			int bSetOk;
#ifdef CONFIG_AP_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
				pWscContrl = &pAd->ApCfg.MBSSID[BSS0].WscControl;
			}
#endif /* CONFIG_AP_SUPPORT */
#ifdef CONFIG_STA_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
				pWscContrl = &pAd->StaCfg.WscControl;
			}
#endif /* CONFIG_STA_SUPPORT */
			bSetOk = RT_CfgSetWscPinCode(pAd, tmpbuf, pWscContrl);
			if (bSetOk)
				DBGPRINT(RT_DEBUG_TRACE,
					 ("%s - WscVendorPinCode= (%d)\n", __func__, bSetOk));
			else
				DBGPRINT(RT_DEBUG_ERROR,
					 ("%s - WscVendorPinCode: invalid pin code(%s)\n",
					  __func__, tmpbuf));
		}
#ifdef WSC_V2_SUPPORT
		if (RTMPGetKeyParameter("WscV2Support", tmpbuf, 32, pBuffer, TRUE)) {
			UCHAR bEnable;
#ifdef CONFIG_AP_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_AP(pAd) {
				for (i = 0, macptr = rstrtok(tmpbuf, ";"); macptr;
				     macptr = rstrtok(NULL, ";"), i++) {
					if (i >= pAd->ApCfg.BssidNum)
						break;
					ret = os_strtol(macptr, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					bEnable = (UCHAR) longtmp;

					pAd->ApCfg.MBSSID[i].WscControl.WscV2Info.bEnableWpsV2 =
						bEnable;
					DBGPRINT(RT_DEBUG_TRACE,
						("I/F(ra%d) WscV2Support=%d\n", i, bEnable));
				}
			}
#endif /* CONFIG_AP_SUPPORT */
#ifdef CONFIG_STA_SUPPORT
			IF_DEV_CONFIG_OPMODE_ON_STA(pAd) {
				ret = os_strtol(tmpbuf, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				bEnable = (UCHAR) longtmp;

				pAd->StaCfg.WscControl.WscV2Info.bEnableWpsV2 = bEnable;
				DBGPRINT(RT_DEBUG_TRACE,
					 ("%s - WscV2Support= (%d)\n", __func__, bEnable));
			}
#endif /* CONFIG_STA_SUPPORT */
		}
#endif /* WSC_V2_SUPPORT */

#endif /* WSC_INCLUDED */

#ifdef CONFIG_AP_SUPPORT
#endif /* CONFIG_AP_SUPPORT */

#ifdef DOT11W_PMF_SUPPORT
		rtmp_read_pmf_parameters_from_file(pAd, tmpbuf, pBuffer);
#endif /* DOT11W_PMF_SUPPORT */

#ifdef CONFIG_AP_SUPPORT
		/* EntryLifeCheck is used to check */
		if (RTMPGetKeyParameter("EntryLifeCheck", tmpbuf, 256, pBuffer, TRUE)) {
			long LifeCheckCnt;

			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			LifeCheckCnt = longtmp;

			if ((LifeCheckCnt <= 65535) && (LifeCheckCnt != 0))
				pAd->ApCfg.EntryLifeCheck = LifeCheckCnt;
			else
				pAd->ApCfg.EntryLifeCheck = MAC_ENTRY_LIFE_CHECK_CNT;

			DBGPRINT(RT_DEBUG_ERROR,
				 ("EntryLifeCheck=%ld\n", pAd->ApCfg.EntryLifeCheck));
		}
#endif /* CONFIG_AP_SUPPORT */

#ifdef SINGLE_SKU
		if (RTMPGetKeyParameter("AntGain", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			UCHAR AntGain = longtmp;

			pAd->CommonCfg.AntGain = AntGain;

			DBGPRINT(RT_DEBUG_TRACE, ("AntGain=%d\n", pAd->CommonCfg.AntGain));
		}
		if (RTMPGetKeyParameter("BandedgeDelta", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			UCHAR Bandedge = longtmp;

			pAd->CommonCfg.BandedgeDelta = Bandedge;

			DBGPRINT(RT_DEBUG_TRACE,
				 ("BandedgeDelta=%d\n", pAd->CommonCfg.BandedgeDelta));
		}
#endif /* SINGLE_SKU */

#if (defined(WOW_SUPPORT) && defined(RTMP_MAC_USB)) || defined(NEW_WOW_SUPPORT)
		/* set GPIO pin for wake-up signal */
		if (RTMPGetKeyParameter("WOW_GPIO", tmpbuf, 10, pBuffer, TRUE))
			Set_WOW_GPIO(pAd, tmpbuf);

		/* set WOW enable/disable */
		if (RTMPGetKeyParameter("WOW_Enable", tmpbuf, 10, pBuffer, TRUE))
			Set_WOW_Enable(pAd, tmpbuf);

		/* set delay time for WOW really enable */
		if (RTMPGetKeyParameter("WOW_Delay", tmpbuf, 10, pBuffer, TRUE))
			Set_WOW_Delay(pAd, tmpbuf);

		/* set GPIO pulse hold time */
		if (RTMPGetKeyParameter("WOW_Hold", tmpbuf, 10, pBuffer, TRUE))
			Set_WOW_Hold(pAd, tmpbuf);

		/* set wakeup signal type */
		if (RTMPGetKeyParameter("WOW_InBand", tmpbuf, 10, pBuffer, TRUE))
			Set_WOW_InBand(pAd, tmpbuf);

		/* set GPIO high/low active */
		if (RTMPGetKeyParameter("WOW_HighActive", tmpbuf, 10, pBuffer, TRUE))
			Set_WOW_HighActive(pAd, tmpbuf);

		/* set always trigger wakeup */
		if (RTMPGetKeyParameter("WOW_AlwaysTrigger", tmpbuf, 10, pBuffer, TRUE))
			Set_WOW_Always_Trigger(pAd, tmpbuf);

		/* set advanced WOW enable/disable */
		if (RTMPGetKeyParameter("Adv_WOW_Enable", tmpbuf, 10, pBuffer, TRUE))
			Set_Adv_WOW_Enable(pAd, tmpbuf);

		/* set advanced WOW sleep cycle time */
		if (RTMPGetKeyParameter("Adv_WOW_SleepTime", tmpbuf, 10, pBuffer, TRUE))
			Set_Adv_WOW_SleepTime(pAd, tmpbuf);

		/* set GPIO configure by wmt commnd */
		if (RTMPGetKeyParameter("WOW_WmtGPIOCmd", tmpbuf, 10, pBuffer, TRUE))
			Set_WOW_WmtGPIOCmd(pAd, tmpbuf);

		/* set GPIO mode in wmt */
		if (RTMPGetKeyParameter("WMT_GPIOMode", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_GPIOMode(pAd, tmpbuf);

		/* set WiFi GPIO high/low active in wmt */
		if (RTMPGetKeyParameter("WMT_WiFiHighActive", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_WiFiHighActive(pAd, tmpbuf);

		/* set BT GPIO high/low active in wmt */
		if (RTMPGetKeyParameter("WMT_BTHighActive", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_BTHighActive(pAd, tmpbuf);

		/* set the enable toggle for WOW in wmt */
		if (RTMPGetKeyParameter("WMT_WiFiWake1Toggle", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_WiFiWake1Toggle(pAd, tmpbuf);

		/* set the enable toggle for WOBLE on mode in wmt */
		if (RTMPGetKeyParameter("WMT_WiFiWake2Toggle", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_WiFiWake2Toggle(pAd, tmpbuf);

		/* set the enable toggle for WOBLE ambilight mode in wmt */
		if (RTMPGetKeyParameter("WMT_WiFiWake3Toggle", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_WiFiWake3Toggle(pAd, tmpbuf);

		/* set the enable toggle for WOW in wmt */
		if (RTMPGetKeyParameter("WMT_BTWake1Toggle", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_BTWake1Toggle(pAd, tmpbuf);

		/* set the enable toggle for WOBLE on mode in wmt */
		if (RTMPGetKeyParameter("WMT_BTWake2Toggle", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_BTWake2Toggle(pAd, tmpbuf);

		/* set the enable toggle for WOBLE ambilight mode in wmt */
		if (RTMPGetKeyParameter("WMT_BTWake3Toggle", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_BTWake3Toggle(pAd, tmpbuf);

		/* set the hold time for WOW in wmt */
		if (RTMPGetKeyParameter("WMT_WiFiWake1HoldTime", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_WiFiWake1HoldTime(pAd, tmpbuf);

		/* set the hold time for WOBLE on mode in wmt */
		if (RTMPGetKeyParameter("WMT_WiFiWake2HoldTime", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_WiFiWake2HoldTime(pAd, tmpbuf);

		/* set the hold time for WOBLE ambilight mode in wmt */
		if (RTMPGetKeyParameter("WMT_WiFiWake3HoldTime", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_WiFiWake3HoldTime(pAd, tmpbuf);

		/* set the hold time for WOW in wmt */
		if (RTMPGetKeyParameter("WMT_BTWake1HoldTime", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_BTWake1HoldTime(pAd, tmpbuf);

		/* set the hold time for WOBLE on mode in wmt */
		if (RTMPGetKeyParameter("WMT_BTWake2HoldTime", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_BTWake2HoldTime(pAd, tmpbuf);

		/* set the hold time for WOBLE on mode in wmt */
		if (RTMPGetKeyParameter("WMT_BTWake3HoldTime", tmpbuf, 10, pBuffer, TRUE))
			Set_Wmt_BTWake3HoldTime(pAd, tmpbuf);

#endif /* (defined(WOW_SUPPORT) && defined(RTMP_MAC_USB)) || defined(NEW_WOW_SUPPORT) */

#ifdef RTMP_MAC_USB
		/* set USB2 Disconnect mode in USB disconnect feature */
		if (RTMPGetKeyParameter("USBDicon", tmpbuf, 10, pBuffer, TRUE))
			Set_usb2_Disconnect(pAd, tmpbuf);

		/* set GPIO notify interrupt mode in USB disconnect feature */
		if (RTMPGetKeyParameter("GPIONotifyMode", tmpbuf, 10, pBuffer, TRUE))
			Set_GPIO_Notify_Mode(pAd, tmpbuf);

		/* set notify from GPIO pin in USB disconnect feature */
		if (RTMPGetKeyParameter("GPIONotifyPin", tmpbuf, 10, pBuffer, TRUE))
			Set_GPIO_Notify_Pin(pAd, tmpbuf);
#endif

#ifdef MICROWAVE_OVEN_SUPPORT
		if (RTMPGetKeyParameter("MO_FalseCCATh", tmpbuf, 10, pBuffer, TRUE))
			Set_MO_FalseCCATh_Proc(pAd, tmpbuf);
#endif /* MICROWAVE_OVEN_SUPPORT */

#ifdef CONFIG_SNIFFER_SUPPORT
		if (RTMPGetKeyParameter("SnifferType", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->sniffer_ctl.sniffer_type = longtmp;
#ifdef CONFIG_STA_SUPPORT
			set_sniffer_mode(pAd->StaCfg.wdev.if_dev, pAd->sniffer_ctl.sniffer_type);
#endif /* CONFIG_STA_SUPPORT */
			DBGPRINT(RT_DEBUG_OFF,
				 ("SnifferType = %d\n", pAd->sniffer_ctl.sniffer_type));
		}
#endif /* CONFIG_SNIFFER_SUPPORT */

#ifdef RTMP_USB_SUPPORT
		if (RTMPGetKeyParameter("USBAggregation", tmpbuf, 10, pBuffer, TRUE)) {
			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;

			pAd->usb_ctl.usb_aggregation = longtmp;

			DBGPRINT(RT_DEBUG_OFF,
				("USBAggregation = %d\n", pAd->usb_ctl.usb_aggregation));
		}
#endif /* RTMP_USB_SUPPORT */

#ifdef RT_CFG80211_SUPPORT
#ifdef CERTIFICATION_SIGMA_SUPPORT
		if (RTMPGetKeyParameter("SigmaEnable", tmpbuf, 10, pBuffer, TRUE))
			Set_EnableSigmaSupport_Proc(pAd, tmpbuf);
#endif /* CERTIFICATION_SIGMA_SUPPORT */
#endif /* RT_CFG80211_SUPPORT   */

		/* StopEP5Count */
		if (RTMPGetKeyParameter("StopEP5Count", tmpbuf, 10, pBuffer, TRUE)) {
			ULONG	StopEP5Count;

			ret = os_strtol(tmpbuf, 10, &longtmp);
			if (ret < 0)
				return FALSE;
			StopEP5Count = longtmp;
			if ((StopEP5Count >= 1) && (StopEP5Count <= 800))
				pAd->StopEP5Count = StopEP5Count * 125000; /* translate to Bps*/
			else
				pAd->StopEP5Count = STOP_EP5_COUNT_BPS;

			DBGPRINT(RT_DEBUG_ERROR,
				 ("Set_StopEP5Count_Proc::(%ld bps)\n", pAd->StopEP5Count * 8));
		}
	} while (0);

	os_free_vmem(NULL, tmpbuf);

	return NDIS_STATUS_SUCCESS;
}

#ifdef MULTIPLE_CARD_SUPPORT
/* record whether the card in the card list is used in the card file*/
UINT8 MC_CardUsed[MAX_NUM_OF_MULTIPLE_CARD] = { 0 };

/* record used card mac address in the card list*/
static UINT8 MC_CardMac[MAX_NUM_OF_MULTIPLE_CARD][6];

BOOLEAN get_mac_from_eeprom(RTMP_ADAPTER *pAd, UCHAR *mac)
{
	USHORT addr, ee_addr;
	INT idx;

	for (ee_addr = 0x04, idx = 0; ee_addr <= 0x08; ee_addr += 2, idx += 2) {
		RT28xx_EEPROM_READ16(pAd, ee_addr, addr);
		mac[idx] = (UCHAR) (addr & 0xff);
		mac[idx + 1] = (UCHAR) (addr >> 8);
	}

	return TRUE;
}

#ifdef RTMP_FLASH_SUPPORT
#define EEPROM_SEG_IN_NVM 2	/* segments for EEPROM in flash */
#endif /* RTMP_FLASH_SUPPORT */

/*
========================================================================
Routine Description:
	Get card profile path.

Arguments:
	pAd

Return Value:
	TRUE		- Find a card profile
	FALSE		- use default profile

Note:
========================================================================
*/
BOOLEAN RTMP_CardInfoRead(IN PRTMP_ADAPTER pAd)
{
#define MC_SELECT_CARDID		0	/* use CARD ID (0 ~ 31) to identify different cards */
#define MC_SELECT_MAC			1	/* use CARD MAC to identify different cards */
#define MC_SELECT_CARDTYPE		2	/* use CARD type (abgn or bgn) to identify different cards */

#define LETTER_CASE_TRANSLATE(txt_p, card_id)			\
	{	UINT32 _len; char _char;						\
		for (_len = 0; _len < strlen(card_id); _len++) {		\
			_char = *(txt_p + _len);					\
			if (('A' <= _char) && (_char <= 'Z'))		\
				*(txt_p+_len) = 'a'+(_char-'A');		\
		} }

	RTMP_OS_FD srcf;
	INT retval;
	PSTRING buffer, tmpbuf;
	STRING card_id_buf[30], RFIC_word[30];
	BOOLEAN flg_match_ok = FALSE;
	INT32 card_select_method;
	INT32 card_free_id, card_nouse_id, card_same_mac_id, card_match_id;
	EEPROM_ANTENNA_STRUC antenna;
	USHORT addr01, addr23, addr45;
	UINT8 mac[6];
#ifdef RTMP_FLASH_SUPPORT
	UINT8 mac_maybe[EEPROM_SEG_IN_NVM][MAC_ADDR_LEN];
	INT segment = 0;
#endif /* RTMP_FLASH_SUPPORT */
	UINT32 data, card_index;
	UCHAR *start_ptr;
	RTMP_OS_FS_INFO osFSInfo;
	INT	ret;
	LONG longtmp;
	/* init */
	os_alloc_mem(NULL, (UCHAR **) &buffer, MAX_INI_BUFFER_SIZE);
	if (buffer == NULL)
		return FALSE;

	os_alloc_mem(NULL, (UCHAR **) &tmpbuf, MAX_PARAM_BUFFER_SIZE);
	if (tmpbuf == NULL) {
		os_free_mem(NULL, buffer);
		return NDIS_STATUS_FAILURE;
	}

	RT28xx_EEPROM_READ16(pAd, EEPROM_NIC1_OFFSET, antenna.word);

	if ((antenna.field.RfIcType == RFIC_2850) ||
	    (antenna.field.RfIcType == RFIC_2750) ||
	    (antenna.field.RfIcType == RFIC_2853) ||
	    (antenna.field.RfIcType == RFIC_3853) ||
	    (antenna.field.RfIcType == RFIC_7650) ||
	    (antenna.field.RfIcType == RFIC_7610U) || (antenna.field.RfIcType == RFIC_5592)) {
		/* ABGN card */
		strcpy(RFIC_word, "abgn");
	} else if (antenna.field.RfIcType == RFIC_7610E) {
		/* ABGN card */
		strcpy(RFIC_word, "an");
	} else {
		/* BGN card */
		strcpy(RFIC_word, "bgn");
	}

	/* get MAC address */
#ifdef RTMP_FLASH_SUPPORT
	RtmpFlashRead(&mac_maybe[0][0], 0x40000 + 0x04, MAC_ADDR_LEN);
	RtmpFlashRead(&mac_maybe[1][0], 0x48000 + 0x04, MAC_ADDR_LEN);
	DBGPRINT(RT_DEBUG_TRACE,
		 ("mac addr1 in flash=%02x:%02x:%02x:%02x:%02x:%02x!\n", PRINT_MAC(mac_maybe[0])));
	DBGPRINT(RT_DEBUG_TRACE,
		 ("mac addr2 in flash=%02x:%02x:%02x:%02x:%02x:%02x!\n", PRINT_MAC(mac_maybe[1])));
#endif /* RTMP_FLASH_SUPPORT */

	get_mac_from_eeprom(pAd, &mac[0]);
	DBGPRINT(RT_DEBUG_TRACE, ("mac addr=%02x:%02x:%02x:%02x:%02x:%02x!\n", PRINT_MAC(mac)));

	RtmpOSFSInfoChange(&osFSInfo, TRUE);
	/* open card information file */
	srcf = RtmpOSFileOpen(CARD_INFO_PATH, O_RDONLY, 0);
	if (IS_FILE_OPEN_ERR(srcf)) {
		/* card information file does not exist */
		DBGPRINT(RT_DEBUG_TRACE, ("--> Error opening %s\n", CARD_INFO_PATH));
		goto free_resource;
	}

	/* card information file exists so reading the card information */
	memset(buffer, 0x00, MAX_INI_BUFFER_SIZE);
	retval = RtmpOSFileRead(srcf, buffer, MAX_INI_BUFFER_SIZE);
	if (retval < 0) {
		/* read fail */
		DBGPRINT(RT_DEBUG_TRACE, ("--> Read %s error %d\n", CARD_INFO_PATH, -retval));
	} else {
		/* get card selection method */
		memset(tmpbuf, 0x00, MAX_PARAM_BUFFER_SIZE);
		card_select_method = MC_SELECT_CARDTYPE;	/* default */

		if (RTMPGetKeyParameter("SELECT", tmpbuf, 256, buffer, TRUE)) {
			if (strcmp(tmpbuf, "CARDID") == 0)
				card_select_method = MC_SELECT_CARDID;
			else if (strcmp(tmpbuf, "MAC") == 0)
				card_select_method = MC_SELECT_MAC;
			else if (strcmp(tmpbuf, "CARDTYPE") == 0)
				card_select_method = MC_SELECT_CARDTYPE;
		}

		DBGPRINT(RT_DEBUG_TRACE, ("MC> Card Selection = %d\n", card_select_method));

		/* init */
		card_free_id = -1;
		card_nouse_id = -1;
		card_same_mac_id = -1;
		card_match_id = -1;

		/* search current card information records */
		for (card_index = 0; card_index < MAX_NUM_OF_MULTIPLE_CARD; card_index++) {
			if ((*(UINT32 *) &MC_CardMac[card_index][0] == 0) &&
			    (*(UINT16 *) &MC_CardMac[card_index][4] == 0)) {
				/* MAC is all-0 so the entry is available */
				MC_CardUsed[card_index] = 0;
				if (card_free_id < 0)
					card_free_id = card_index;	/* 1st free entry */
			} else {
				if (memcmp(MC_CardMac[card_index], mac, 6) == 0) {
					/* we find the entry with same MAC */
					if (card_same_mac_id < 0)
						card_same_mac_id = card_index;	/* 1st same entry */
				} else {
					/* MAC is not all-0 but used flag == 0 */
					if ((MC_CardUsed[card_index] == 0) && (card_nouse_id < 0))
						card_nouse_id = card_index;	/* 1st available entry */
				}
			}
		}

		DBGPRINT(RT_DEBUG_TRACE,
			 ("MC> Free = %d, Same = %d, NOUSE = %d\n",
			  card_free_id, card_same_mac_id, card_nouse_id));

		if ((card_same_mac_id >= 0) &&
		    ((card_select_method == MC_SELECT_CARDID) ||
		     (card_select_method == MC_SELECT_CARDTYPE))) {
			/* same MAC entry is found */
			card_match_id = card_same_mac_id;

			if (card_select_method == MC_SELECT_CARDTYPE) {
				/* for CARDTYPE */
				snprintf(card_id_buf, sizeof(card_id_buf), "%02dCARDTYPE%s",
					 card_match_id, RFIC_word);

				start_ptr = (PUCHAR) rtstrstruncasecmp(buffer, card_id_buf);
				if (start_ptr != NULL) {
					/* we found the card ID */
					LETTER_CASE_TRANSLATE(start_ptr, card_id_buf);
				}
			}
		} else {
			/* the card is 1st plug-in, try to find the match card profile */
			switch (card_select_method) {
			case MC_SELECT_CARDID:	/* CARDID */
			default:
				if (card_free_id >= 0)
					card_match_id = card_free_id;
				else
					card_match_id = card_nouse_id;
				break;

			case MC_SELECT_MAC:	/* MAC */
#ifdef RTMP_FLASH_SUPPORT
				memcpy(&mac[0], &mac_maybe[segment][0], MAC_ADDR_LEN);
#endif /* RTMP_FLASH_SUPPORT */
				snprintf(card_id_buf, sizeof(card_id_buf),
					 "MAC%02x:%02x:%02x:%02x:%02x:%02x", mac[0], mac[1], mac[2],
					 mac[3], mac[4], mac[5]);

				/* try to find the key word in the card file */
				start_ptr = (PUCHAR) rtstrstruncasecmp(buffer, card_id_buf);
				if (start_ptr != NULL) {
					LETTER_CASE_TRANSLATE(start_ptr, card_id_buf);

					/* get the row ID (2 ASCII characters) */
					start_ptr -= 2;
					card_id_buf[0] = *(start_ptr);
					card_id_buf[1] = *(start_ptr + 1);
					card_id_buf[2] = 0x00;

					ret = os_strtol(card_id_buf, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					card_match_id = longtmp;

#ifdef RTMP_FLASH_SUPPORT
					if (MC_CardUsed[card_match_id] == 1) {
						/* try again to find the key word
						in the card file by
						the other MAC address */
						segment += 1;
						memcpy(&mac[0], &mac_maybe[segment][0],
						       MAC_ADDR_LEN);
						snprintf(card_id_buf, sizeof(card_id_buf),
							 "MAC%02x:%02x:%02x:%02x:%02x:%02x", mac[0],
							 mac[1], mac[2], mac[3], mac[4], mac[5]);

						start_ptr =
						(PUCHAR) rtstrstruncasecmp(buffer, card_id_buf);
						if (start_ptr != NULL) {
							LETTER_CASE_TRANSLATE(start_ptr,
									      card_id_buf);

							/* get the row ID (2 ASCII characters) */
							start_ptr -= 2;
							card_id_buf[0] = *(start_ptr);
							card_id_buf[1] = *(start_ptr + 1);
							card_id_buf[2] = 0x00;

							ret = os_strtol(card_id_buf, 10, &longtmp);
							if (ret < 0)
								return FALSE;

							card_match_id = longtmp;
						}
					}
#endif /* RTMP_FLASH_SUPPORT */
				}
				break;

			case MC_SELECT_CARDTYPE:	/* CARDTYPE */
				card_nouse_id = -1;

				for (card_index = 0;
				     card_index < MAX_NUM_OF_MULTIPLE_CARD; card_index++) {
					snprintf(card_id_buf, sizeof(card_id_buf),
					"%02dCARDTYPE%s", card_index, RFIC_word);
					start_ptr = (PUCHAR) rtstrstruncasecmp(buffer, card_id_buf);
					if (start_ptr != NULL) {
						LETTER_CASE_TRANSLATE(start_ptr, card_id_buf);

						if (MC_CardUsed[card_index] == 0) {
							/* current the card profile is not used */
							if ((*(UINT32 *) &MC_CardMac[card_index][0]
							     == 0)
							    && (*(UINT16 *) &
								MC_CardMac[card_index][4] == 0)) {
								/* find it and no previous card use it */
								card_match_id = card_index;
								break;
							}
							{
								/* ever a card use it */
								if (card_nouse_id < 0)
									card_nouse_id = card_index;
							}
						}
					}
				}

				/* if not find a free one, use the available one */
				if (card_match_id < 0)
					card_match_id = card_nouse_id;
				break;
			}
		}

		if (card_match_id >= 0) {
			/* make up search keyword */
			switch (card_select_method) {
			case MC_SELECT_CARDID:	/* CARDID */
				snprintf(card_id_buf, sizeof(card_id_buf), "%02dCARDID",
					 card_match_id);
				break;

			case MC_SELECT_MAC:	/* MAC */
				snprintf(card_id_buf, sizeof(card_id_buf),
					 "%02dmac%02x:%02x:%02x:%02x:%02x:%02x",
					 card_match_id,
					 mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
				break;

			case MC_SELECT_CARDTYPE:	/* CARDTYPE */
			default:
				snprintf(card_id_buf, sizeof(card_id_buf), "%02dcardtype%s",
					 card_match_id, RFIC_word);
				break;
			}

			DBGPRINT(RT_DEBUG_TRACE, ("Search Keyword = %s\n", card_id_buf));

			/* read card file path */
			if (RTMPGetKeyParameter(card_id_buf, tmpbuf, 256, buffer, TRUE)) {
				if (strlen(tmpbuf) < sizeof(pAd->MC_FileName)) {
					/* backup card information */
					pAd->MC_RowID = card_match_id;	/* base 0 */
					/*
					   If we are run in Multicard mode, the eeinit shall execute
					   here instead of NICReadEEPROMParameters()
					 */
					if (pAd->chipOps.eeinit)
						pAd->chipOps.eeinit(pAd);

					get_mac_from_eeprom(pAd, &mac[0]);
					MC_CardUsed[card_match_id] = 1;
					memcpy(MC_CardMac[card_match_id], mac, sizeof(mac));

					/* backup card file path */
					NdisMoveMemory(pAd->MC_FileName, tmpbuf, strlen(tmpbuf));
					pAd->MC_FileName[strlen(tmpbuf)] = '\0';
					flg_match_ok = TRUE;

					DBGPRINT(RT_DEBUG_TRACE,
						 ("Card Profile Name = %s\n", pAd->MC_FileName));
				} else {
					DBGPRINT(RT_DEBUG_ERROR,
						 ("Card Profile Name length too large!\n"));
				}
			} else {
				DBGPRINT(RT_DEBUG_ERROR,
					 ("Can not find search key word in card.dat!\n"));
			}

			if ((flg_match_ok != TRUE) && (card_match_id < MAX_NUM_OF_MULTIPLE_CARD)) {
				MC_CardUsed[card_match_id] = 0;
				memset(MC_CardMac[card_match_id], 0, sizeof(mac));
			}
		}		/* if (card_match_id >= 0) */
	}

/* close file*/
	retval = RtmpOSFileClose(srcf);

free_resource:
	RtmpOSFSInfoChange(&osFSInfo, FALSE);
	os_free_mem(NULL, buffer);
	os_free_mem(NULL, tmpbuf);

	return flg_match_ok;
}
#endif /* MULTIPLE_CARD_SUPPORT */

#ifdef WSC_INCLUDED
void rtmp_read_wsc_user_parms(PWSC_CTRL pWscControl, STRING *tmpbuf, STRING *buffer)
{
	if (RTMPGetKeyParameter("WscManufacturer", tmpbuf, WSC_MANUFACTURE_LEN, buffer, TRUE)) {
		NdisZeroMemory(pWscControl->RegData.SelfInfo.Manufacturer, WSC_MANUFACTURE_LEN);
		NdisMoveMemory(pWscControl->RegData.SelfInfo.Manufacturer, tmpbuf, strlen(tmpbuf));
		if (pWscControl->RegData.SelfInfo.Manufacturer[0] != 0x00)
			RTMP_SET_FLAG(pWscControl, 0x01);
	}

	/*WSC_User_ModelName */
	if (RTMPGetKeyParameter("WscModelName", tmpbuf, WSC_MODELNAME_LEN, buffer, TRUE)) {
		NdisZeroMemory(pWscControl->RegData.SelfInfo.ModelName, WSC_MODELNAME_LEN);
		NdisMoveMemory(pWscControl->RegData.SelfInfo.ModelName, tmpbuf, strlen(tmpbuf));
		if (pWscControl->RegData.SelfInfo.ModelName[0] != 0x00)
			RTMP_SET_FLAG(pWscControl, 0x02);
	}

	/*WSC_User_DeviceName */
	if (RTMPGetKeyParameter("WscDeviceName", tmpbuf, WSC_DEVICENAME_LEN, buffer, TRUE)) {
		NdisZeroMemory(pWscControl->RegData.SelfInfo.DeviceName, WSC_DEVICENAME_LEN);
		NdisMoveMemory(pWscControl->RegData.SelfInfo.DeviceName, tmpbuf, strlen(tmpbuf));
		if (pWscControl->RegData.SelfInfo.DeviceName[0] != 0x00)
			RTMP_SET_FLAG(pWscControl, 0x04);
	}

	/*WSC_User_ModelNumber */
	if (RTMPGetKeyParameter("WscModelNumber", tmpbuf, WSC_MODELNUNBER_LEN, buffer, TRUE)) {
		NdisZeroMemory(pWscControl->RegData.SelfInfo.ModelNumber, WSC_MODELNUNBER_LEN);
		NdisMoveMemory(pWscControl->RegData.SelfInfo.ModelNumber, tmpbuf, strlen(tmpbuf));
		if (pWscControl->RegData.SelfInfo.ModelNumber[0] != 0x00)
			RTMP_SET_FLAG(pWscControl, 0x08);
	}

	/*WSC_User_SerialNumber */
	if (RTMPGetKeyParameter("WscSerialNumber", tmpbuf, WSC_SERIALNUNBER_LEN, buffer, TRUE)) {
		NdisZeroMemory(pWscControl->RegData.SelfInfo.SerialNumber, WSC_SERIALNUNBER_LEN);
		NdisMoveMemory(pWscControl->RegData.SelfInfo.SerialNumber, tmpbuf, strlen(tmpbuf));
		if (pWscControl->RegData.SelfInfo.SerialNumber[0] != 0x00)
			RTMP_SET_FLAG(pWscControl, 0x10);
	}
}

void rtmp_read_wsc_user_parms_from_file(IN PRTMP_ADAPTER pAd, char *tmpbuf, char *buffer)
{
	PWSC_CTRL pWscControl;

#ifdef WSC_AP_SUPPORT
	int i = 0;

	for (i = 0; i < MAX_MBSSID_NUM(pAd); i++) {
		pWscControl = &pAd->ApCfg.MBSSID[i].WscControl;
		rtmp_read_wsc_user_parms(pWscControl, tmpbuf, buffer);
	}
#ifdef APCLI_SUPPORT
	pWscControl = &pAd->ApCfg.ApCliTab[0].WscControl;
	rtmp_read_wsc_user_parms(pWscControl, tmpbuf, buffer);
#endif /* APCLI_SUPPORT */
#endif /* WSC_AP_SUPPORT */

#ifdef WSC_STA_SUPPORT
	pWscControl = &pAd->StaCfg.WscControl;
	rtmp_read_wsc_user_parms(pWscControl, tmpbuf, buffer);
#endif /* WSC_STA_SUPPORT */

}
#endif /*WSC_INCLUDED */

#ifdef SINGLE_SKU_V2
#ifdef JUNGLE_SUPPORT
INT RTMPPrintSKUParams(IN PRTMP_ADAPTER pAd, DL_LIST *tbl)
{
	NDIS_STATUS ret = NDIS_STATUS_SUCCESS;
	CH_POWER *ch, *ch_temp;

	ret = DlListEmpty(tbl);
	if (ret)
		goto table_not_init;

	DlListForEachSafe(ch, ch_temp, tbl, CH_POWER, List) {
		int i;

		DBGPRINT(RT_DEBUG_ERROR, ("start ch = %d, ch->num = %d\n",
			 ch->StartChannel, ch->num));

		DBGPRINT(RT_DEBUG_ERROR, ("Channel: "));
		for (i = 0; i < ch->num; i++)
			DBGPRINT(RT_DEBUG_ERROR, ("%d ", ch->Channel[i]));
		DBGPRINT(RT_DEBUG_ERROR, ("\n"));

		DBGPRINT(RT_DEBUG_ERROR, ("CCK: "));
		for (i = 0; i < SINGLE_SKU_TABLE_CCK_LENGTH; i++)
			DBGPRINT(RT_DEBUG_ERROR, ("%d ", ch->PwrCCK[i]));
		DBGPRINT(RT_DEBUG_ERROR, ("\n"));

		DBGPRINT(RT_DEBUG_ERROR, ("OFDM: "));
		for (i = 0; i < SINGLE_SKU_TABLE_OFDM_LENGTH; i++)
			DBGPRINT(RT_DEBUG_ERROR, ("%d ", ch->PwrOFDM[i]));
		DBGPRINT(RT_DEBUG_ERROR, ("\n"));

		DBGPRINT(RT_DEBUG_ERROR, ("HT20: "));
		for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++)
			DBGPRINT(RT_DEBUG_ERROR, ("%d ", ch->PwrHT20[i]));
		DBGPRINT(RT_DEBUG_ERROR, ("\n"));

		DBGPRINT(RT_DEBUG_ERROR, ("HT40: "));
		for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++)
			DBGPRINT(RT_DEBUG_ERROR, ("%d ", ch->PwrHT40[i]));
		DBGPRINT(RT_DEBUG_ERROR, ("\n"));

		DBGPRINT(RT_DEBUG_ERROR, ("VHT80: "));
		for (i = 0; i < SINGLE_SKU_TABLE_VHT_LENGTH; i++)
			DBGPRINT(RT_DEBUG_ERROR, ("%d ", ch->PwrVHT80[i]));
		DBGPRINT(RT_DEBUG_ERROR, ("\n"));
	}

	return ret;
table_not_init:
	DBGPRINT(RT_DEBUG_ERROR, ("%s Power list not initialized\n", __func__));
	return NDIS_STATUS_FAILURE;
}

#define REG_EU_COUNTRY_NUM 3
static CHAR eu_country_tbl[REG_EU_COUNTRY_NUM][2] = { "GB", "DE", "FR" };

INT RTMPLoadSKUProfile(IN PRTMP_ADAPTER pAd, IN PSTRING arg)
{
	NDIS_STATUS ret = NDIS_STATUS_SUCCESS;
	struct _PRELOAD_SKU_LIST *list, *list_temp;
	struct _PRELOAD_SKU_LIST *to = NULL, *from = NULL;
	CH_POWER *ch, *ch_temp;
	BOOLEAN found = FALSE;
	unsigned long flags;
	INT i = 0;

	if (DlListEmpty(&pAd->PreloadSkuPwrList)) {
		DBGPRINT(RT_DEBUG_ERROR, ("%s, No PreloadSkuPwrList\n", __func__));
		goto switch_fail;
	}

	for (i = 0; i < REG_EU_COUNTRY_NUM; i++) {
		if ((eu_country_tbl[i][0] == arg[0]) && (eu_country_tbl[i][1] == arg[1])) {
			DBGPRINT(RT_DEBUG_TRACE,
				("%s, %c%c EU area match\n", __func__, arg[0], arg[1]));
			arg[0] = 'E';
			arg[1] = 'U';
			break;
		}
	}

	DlListForEachSafe(list, list_temp, &pAd->PreloadSkuPwrList
			, struct _PRELOAD_SKU_LIST, List) {
		if ((list->Country[0] == arg[0]) && (list->Country[1] == arg[1])) {
			found = TRUE;
			to = list;
			DBGPRINT(RT_DEBUG_TRACE, ("%s, %c%c match\n", __func__, arg[0], arg[1]));
		} else if (list->in_use) {
			from = list;
			DBGPRINT(RT_DEBUG_TRACE, ("%s, current using profile %c%c\n"
				, __func__, list->Country[0], list->Country[1]));
		}
	}

	if (!from)
		goto switch_fail;
	if (!found)
		goto fall_back;

	to->in_use = TRUE;
	from->in_use = FALSE;

	DlListInit(&from->sku_pwr_list);
	RTMP_SPIN_LOCK_IRQSAVE(&pAd->sku_lock, &flags);
	DlListForEachSafe(ch, ch_temp, &pAd->SingleSkuPwrList, CH_POWER, List) {
		DlListAddTail(&from->sku_pwr_list, &ch->List);
	}
	DlListInit(&pAd->SingleSkuPwrList);

	DlListForEachSafe(ch, ch_temp, &to->sku_pwr_list, CH_POWER, List) {
		DlListAddTail(&pAd->SingleSkuPwrList, &ch->List);
	}
	RTMP_SPIN_UNLOCK_IRQRESTORE(&pAd->sku_lock, &flags);

	DlListInit(&to->sku_pwr_list);
	return ret;
switch_fail:
	DBGPRINT(RT_DEBUG_ERROR,
		("%s, %c%c current use not found/already inuse\n", __func__, arg[0], arg[1]));
	return NDIS_STATUS_INVALID_DATA;
fall_back:
	DBGPRINT(RT_DEBUG_ERROR,
		("%s, %c%c no sku table found fall back to WW\n", __func__, arg[0], arg[1]));
	if (from && strcmp(from->Country, "00"))
		RTMPLoadSKUProfile(pAd, "00");
	return ret;
}

INT RTMPShowSingleSKUParameters(IN PRTMP_ADAPTER pAd, IN PSTRING arg)
{
	NDIS_STATUS ret = NDIS_STATUS_SUCCESS;

	DBGPRINT(RT_DEBUG_ERROR, ("[REG::DBG] %s\n", __func__));
	ret = RTMPPrintSKUParams(pAd, &pAd->SingleSkuPwrList);
	return ret;
}

NDIS_STATUS RTMPSetSingleSKUParameters(RTMP_ADAPTER *pAd)
{
	NDIS_STATUS ret = NDIS_STATUS_SUCCESS;

	ret = RTMPSetSingleSKUParametersExt(pAd, SINGLE_SKU_TABLE_FILE_NAME, FALSE, NULL);
	return ret;
}

NDIS_STATUS RTMPReleasePreloadSkuTbl(RTMP_ADAPTER *pAd)
{
	NDIS_STATUS ret = NDIS_STATUS_SUCCESS;
	struct _PRELOAD_SKU_LIST *list, *list_temp;

	DlListForEachSafe(list, list_temp, &pAd->PreloadSkuPwrList
		, struct _PRELOAD_SKU_LIST, List) {
		CH_POWER *ch, *ch_temp;

		DlListForEachSafe(ch, ch_temp, &list->sku_pwr_list, CH_POWER, List) {
			DlListDel(&ch->List);
			os_free_mem(NULL, ch->Channel);
			os_free_mem(NULL, ch);
		}
	}
	DlListDel(&pAd->PreloadSkuPwrList);
	DlListInit(&pAd->PreloadSkuPwrList);
	return ret;
}

NDIS_STATUS RTMPPreloadSingleSKUParameters(RTMP_ADAPTER *pAd, INT def_success)
{
	PSTRING buffer = NULL;
	PSTRING readline;
	RTMP_OS_FD srcf;
	INT retval;
	PSTRING ptr;
	RTMP_OS_FS_INFO osFSInfo;
	int index;
	INT bufferSize, filesize;
	NDIS_STATUS ret = NDIS_STATUS_FAILURE;
	CHAR fpath[256];
	struct _PRELOAD_SKU_LIST *list, *list_temp;
	struct _PRELOAD_SKU_LIST *sku_list = NULL;

	NdisZeroMemory(fpath, 255);
	RtmpOSFSInfoChange(&osFSInfo, TRUE);
	pAd->bOpenFileSuccess = FALSE;

	DBGPRINT(RT_DEBUG_ERROR, ("%s add \\0 at the end of buffer\n", __func__));
	DlListInit(&pAd->PreloadSkuPwrList);

	if (def_success) {
		/* card information file does not exist */
		DBGPRINT(RT_DEBUG_ERROR, ("%s default table load fail\n", __func__));
		goto open_fail;
	}

	/* open card information file */
	srcf = RtmpOSFileOpen(SINGLE_SKU_TABLE_PRELOAD, O_RDONLY, 0);
	if (IS_FILE_OPEN_ERR(srcf)) {
		/* card information file does not exist */
		DBGPRINT(RT_DEBUG_ERROR, ("%s open fail %s\n", __func__,
			 SINGLE_SKU_TABLE_FILE_NAME));
		goto open_fail;
	}

	bufferSize = srcf->f_dentry->d_inode->i_size;

	/* init */
	buffer = RtmpOsVmalloc(bufferSize + 1);
	if (buffer == NULL) {
		DBGPRINT(RT_DEBUG_ERROR, ("%s alloc %d fail\n", __func__,
			 bufferSize));
		ret = NDIS_STATUS_RESOURCES;
		goto alloc_fail_1;
	}

	DBGPRINT(RT_DEBUG_TRACE,
		("%s, file being read is  : %s\n", __func__, SINGLE_SKU_TABLE_PRELOAD));
	/* card information file exists so reading the card information */
	NdisZeroMemory(buffer, bufferSize + 1);

	retval = RtmpOSFileRead(srcf, buffer, bufferSize);
	if (retval < 0) {
		/* read fail */
		DBGPRINT(RT_DEBUG_ERROR,
			 ("--> Read %s error %d\n", SINGLE_SKU_TABLE_FILE_NAME,
			 -retval));
		goto read_fail;
	}
	buffer[bufferSize] = '\0';
	ptr = buffer;
	readline = buffer;
	filesize = bufferSize;
	for (index = 0; (filesize > 0) && readline
		&& ((ptr = strchr(readline, '\n')) != NULL); index++) {
		*ptr = '\0';
		filesize -= (ptr - readline + 1);
		DBGPRINT(RT_DEBUG_TRACE,
			("%s, At start ptr = %p rl = %p  filesize = %d\n"
			, __func__, ptr, readline, filesize));

		ret = os_alloc_mem(NULL, (UCHAR **) &sku_list, sizeof(*sku_list));
		if (ret) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s alloc sku_list fail\n", __func__));
			ret = NDIS_STATUS_RESOURCES;
			goto read_fail;
		}
		NdisZeroMemory(sku_list, sizeof(*sku_list));
		DlListInit(&sku_list->sku_pwr_list);
		sprintf(fpath, "%s%s", SINGLE_SKU_TABLE_FILE_PATH, readline);
		if (strlen(readline) > strlen("SingleSKU_XX")) {
			sku_list->Country[0] = readline[strlen("SingleSKU_X") - 1];
			sku_list->Country[1] = readline[strlen("SingleSKU_XX") - 1];
		}
		ret = RTMPSetSingleSKUParametersExt(pAd, fpath, TRUE, &sku_list->sku_pwr_list);
		if (ret) {
			os_free_mem(NULL, sku_list);
			RTMPReleasePreloadSkuTbl(pAd);
			goto read_fail;
		}
		/* RTMPPrintSKUParams(pAd, &sku_list->sku_pwr_list); */
		DlListAddTail(&pAd->PreloadSkuPwrList, &sku_list->List);
		readline = ptr + 1;

		DBGPRINT(RT_DEBUG_TRACE, ("%s:%d at End ptr = %p rl = %p and filesize = %d\n",
					  __func__, index, ptr, readline, filesize));

		if (!readline || !(readline + 1))
			goto read_fail;
		if ((filesize > 0) && (readline[0] == '#'))
			continue;
	}

	if (DlListEmpty(&pAd->SingleSkuPwrList)) {
		DBGPRINT(RT_DEBUG_ERROR, ("%s, No singleSkuPwrList\n", __func__));
		goto read_fail;
	}

	pAd->bOpenFileSuccess = TRUE;
	ret = NDIS_STATUS_SUCCESS;

read_fail:
	ret = os_alloc_mem(NULL, (UCHAR **) &sku_list, sizeof(*sku_list));
	if (ret) {
		DBGPRINT(RT_DEBUG_ERROR, ("%s alloc sku_list\n", __func__));
		ret = NDIS_STATUS_RESOURCES;
		goto alloc_fail_2;
	}
	NdisZeroMemory(sku_list, sizeof(*sku_list));
	DlListInit(&sku_list->sku_pwr_list);
	sku_list->Country[0] = '0';
	sku_list->Country[1] = '0';
	sku_list->in_use = TRUE;
	DlListAddTail(&pAd->PreloadSkuPwrList, &sku_list->List);

#ifdef DBG
	DlListForEachSafe(list, list_temp, &pAd->PreloadSkuPwrList
			, struct _PRELOAD_SKU_LIST, List) {
		DBGPRINT(RT_DEBUG_OFF, ("%s, Country:%c%c\n"
			, __func__, list->Country[0], list->Country[1]));
		/* RTMPPrintSKUParams(pAd, &list->sku_pwr_list); */
	}
#endif
alloc_fail_2:
	if (buffer)
		RtmpOsVfree(buffer);
alloc_fail_1:
	retval = RtmpOSFileClose(srcf);
open_fail:
	RtmpOSFSInfoChange(&osFSInfo, FALSE);
	return ret;
}

NDIS_STATUS RTMPSetSingleSKUParametersExt(RTMP_ADAPTER *pAd
					, PSTRING file_path, BOOLEAN get_tbl_only, DL_LIST *tbl)
{
	PSTRING buffer = NULL;
	PSTRING readline, token;
	RTMP_OS_FD srcf;
	INT retval;
	PSTRING ptr;
	int index, i;
	CH_POWER *StartCh = NULL;
	UCHAR *temp;
	RTMP_OS_FS_INFO osFSInfo;
	INT bufferSize;
	NDIS_STATUS ret = NDIS_STATUS_FAILURE;
	DL_LIST *sku_tbl = NULL;
	INT filesize;

	if (!get_tbl_only)
		sku_tbl = &pAd->SingleSkuPwrList;
	else
		sku_tbl = tbl;

	if (!sku_tbl) {
		DBGPRINT(RT_DEBUG_ERROR, ("%s, sku source error\n", __func__));
		return NDIS_STATUS_RESOURCES;
	}

	DlListInit(sku_tbl);
	RtmpOSFSInfoChange(&osFSInfo, TRUE);
	pAd->bOpenFileSuccess = FALSE;

	/* open card information file */
	srcf = RtmpOSFileOpen(file_path, O_RDONLY, 0);
	if (IS_FILE_OPEN_ERR(srcf)) {
		/* card information file does not exist */
		DBGPRINT(RT_DEBUG_ERROR, ("%s open fail %s\n", __func__,
			 SINGLE_SKU_TABLE_FILE_NAME));
		goto open_fail;
	}

	bufferSize = srcf->f_dentry->d_inode->i_size;

	/* init */
	buffer = RtmpOsVmalloc(bufferSize + 1);
	if (buffer == NULL) {
		DBGPRINT(RT_DEBUG_ERROR, ("%s alloc %d fail\n", __func__,
			 bufferSize));
		ret = NDIS_STATUS_RESOURCES;
		goto alloc_fail;
	}

	DBGPRINT(RT_DEBUG_TRACE, ("%s, file being read is  : %s\n", __func__, file_path));
	/* card information file exists so reading the card information */
	NdisZeroMemory(buffer, bufferSize + 1);

	retval = RtmpOSFileRead(srcf, buffer, bufferSize);
	if (retval < 0) {
		/* read fail */
		DBGPRINT(RT_DEBUG_ERROR,
			 ("--> Read %s error %d\n", SINGLE_SKU_TABLE_FILE_NAME, -retval));
		goto read_fail;
	}

	buffer[bufferSize] = '\0';
	ptr = buffer;
	readline = buffer;
	filesize = bufferSize;

	for (index = 0; (filesize > 0) && readline
		&& ((ptr = strchr(readline, '\n')) != NULL); index++) {
		*ptr = '\0';
		filesize -= (ptr - readline + 1);
		DBGPRINT(RT_DEBUG_TRACE,
			("%s, At start ptr = %p rl = %p  filesize = %d\n"
			, __func__, ptr, readline, filesize));
		if (!(readline + 2)) {
			DBGPRINT(RT_DEBUG_ERROR, ("%s, readline+2 NULL\n", __func__));
			goto parse_fail;
		}

		if (!strncmp(readline, "ch", 2)) {
			CH_POWER *pwr = NULL;
			PSTRING pwr_int = NULL;
			PSTRING pwr_float = NULL;
			int err;
			long lval = 0;
			UCHAR channel;
			BOOLEAN isSame = TRUE;

			os_alloc_mem(NULL, (UCHAR **) &pwr, sizeof(*pwr));

			if (!pwr) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d !pwr\n",
					 __func__, __LINE__));
				goto parse_fail;
			}

			NdisZeroMemory(pwr, sizeof(*pwr));

			token = rstrtok(readline + 2, " ");
			if (!token) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d\n",
					 __func__, __LINE__));
				goto parse_fail;
			}

			err = os_strtol(token, 10, &lval);
			if (err) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, err));
				goto parse_fail;
			}

			channel = (UCHAR) lval;
			pwr->StartChannel = channel;

			if (pwr->StartChannel > 14)
				goto skip_cck_tbl;
			for (i = 0; i < SINGLE_SKU_TABLE_CCK_LENGTH; i++) {
				long lpwr_float = 0;

				token = rstrtok(NULL, " ");
				if (token == NULL)
					break;
				pwr_int = strsep((char **)&token, ".");
				pwr_float = strsep((char **)&token, ".");
				if (pwr_int)
					err = os_strtol(pwr_int, 10, &lval);
				if (pwr_float)
					err += os_strtol(pwr_float, 10, &lpwr_float);
				if (err) {
					DBGPRINT(RT_DEBUG_ERROR,
						("%s#%d err %d paring %s\n",
						__func__, __LINE__,
						 err, token));
					goto parse_fail;
				}
				pwr->PwrCCK[i] =
					(UCHAR)lval * 2 + ((lpwr_float > 4)?1:0);
			}
skip_cck_tbl:
			for (i = 0; i < SINGLE_SKU_TABLE_OFDM_LENGTH; i++) {
				long lpwr_float = 0;

				token = rstrtok(NULL, " ");
				if (token == NULL)
					break;
				pwr_int = strsep((char **)&token, ".");
				pwr_float = strsep((char **)&token, ".");
				if (pwr_int)
					err = os_strtol(pwr_int, 10, &lval);
				if (pwr_float)
					err += os_strtol(pwr_float, 10, &lpwr_float);
				if (err) {
						DBGPRINT(RT_DEBUG_ERROR,
							 ("%s#%d err %d paring %s\n", __func__,
							 __LINE__, err, token));
					goto parse_fail;
				}
					pwr->PwrOFDM[i] =
						(UCHAR)lval * 2 + ((lpwr_float > 4)?1:0);
			}
			for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
				long lpwr_float = 0;

				token = rstrtok(NULL, " ");
				if (token == NULL)
					break;
				pwr_int = strsep((char **)&token, ".");
				pwr_float = strsep((char **)&token, ".");
				if (pwr_int)
					err = os_strtol(pwr_int, 10, &lval);
				if (pwr_float)
					err += os_strtol(pwr_float, 10, &lpwr_float);
				if (err) {
					DBGPRINT(RT_DEBUG_ERROR,
						 ("%s#%d err %d\n", __func__,
						 __LINE__, err));
					goto parse_fail;
				}
				pwr->PwrHT20[i] = (UCHAR) lval * 2 + ((lpwr_float > 4) ? 1 : 0);
			}
			for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
				long lpwr_float = 0;

				token = rstrtok(NULL, " ");
				if (token == NULL)
					break;
				pwr_int = strsep((char **)&token, ".");
				pwr_float = strsep((char **)&token, ".");
				if (pwr_float)
					err = os_strtol(pwr_int, 10, &lval);
				if (pwr_float)
					err += os_strtol(pwr_float, 10, &lpwr_float);
				if (err) {
					DBGPRINT(RT_DEBUG_ERROR,
						 ("%s#%d err %d\n", __func__,
						 __LINE__, err));
					goto parse_fail;
				}
				pwr->PwrHT40[i] = (UCHAR) lval * 2 + ((lpwr_float > 4) ? 1 : 0);
			}

#ifdef DOT11_VHT_AC
			for (i = 0; i < SINGLE_SKU_TABLE_VHT_LENGTH; i++) {
				long lpwr_float = 0;

				token = rstrtok(NULL, " ");
				if (token == NULL)
					break;
				pwr_int = strsep((char **)&token, ".");
				pwr_float = strsep((char **)&token, ".");
				if (pwr_int)
					err = os_strtol(pwr_int, 10, &lval);
				if (pwr_float)
					err += os_strtol(pwr_float, 10, &lpwr_float);
				if (err) {
					DBGPRINT(RT_DEBUG_ERROR,
						 ("%s#%d err %d\n", __func__,
						 __LINE__, err));
					goto parse_fail;
				}
				pwr->PwrVHT80[i] = (UCHAR) lval * 2 + ((lpwr_float > 4) ? 1 : 0);
			}
#endif /* DOT11_VHT_AC */
			if (StartCh == NULL) {
				StartCh = pwr;
				DlListAddTail(sku_tbl, &pwr->List);
				goto START_CH_NULL;
			}
			isSame = TRUE;

			for (i = 0; i < SINGLE_SKU_TABLE_CCK_LENGTH; i++) {
				if (StartCh->PwrCCK[i] != pwr->PwrCCK[i]) {
					isSame = FALSE;
					break;
				}
			}
			if (isSame == TRUE) {
				for (i = 0; i < SINGLE_SKU_TABLE_OFDM_LENGTH; i++) {
					if (StartCh->PwrOFDM[i] != pwr->PwrOFDM[i]) {
						isSame = FALSE;
						break;
					}
				}
			}
			if (isSame == TRUE) {
				for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
					if (StartCh->PwrHT20[i] != pwr->PwrHT20[i]) {
						isSame = FALSE;
						break;
					}
				}
			}
			if (isSame == TRUE) {
				for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
					if (StartCh->PwrHT40[i] != pwr->PwrHT40[i]) {
						isSame = FALSE;
						break;
					}
				}
			}
#ifdef DOT11_VHT_AC
			if (isSame == TRUE) {
				for (i = 0; i < SINGLE_SKU_TABLE_VHT_LENGTH; i++) {
					if (StartCh->PwrVHT80[i] != pwr->PwrVHT80[i]) {
						isSame = FALSE;
						break;
					}
				}
			}
#endif /* DOT11_VHT_AC */
			if (isSame == TRUE) {
				os_free_mem(NULL, pwr);
			} else {
				StartCh = pwr;
				DlListAddTail(sku_tbl, &StartCh->List);
				pwr = NULL;
			}
START_CH_NULL:
			StartCh->num++;
			os_alloc_mem(pAd, (PUCHAR *) &temp, StartCh->num);
			if (StartCh->Channel != NULL) {
				NdisMoveMemory(temp, StartCh->Channel, StartCh->num - 1);
				os_free_mem(pAd, StartCh->Channel);
			}
			StartCh->Channel = temp;
			StartCh->Channel[StartCh->num - 1] = channel;
		}
		readline = ptr + 1;

		DBGPRINT(RT_DEBUG_TRACE,
			 ("%s:%d at End ptr = %p rl = %p and filesize = %d\n", __func__,
			  index, ptr, readline, filesize));
		if ((filesize > 0) && (readline[0] == '#'))
			continue;

	}

	/* ret = RTMPPrintSKUParams(pAd, sku_tbl); */
	pAd->bOpenFileSuccess = TRUE;
	ret = NDIS_STATUS_SUCCESS;

parse_fail:
read_fail:
	if (buffer)
		RtmpOsVfree(buffer);

alloc_fail:
	retval = RtmpOSFileClose(srcf);

open_fail:
	RtmpOSFSInfoChange(&osFSInfo, FALSE);

	return ret;
}
#else /* ifndef JUNGLE_SUPPORT */
NDIS_STATUS RTMPSetSingleSKUParameters(RTMP_ADAPTER *pAd)
{
	PSTRING buffer = NULL;
	PSTRING readline, token;
	RTMP_OS_FD srcf;
	INT retval;
	PSTRING ptr;
	int index, i;
	CH_POWER *StartCh = NULL;
	UCHAR *temp;
	RTMP_OS_FS_INFO osFSInfo;
	INT bufferSize;
	CH_POWER *ch, *ch_temp;
	NDIS_STATUS ret = NDIS_STATUS_FAILURE;

	DlListInit(&pAd->SingleSkuPwrList);
	RtmpOSFSInfoChange(&osFSInfo, TRUE);
	pAd->bOpenFileSuccess = FALSE;

	/* open card information file */
	srcf = RtmpOSFileOpen(SINGLE_SKU_TABLE_FILE_NAME, O_RDONLY, 0);
	if (IS_FILE_OPEN_ERR(srcf)) {
		/* card information file does not exist */
		DBGPRINT(RT_DEBUG_ERROR, ("%s open fail %s\n", __func__,
			 SINGLE_SKU_TABLE_FILE_NAME));
		goto open_fail;
	}

	bufferSize = srcf->f_dentry->d_inode->i_size;
	DBGPRINT(RT_DEBUG_TRACE, ("%s bufferSize %d\n", __func__, bufferSize));

	/* init */
	buffer = RtmpOsVmalloc(bufferSize + 1);
	if (buffer == NULL) {
		DBGPRINT(RT_DEBUG_ERROR, ("%s alloc %d fail\n", __func__,
			 bufferSize));
		ret = NDIS_STATUS_RESOURCES;
		goto alloc_fail;
	}
#ifdef RTMP_INTERNAL_TX_ALC
	if (pAd->TxPowerCtrl.bInternalTxALC != TRUE)
#endif /* RTMP_INTERNAL_TX_ALC */
		{
		}

	/* card information file exists so reading the card information */
	NdisZeroMemory(buffer, bufferSize + 1);

	retval = RtmpOSFileRead(srcf, buffer, bufferSize);
	if (retval < 0) {
		/* read fail */
		DBGPRINT(RT_DEBUG_ERROR,
			 ("--> Read %s error %d\n", SINGLE_SKU_TABLE_FILE_NAME,
			 -retval));
		goto read_fail;
	}

	buffer[bufferSize] = '\0';
	for (readline = ptr = buffer, index = 0;
	     (ptr = strchr(readline, '\n')) != NULL;
	     readline = ptr + 1, index++) {
		*ptr = '\0';

		if (readline[0] == '#')
			continue;

		if (!strncmp(readline, "ch", 2)) {
			CH_POWER *pwr = NULL;
			int err;
			long lval = 0;
			UCHAR channel;

			os_alloc_mem(NULL, (UCHAR **) &pwr, sizeof(*pwr));
			NdisZeroMemory(pwr, sizeof(*pwr));

			token = rstrtok(readline + 2, " ");
			err = os_strtol(token, 10, &lval);
			if (err) {
				DBGPRINT(RT_DEBUG_ERROR, ("%s#%d err %d\n",
					 __func__, __LINE__, err));
				goto parse_fail;
			}
			channel = (UCHAR) lval;
			pwr->StartChannel = channel;

			if (pwr->StartChannel <= 14) {
				for (i = 0; i < SINGLE_SKU_TABLE_CCK_LENGTH; i++) {
					token = rstrtok(NULL, " ");
					if (token == NULL)
						break;
					err = os_strtol(token, 10, &lval);
					if (err) {
						DBGPRINT(RT_DEBUG_ERROR,
							 ("%s#%d err %d\n",
							  __func__, __LINE__,
							  err));
						goto parse_fail;
					}
					pwr->PwrCCK[i] = (UCHAR) lval * 2;
				}
			}

			for (i = 0; i < SINGLE_SKU_TABLE_OFDM_LENGTH; i++) {
				token = rstrtok(NULL, " ");
				if (token == NULL)
					break;
				err = os_strtol(token, 10, &lval);
				if (err) {
					DBGPRINT(RT_DEBUG_ERROR,
						 ("%s#%d err %d\n", __func__,
						 __LINE__, err));
					goto parse_fail;
				}
				pwr->PwrOFDM[i] = (UCHAR) lval * 2;
			}

			for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
				token = rstrtok(NULL, " ");
				if (token == NULL)
					break;
				err = os_strtol(token, 10, &lval);
				if (err) {
					DBGPRINT(RT_DEBUG_ERROR,
						 ("%s#%d err %d\n", __func__,
						 __LINE__, err));
					goto parse_fail;
				}
				pwr->PwrHT20[i] = (UCHAR)lval * 2;
			}

			for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
				token = rstrtok(NULL, " ");
				if (token == NULL)
					break;
				err = os_strtol(token, 10, &lval);
				if (err) {
					DBGPRINT(RT_DEBUG_ERROR,
						 ("%s#%d err %d\n", __func__,
						 __LINE__, err));
					goto parse_fail;
				}
				pwr->PwrHT40[i] = (UCHAR) lval * 2;
			}

#ifdef DOT11_VHT_AC
			for (i = 0; i < SINGLE_SKU_TABLE_VHT_LENGTH; i++) {
				token = rstrtok(NULL, " ");
				if (token == NULL)
					break;
				err = os_strtol(token, 10, &lval);
				if (err) {
					DBGPRINT(RT_DEBUG_ERROR,
						 ("%s#%d err %d\n", __func__,
						 __LINE__, err));
					goto parse_fail;
				}
				pwr->PwrVHT80[i] = (UCHAR) lval * 2;
			}
#endif /* DOT11_VHT_AC */

			if (StartCh == NULL) {
				StartCh = pwr;
				DlListAddTail(&pAd->SingleSkuPwrList, &pwr->List);
			} else {
				/* compare all contents with the previous one,
				 * and consolidate with it if all are the same.
				 */
				BOOLEAN isSame = TRUE;

				for (i = 0; i < SINGLE_SKU_TABLE_CCK_LENGTH; i++) {
					if (StartCh->PwrCCK[i] != pwr->PwrCCK[i]) {
						isSame = FALSE;
						break;
					}
				}

				if (isSame == TRUE) {
					for (i = 0; i < SINGLE_SKU_TABLE_OFDM_LENGTH; i++) {
						if (StartCh->PwrOFDM[i] != pwr->PwrOFDM[i]) {
							isSame = FALSE;
							break;
						}
					}
				}

				if (isSame == TRUE) {
					for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
						if (StartCh->PwrHT20[i] != pwr->PwrHT20[i]) {
							isSame = FALSE;
							break;
						}
					}
				}

				if (isSame == TRUE) {
					for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
						if (StartCh->PwrHT40[i] != pwr->PwrHT40[i]) {
							isSame = FALSE;
							break;
						}
					}
				}
#ifdef DOT11_VHT_AC
				if (isSame == TRUE) {
					for (i = 0; i < SINGLE_SKU_TABLE_VHT_LENGTH; i++) {
						if (StartCh->PwrVHT80[i] != pwr->PwrVHT80[i]) {
							isSame = FALSE;
							break;
						}
					}
				}
#endif /* DOT11_VHT_AC */

				if (isSame == TRUE) {
					os_free_mem(NULL, pwr);
				} else {
					StartCh = pwr;
					DlListAddTail(&pAd->SingleSkuPwrList,
						      &StartCh->List);
					pwr = NULL;
				}
			}

			StartCh->num++;
			os_alloc_mem(pAd, (PUCHAR *) &temp, StartCh->num);
			if (StartCh->Channel != NULL) {
				/* update consolidated channel list */
				NdisMoveMemory(temp, StartCh->Channel,
					       StartCh->num - 1);
				os_free_mem(pAd, StartCh->Channel);
			}

			StartCh->Channel = temp;
			StartCh->Channel[StartCh->num - 1] = channel;
		}
	}

	DlListForEachSafe(ch, ch_temp, &pAd->SingleSkuPwrList, CH_POWER, List) {
		int i;

		DBGPRINT(RT_DEBUG_TRACE, ("start ch = %d, ch->num = %d\n",
			 ch->StartChannel, ch->num));

		DBGPRINT(RT_DEBUG_TRACE, ("Channel: "));
		for (i = 0; i < ch->num; i++)
			DBGPRINT(RT_DEBUG_TRACE, ("%d ", ch->Channel[i]));
		DBGPRINT(RT_DEBUG_TRACE, ("\n"));

		DBGPRINT(RT_DEBUG_TRACE, ("CCK: "));
		for (i = 0; i < SINGLE_SKU_TABLE_CCK_LENGTH; i++)
			DBGPRINT(RT_DEBUG_TRACE, ("%d ", ch->PwrCCK[i]));
		DBGPRINT(RT_DEBUG_TRACE, ("\n"));

		DBGPRINT(RT_DEBUG_TRACE, ("OFDM: "));
		for (i = 0; i < SINGLE_SKU_TABLE_OFDM_LENGTH; i++)
			DBGPRINT(RT_DEBUG_TRACE, ("%d ", ch->PwrOFDM[i]));
		DBGPRINT(RT_DEBUG_TRACE, ("\n"));

		DBGPRINT(RT_DEBUG_TRACE, ("HT20: "));
		for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++)
			DBGPRINT(RT_DEBUG_TRACE, ("%d ", ch->PwrHT20[i]));
		DBGPRINT(RT_DEBUG_TRACE, ("\n"));

		DBGPRINT(RT_DEBUG_TRACE, ("HT40: "));
		for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++)
			DBGPRINT(RT_DEBUG_TRACE, ("%d ", ch->PwrHT40[i]));
		DBGPRINT(RT_DEBUG_TRACE, ("\n"));

		DBGPRINT(RT_DEBUG_TRACE, ("VHT80: "));
		for (i = 0; i < SINGLE_SKU_TABLE_VHT_LENGTH; i++)
			DBGPRINT(RT_DEBUG_TRACE, ("%d ", ch->PwrVHT80[i]));
		DBGPRINT(RT_DEBUG_TRACE, ("\n"));
	}

	pAd->bOpenFileSuccess = TRUE;
	ret = NDIS_STATUS_SUCCESS;

parse_fail:
read_fail:
	if (buffer)
		RtmpOsVfree(buffer);

alloc_fail:
	retval = RtmpOSFileClose(srcf);

open_fail:
	RtmpOSFSInfoChange(&osFSInfo, FALSE);

	return ret;
}
#endif /* JUNGLE_SUPPORT */
#ifdef CUSTOMIZE_SINGLE_SKU_V2
NDIS_STATUS RTMPSetSingleSKUParametersCustomer(IN RTMP_ADAPTER *pAd)
{
	PSTRING buffer;
	PSTRING readline, token;
	RTMP_OS_FD srcf;
	INT retval;
	PSTRING ptr;
	int index, i;
	CH_POWER *StartCh = NULL;
	UCHAR channel, *temp;
	RTMP_OS_FS_INFO osFSInfo;
	INT bufferSize = 0;
	INT ret;
	ULONG longtmp;

#ifdef DYNAMIC_PWR_TABLE_MAPPED_BY_COUNTRY_REGION
	CHAR singlesku_path[256];
#endif /* DYNAMIC_PWR_TABLE_MAPPED_BY_COUNTRY_REGION */
	DlListInit(&pAd->SingleSkuPwrList);

	RtmpOSFSInfoChange(&osFSInfo, TRUE);

#ifdef DYNAMIC_PWR_TABLE_MAPPED_BY_COUNTRY_REGION
	if (RTMP_GetSingleSkuPathByCountryRegion(pAd, singlesku_path, sizeof(singlesku_path)) < 0) {
		memset(singlesku_path, 0, sizeof(singlesku_path));
		strncpy(singlesku_path, SINGLE_SKU_TABLE_FILE_NAME,
			strlen(SINGLE_SKU_TABLE_FILE_NAME));
		DBGPRINT(RT_DEBUG_TRACE,
			 ("%s: Could not find dynamic pwr table, use default one=[%s]\n",
			  __func__, singlesku_path));
	} else
		DBGPRINT(RT_DEBUG_TRACE,
			 ("%s: Found dynamic pwr table=[%s]\n", __func__, singlesku_path));

	srcf = RtmpOSFileOpen(singlesku_path, O_RDONLY, 0);
	/* open card information file */
	if (IS_FILE_OPEN_ERR(srcf)) {
		/* card information file does not exist */
		if (strcmp(singlesku_path, SINGLE_SKU_TABLE_FILE_NAME) != 0) {
			/* If dynamic pwr table does not exist, we fallback to use default one */
			DBGPRINT(RT_DEBUG_ERROR,
				 ("Failed to open dynamic pwr table[%s], fallback to default one\n",
				  singlesku_path));
			memset(singlesku_path, 0, sizeof(singlesku_path));
			strncpy(singlesku_path, SINGLE_SKU_TABLE_FILE_NAME,
				strlen(SINGLE_SKU_TABLE_FILE_NAME));
			srcf = RtmpOSFileOpen(singlesku_path, O_RDONLY, 0);
			if (!IS_FILE_OPEN_ERR(srcf)) {
				DBGPRINT(RT_DEBUG_TRACE, ("Fallback to default table Success!\n"));
			} else {
				DBGPRINT(RT_DEBUG_TRACE, ("Fallback to default table failed!\n"));
				goto free_resource;
			}
		} else {
			/* If default one was failed, exit */
			DBGPRINT(RT_DEBUG_ERROR, ("--> Error opening [%s]\n", singlesku_path));
			goto free_resource;
		}
	}
	DBGPRINT(RT_DEBUG_TRACE, ("Open pwr table success [%s]\n", singlesku_path));
	strncpy(pAd->CommonCfg.singleskuPath, singlesku_path, sizeof(pAd->CommonCfg.singleskuPath));
#else /* !DYNAMIC_PWR_TABLE_MAPPED_BY_COUNTRY_REGION */
	srcf = RtmpOSFileOpen(SINGLE_SKU_TABLE_FILE_NAME, O_RDONLY, 0);

	/* open card information file */
	if (IS_FILE_OPEN_ERR(srcf)) {
		/* card information file does not exist */
		DBGPRINT(RT_DEBUG_TRACE, ("--> Error opening %s\n", SINGLE_SKU_TABLE_FILE_NAME));
		goto free_resource;
	}
#endif /* DYNAMIC_PWR_TABLE_MAPPED_BY_COUNTRY_REGION */

	bufferSize = srcf->f_dentry->d_inode->i_size;
	DBGPRINT(RT_DEBUG_TRACE, ("(%s)bufferSize= %d\n", __func__, bufferSize));

	/* init */
	os_alloc_mem(NULL, (UCHAR **) &buffer, bufferSize);
	if (buffer == NULL)
		return FALSE;

#ifdef RTMP_INTERNAL_TX_ALC
	if (pAd->TxPowerCtrl.bInternalTxALC != TRUE)
#endif /* RTMP_INTERNAL_TX_ALC */
		{
		}

	/* card information file exists so reading the card information */
	NdisZeroMemory(buffer, bufferSize);
	retval = RtmpOSFileRead(srcf, buffer, bufferSize);
	if (retval < 0) {
		/* read fail */
		DBGPRINT(RT_DEBUG_TRACE,
			 ("--> Read %s error %d\n", SINGLE_SKU_TABLE_FILE_NAME, -retval));
	} else {
		for (readline = ptr = buffer, index = 0; (ptr = strchr(readline, '\n')) != NULL;
		     readline = ptr + 1, index++) {
			*ptr = '\0';

			if (readline[0] == '#')
				continue;

			if (!strncmp(readline, "ch", 2)) {

				CH_POWER *pwr = NULL;

				os_alloc_mem(NULL, (UCHAR **) &pwr, sizeof(*pwr));
				NdisZeroMemory(pwr, sizeof(*pwr));

				token = rstrtok(readline + 2, " ");

				ret = os_strtol(token, 10, &longtmp);
				if (ret < 0)
					return FALSE;

				channel = longtmp;
				pwr->StartChannel = channel;

				if (pwr->StartChannel <= 14) {
					/* CCK 1 ~ 11 */
					for (i = 0; i < SINGLE_SKU_TABLE_CCK_LENGTH; i++) {
						token = rstrtok(NULL, " ");
						if (token == NULL)
							break;
						ret = os_strtol(token, 10, &longtmp);
						if (ret < 0)
							return FALSE;

						pwr->PwrCCK[i] = longtmp * 2;

					}
				}
				/* OFDM 6 ~ 54 */
				for (i = 0; i < SINGLE_SKU_TABLE_OFDM_LENGTH; i++) {
					token = rstrtok(NULL, " ");
					if (token == NULL)
						break;

					ret = os_strtol(token, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					pwr->PwrOFDM[i] = longtmp * 2;
				}
				/* HT20 MCS 0 ~ 15 */
				for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
					token = rstrtok(NULL, " ");
					if (token == NULL)
						break;

					ret = os_strtol(token, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					pwr->PwrHT20[i] = longtmp * 2;
				}
				/* HT40 MCS 0 ~ 15 */
				for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
					token = rstrtok(NULL, " ");
					if (token == NULL)
						break;

					ret = os_strtol(token, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					pwr->PwrHT40[i] = longtmp * 2;
				}
#ifdef DOT11_VHT_AC
				/* [5G]VHT80 MCS 0 ~ 9 */
				if (pwr->StartChannel > 14) {
					for (i = 0; i < SINGLE_SKU_TABLE_VHT_LENGTH; i++) {
						token = rstrtok(NULL, " ");
						if (token == NULL)
							break;

						ret = os_strtol(token, 10, &longtmp);
						if (ret < 0)
							return FALSE;

						pwr->PwrVHT80[i] = longtmp * 2;
					}
				}
				/* [2G]VHT40 MCS 0 ~ 9 */
				else if (pwr->StartChannel <= 14) {
					for (i = 0; i < SINGLE_SKU_TABLE_VHT_LENGTH; i++) {
						token = rstrtok(NULL, " ");
						if (token == NULL)
							break;

						ret = os_strtol(token, 10, &longtmp);
						if (ret < 0)
							return FALSE;

						pwr->PwrVHT40All[i] = longtmp * 2;
					}
				}
#endif /* DOT11_VHT_AC */
				/* VHT20 MCS 8 */
				for (i = 0; i < SINGLE_SKU_TABLE_VHT20_LENGTH; i++) {
					token = rstrtok(NULL, " ");
					if (token == NULL)
						break;

					ret = os_strtol(token, 10, &longtmp);
					if (ret < 0)
						return FALSE;

					pwr->PwrVHT20[i] = longtmp * 2;
				}
				/* VHT40 MCS 8,9 */
				/* In SingleSKU_MT7662_20140129.dat, only 5G has VHT40 MCS 8,9 */
				if (pwr->StartChannel > 14) {
					for (i = 0; i < SINGLE_SKU_TABLE_VHT40_LENGTH; i++) {
						token = rstrtok(NULL, " ");
						if (token == NULL)
							break;

						ret = os_strtol(token, 10, &longtmp);
						if (ret < 0)
							return FALSE;

						pwr->PwrVHT40[i] = longtmp * 2;
					}
				}

				if (StartCh == NULL) {
					StartCh = pwr;
					DlListAddTail(&pAd->SingleSkuPwrList, &pwr->List);
				} else {
					BOOLEAN isSame = TRUE;

					if (pwr->StartChannel <= 14) {
						/* CCK 1 ~ 11 */
						for (i = 0; i < SINGLE_SKU_TABLE_CCK_LENGTH; i++) {
							if (StartCh->PwrCCK[i] != pwr->PwrCCK[i]) {
								isSame = FALSE;
								break;
							}
						}
					}

					if (isSame == TRUE) {
						/* OFDM 6 ~ 54 */
						for (i = 0; i < SINGLE_SKU_TABLE_OFDM_LENGTH; i++) {
							if (StartCh->PwrOFDM[i] != pwr->PwrOFDM[i]) {
								isSame = FALSE;
								break;
							}
						}
					}

					if (isSame == TRUE) {
						/* HT20 MCS 0 ~ 15 */
						for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
							if (StartCh->PwrHT20[i] != pwr->PwrHT20[i]) {
								isSame = FALSE;
								break;
							}
						}
					}

					if (isSame == TRUE) {
						/* HT40 MCS 0 ~ 15 */
						for (i = 0; i < SINGLE_SKU_TABLE_HT_LENGTH; i++) {
							if (StartCh->PwrHT40[i] != pwr->PwrHT40[i]) {
								isSame = FALSE;
								break;
							}
						}
					}

					if (isSame == TRUE) {
						/* VHT80 MCS 0 ~ 9 */
						for (i = 0; i < SINGLE_SKU_TABLE_VHT_LENGTH; i++) {
							if (StartCh->PwrVHT80[i] !=
							    pwr->PwrVHT80[i]) {
								isSame = FALSE;
								break;
							}
						}
					}

					if (isSame == TRUE) {
						/* VHT20 MCS 8 */
						for (i = 0; i < SINGLE_SKU_TABLE_VHT20_LENGTH; i++) {
							if (StartCh->PwrVHT20[i] !=
							    pwr->PwrVHT20[i]) {
								isSame = FALSE;
								break;
							}
						}
					}

					if (isSame == TRUE) {
						/* VHT40 MCS 8,9 */
						for (i = 0; i < SINGLE_SKU_TABLE_VHT40_LENGTH; i++) {
							if (StartCh->PwrVHT40[i] !=
							    pwr->PwrVHT40[i]) {
								isSame = FALSE;
								break;
							}
						}
					}

					if (isSame == TRUE) {
						os_free_mem(NULL, pwr);
					} else {
						StartCh = pwr;
						DlListAddTail(&pAd->SingleSkuPwrList,
							      &StartCh->List);
						pwr = NULL;
					}

				}
				StartCh->num++;
				os_alloc_mem(pAd, (PUCHAR *) &temp, StartCh->num);
				if (StartCh->Channel != NULL) {
					NdisMoveMemory(temp, StartCh->Channel, StartCh->num - 1);
					os_free_mem(pAd, StartCh->Channel);
				}
				StartCh->Channel = temp;
				StartCh->Channel[StartCh->num - 1] = channel;
			}
		}
	}

	/* close file */
	retval = RtmpOSFileClose(srcf);

free_resource:
	RtmpOSFSInfoChange(&osFSInfo, FALSE);

	os_free_mem(NULL, buffer);
	return TRUE;
}
#endif /* CUSTOMIZE_SINGLE_SKU_V2 */

#endif /* SINGLE_SKU_V2 */

UINT32 RalinkRate_Legacy[] = { 2, 4, 11, 22, 12, 18, 24, 36, 48, 72, 96, 108 };

UINT32 RalinkRate_HT_1NSS[Rate_BW_MAX][Rate_GI_MAX][Rate_MCS] = {
	{
	 {13, 26, 39, 52, 78, 104, 117, 130, 0, 0}
	 , {14, 29, 43, 57, 87, 115, 130, 144, 0, 0}	/*20MHz, 800ns & 400 ns GI, MCS0~9 */
	 }
	,
	{
	 {27, 54, 81, 108, 162, 216, 243, 270, 0, 0}
	 , {30, 60, 90, 120, 180, 240, 270, 300, 0, 0}	/*40MHz, 800ns & 400 ns GI, MCS0~9 */
	 }
	,
	{
	 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	 , {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}	/*80MHz, 800ns & 400 ns GI, MCS0~9 */
	 }
	,
};

UINT32 RalinkRate_VHT_1NSS[Rate_BW_MAX][Rate_GI_MAX][Rate_MCS] = {
	{
	 {13, 26, 39, 52, 78, 104, 117, 130, 156, 0}
	 , {14, 29, 43, 57, 87, 115, 130, 144, 173, 0}	/*20MHz, 800ns & 400 ns GI, MCS0~9 */
	 }
	,
	{
	 {27, 54, 81, 108, 162, 216, 243, 270, 324, 360}
	 , {30, 60, 90, 120, 180, 240, 270, 300, 360, 400}	/*40MHz, 800ns & 400 ns GI, MCS0~9 */
	 }
	,
	{
	 {59, 117, 176, 234, 351, 468, 527, 585, 702, 780}
	 , {65, 130, 195, 260, 390, 520, 585, 650, 780, 867}	/*80MHz, 800ns & 400 ns GI, MCS0~9 */
	 }
	,
};

UINT8 newRateGetAntenna(UINT8 MCS)
{
	return ((MCS >> 4) + 1);
}

/*
void print_RalinkRate_HT(void)
{
	UINT32 i,j,k;

	for(i=0;i < Rate_BW_MAX;i++)
	{
		DBGPRINT(RT_DEBUG_TRACE, ("======= BW : %d ============\n", i));
		for(j=0;j < Rate_GI_MAX;j++)
		{
			DBGPRINT(RT_DEBUG_TRACE, ("======= GI : %d ============\nMCS: ", j));
			for(k=0;k < Rate_MCS;k++)
			{
				DBGPRINT(RT_DEBUG_TRACE, ("%d, ", RalinkRate_HT_1NSS[i][j][k]));
			}
			DBGPRINT(RT_DEBUG_TRACE, ("\n======= END GI : %d ============\n", j));
		}
		DBGPRINT(RT_DEBUG_TRACE, ("======= END BW : %d ============\n", i));
	}

	for(i=0;i < Rate_BW_MAX;i++)
	{
		DBGPRINT(RT_DEBUG_TRACE, ("======= BW : %d ============\n", i));
		for(j=0;j < Rate_GI_MAX;j++)
		{
			DBGPRINT(RT_DEBUG_TRACE, ("======= GI : %d ============\nMCS: ", j));
			for(k=0;k < Rate_MCS;k++)
			{
				DBGPRINT(RT_DEBUG_TRACE, ("%d, ", RalinkRate_VHT_1NSS[i][j][k]));
			}
			DBGPRINT(RT_DEBUG_TRACE, ("\n======= END GI : %d ============\n", j));
		}
		DBGPRINT(RT_DEBUG_TRACE, ("======= END BW : %d ============\n", i));
	}
}
*/
