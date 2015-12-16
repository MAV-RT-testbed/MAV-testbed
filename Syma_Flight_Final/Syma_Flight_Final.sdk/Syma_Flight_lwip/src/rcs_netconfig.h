/**
 * @brief network configuration of the uZed 1 z7010 at TUM RCS
 */

#ifndef RCS_NETCONFIG_H
#define RCS_NETCONFIG_H

/*******************
 *  THIS DEVICE
 *******************/
// host=mart-i-z7010, mac=00:0a:35:00:01:22, ip=129.187.151.128
#define RCS_ZEDBOARD_MACADDR { 0x00, 0x0a, 0x35, 0x00, 0x01, 0x22 }
#define RCS_ZEDBOARD_IPADDR_OCT1 129
#define RCS_ZEDBOARD_IPADDR_OCT2 187
#define RCS_ZEDBOARD_IPADDR_OCT3 151
#define RCS_ZEDBOARD_IPADDR_OCT4 128
#define UDP_LISTEN_PORT 6001

/*******************
 *  REMOTE
 *******************/
// rcswrka30
#define UDP_REMOTE_IPADDR_OCT1 129
#define UDP_REMOTE_IPADDR_OCT2 187
#define UDP_REMOTE_IPADDR_OCT3 151
#define UDP_REMOTE_IPADDR_OCT4 142
#define UDP_REMOTE_PORT 6000

#endif
