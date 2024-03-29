# RISC-V-32-bit-CPU
5 stage pipelined and all hazards handled RISC-V 32 bit CPU design. CPI = 2 for Branch and Jump instructions.
Design has been tested with the following algorithm:

![image](https://user-images.githubusercontent.com/42515502/140646533-6a4e9c9c-d0ec-4ea8-b410-934e5de4c711.png)

Assembly code for the algorithm is given the */mem* folder. 

# Simulation
For A(r3) = 11, B(r4) = 8, N = 14(r2)
Expected result C ( r1 ) = 11 x 8 = 88 mod ( 14 ) = 18

**Simulation result:**
![image](https://user-images.githubusercontent.com/42515502/140647778-8e3e8b56-253d-4584-96a6-9cdcef15f6bf.png)


# Speed
![image](https://user-images.githubusercontent.com/42515502/140646790-8933f138-bd3a-4e96-953e-0b9f9390d91b.png)

Unconstrained critical path is 2.151 ns and corresponding speed is approximately 450 Mhz.  



