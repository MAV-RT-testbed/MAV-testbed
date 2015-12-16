/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* XILINX CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

#include <stdio.h>
#include <string.h>

#include "lwip/err.h"
#include "lwip/udp.h"
#include "lwip/ip_addr.h"
#include "netif/xadapter.h"
#ifdef __arm__
#include "xil_printf.h"
#endif
#include "sleep.h"
#include "rcs_netconfig.h"

int transfer_data() {
	return 0;
}

void print_app_header()
{
	xil_printf("\n\r\n\r-----lwIP UDP echo server ------\n\r");
	xil_printf("UDP packets sent to port 6001 will be echoed back\n\r");
}


void callback_udp_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p, struct ip_addr *addr, u16_t port){
	xil_printf("incoming packet\n\r");
    if (p != NULL) {
#if 0
            udp_sendto(pcb, p, IP_ADDR_BROADCAST, UDP_REMOTE_PORT); //dest port
            pbuf_free(p);
#else
            pbuf_free(p);
#endif
    }
}

int start_application(struct netif *echo_netif)
{
	struct udp_pcb *ptel_pcb;
	struct pbuf *p;
	err_t err;
	unsigned int k;
	char msg[]="testing\r\n";
	struct ip_addr destAddr;

	IP4_ADDR(&destAddr, UDP_REMOTE_IPADDR_OCT1,
						UDP_REMOTE_IPADDR_OCT2,
						UDP_REMOTE_IPADDR_OCT3,
						UDP_REMOTE_IPADDR_OCT4);

	ptel_pcb = udp_new();
	if (!ptel_pcb) {
		xil_printf("Error creating PCB. Out of Memory\n\r");
		return -1;
	}
	err = udp_bind(ptel_pcb, IP_ADDR_ANY, UDP_LISTEN_PORT);
	if (err != ERR_OK) {
		xil_printf("Unable to bind to port %d: err = %d\n\r", UDP_LISTEN_PORT, err);
		return -2;
	}

	udp_recv(ptel_pcb, callback_udp_recv, NULL); // set rx callback

	xil_printf("UDP echo server started @ port %d\n\r", UDP_LISTEN_PORT);
	//Allocate packet buffer
	for (k=0; k<10; k++) {
		xemacif_input(echo_netif);
		// alloc (must be done every time)
		p = pbuf_alloc(PBUF_TRANSPORT,sizeof(msg),PBUF_RAM);
		memcpy (p->payload, msg, sizeof(msg));
		err = udp_sendto(ptel_pcb, p, &destAddr, UDP_REMOTE_PORT); // actual send
		pbuf_free(p);  // dealloc..every time
		if (err) {
			xil_printf("Unable to send: err = %d\n\r", err);
		}
		//transfer_data(); // useless...empty function
		usleep(100000);
	}
	udp_disconnect(ptel_pcb);
	xil_printf("application exit\n\r");
	return 0;
}