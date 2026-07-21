# ITI-BQS-Digital-IC-Design-Graduation-Project
A modular Verilog HDL implementation of a Bank Queue System featuring FSM-based queue management, customer counting, waiting-time prediction, and real-time display on seven-segment displays.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Bank Queue System (BQS)

A **Bank Queue System (BQS)** developed in **Verilog HDL** as a Digital IC Design graduation project at the **Information Technology Institute (ITI)**. The project presents a complete digital hardware solution for automating customer queue management by monitoring customer movement, tracking queue occupancy, estimating waiting time, and providing real-time status information through seven-segment displays. The system demonstrates the practical application of digital logic design concepts to solve a real-world problem using a modular and scalable hardware architecture.

The design follows a **Register Transfer Level (RTL)** methodology, where each subsystem is implemented as an independent and reusable module. The overall architecture consists of a **Finite State Machine (FSM)** controller, edge detection circuits, a synchronous up/down occupancy counter, a waiting-time estimation ROM, a waiting-time decoder, seven-segment display decoders, and a top-level module responsible for integrating all system components. This modular organization simplifies debugging, verification, maintenance, and future expansion while promoting good digital design practices.

Customer entry and exit are detected using synchronized optical sensor inputs processed by dedicated edge detection circuits. These circuits convert sensor transitions into single-clock pulses, ensuring that every customer movement is counted only once regardless of sensor activation duration. The FSM supervises the entire queue management process by validating entry and exit events, enabling the occupancy counter, updating queue status, and controlling the generation of system flags and alarms. The occupancy counter continuously maintains the number of customers currently waiting in the queue.

To estimate customer waiting time efficiently, the design employs a ROM-based lookup table instead of arithmetic computations. The ROM stores predefined waiting times corresponding to the current queue occupancy and the number of active service tellers. This approach reduces hardware complexity while providing fast and deterministic waiting-time estimation. The resulting waiting time, together with the current customer count, is decoded and displayed using seven-segment displays, allowing both customers and operators to monitor the queue status in real time.

To improve system reliability, the controller detects exceptional operating conditions such as queue overflow and underflow. When the queue reaches its maximum capacity, a **FULL_FLAG** is asserted and any additional entry attempt activates a **FULL_ALARM**. Similarly, when the queue becomes empty, an **EMPTY_FLAG** is asserted and any further exit attempt generates an **EMPTY_ALARM**. These protection mechanisms prevent invalid operations while ensuring consistent system behavior.

The project was developed using synchronous digital design principles and thoroughly verified through simulation using **QuestaSim**. Functional verification covered normal queue operation, customer entry and exit, counter updates, waiting-time generation, display outputs, and exceptional operating conditions. The resulting design demonstrates the effective use of finite state machines, sequential and combinational logic, memory-based lookup techniques, and hierarchical RTL design to implement a reliable, efficient, and maintainable digital queue management system.

## Key Features

- Modular and hierarchical Verilog HDL design
- Finite State Machine (FSM)-based queue management
- Synchronized edge detection for customer entry and exit sensors
- Real-time customer occupancy tracking
- ROM-based waiting-time estimation
- Seven-segment display interface for occupancy and waiting time
- Queue full and empty detection
- Status flags and alarm generation for invalid operations
- Comprehensive RTL simulation and functional verification
- Clean, reusable, and scalable hardware architecture

## Technologies Used

- Verilog HDL
- SystemVerilog (Testbench)
- Intel Quartus Prime
- QuestaSim
- Register Transfer Level (RTL) Design
- Finite State Machines (FSM)
- Digital Logic Design
```
