# ======================================================================
#         Copyright (c) 2019 Nokia
#         Copyright (c) 2018-2019 AT&T Intellectual Property.

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
#    implied. See the License for the specific language governing 
#    permissions andlimitations under the License.
# ======================================================================

set RMR_SEED_RT=./test.rt
unset RMR_RTG_SVC
printf "start receiver\n"
./ric_receiver &
printf "start generator\n"
printf "sending msgs\n"  
./ric_generator 100
printf "\nback2back test done!\n"
pkill -f ric_receiver
head -n 1 report/xAPP_counters.csv
