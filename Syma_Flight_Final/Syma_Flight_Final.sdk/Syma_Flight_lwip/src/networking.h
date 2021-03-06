/*
 * networking.h
 *
 *  Created on: Nov 23, 2015
 *      Author: asoehn
 */

#ifndef NETWORKING_H_
#define NETWORKING_H_

#include "lwip/netif.h"

struct netif * setup_network(void);
void print_ip_settings(struct ip_addr *ip, struct ip_addr *mask, struct ip_addr *gw);
void print_ip(char *msg, struct ip_addr *ip);
int networking_test(struct netif *echo_netif);

#endif /* NETWORKING_H_ */
