# RISC-V-32-bit-CPU
5 stage pipelined and all hazards handled RISC-V 32 bit CPU design. CPI = 2 for Branch and Jump instructions.
Design has been tested with the following algorithm:

![image](https://user-images.githubusercontent.com/42515502/140646533-6a4e9c9c-d0ec-4ea8-b410-934e5de4c711.png)


For A(r3) = 11, B(r4) = 8, N = 14(r2)
Expected result C ( r1 ) = 11 x 8 = 88 mod ( 14 ) = 18

Simulation result:
![image](https://user-images.githubusercontent.com/42515502/140646607-a543c5a2-eb33-407f-838a-531bb182270a.png)


