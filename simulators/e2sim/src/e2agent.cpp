/*****************************************************************************
#                                                                            *
# Copyright 2019 AT&T Intellectual Property                                  *
# Copyright 2019 Nokia                                                       *
#                                                                            *
# Licensed under the Apache License, Version 2.0 (the "License");            *
# you may not use this file except in compliance with the License.           *
# You may obtain a copy of the License at                                    *
#                                                                            *
#      http://www.apache.org/licenses/LICENSE-2.0                            *
#                                                                            *
# Unless required by applicable law or agreed to in writing, software        *
# distributed under the License is distributed on an "AS IS" BASIS,          *
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   *
# See the License for the specific language governing permissions and        *
# limitations under the License.                                             *
#                                                                            *
******************************************************************************/

#include <stdio.h>
#include <unistd.h>
#include <string>
#include <iostream>

#include "e2sim_defs.h"
#include "e2sim_sctp.hpp"
#include "asn_e2ap.hpp"
#include "e2ap_message_handler.hpp"

using namespace std;

void test(void)
{
  e2ap_pdu_t* pdu = new_e2ap_pdu();

  gNB_config gnb_cfg;

  e2ap_create_ENDCX2SetupResponse(pdu, gnb_cfg);

  e2ap_print_pdu(pdu);

  //Encode into buffer
  sctp_buffer_t data;
  e2ap_encode_pdu(pdu, data.buffer, sizeof(data.buffer), data.len);

}

int main(int argc, char* argv[]){

  LOG_I("E2 Agent (E2 Simulator) Version %s", VERSION);

  // test();
  // return 0;

  options_t ops = read_input_options(argc, argv);

  int server_fd = sctp_start_server(ops.server_ip, ops.server_port);
  int client_fd = sctp_accept_connection(ops.server_ip, server_fd);

  sctp_buffer_t recv_buf;

  LOG_I("[SCTP] Waiting for SCTP data");
  while(1) //constantly looking for data on SCTP interface
  {
    if(sctp_receive_data(client_fd, recv_buf) <= 0)
      break;

    LOG_I("[SCTP] Received new data of size %d", recv_buf.len);

    e2ap_handle_sctp_data(client_fd, recv_buf);
  }

  return 0;
}
