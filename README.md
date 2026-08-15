# Vending_Machine_FPGA

## Project Overview
This project is a digital vending machine controller implemented on the Zybo Z7 development board.

Using Verilog HDL, I designed a hardware-level solution to handle physical switch noise (bouncing) and implemented a Finite State Machine to control the coin insertion and product dispensing logic.

## Environment
* **Board**: Digilent Zybo Z7-10 (Zynq-7000 ARM/FPGA SoC)
* **IDE**: Xilinx Vivado
* **Language**: Verilog HDL

## Feature
* **Hardware Button Debouncing:** Implemented a counter-based noise filter (10ms delay) to prevent malfunctions caused by the physical bouncing of mechanical switches.
* **Edge Detector:** Generates a clean 1-clock pulse from the debounced signal to prevent FSM errors caused by long button presses.
* **3-Process FSM (Moore Machine):**
  * Manages the state of inserted coins (Dime and Quarter).
  * Transitions to the product dispense (PAID) state upon reaching a total of 35 cents, followed by an automatic reset to the initial state.
* **LED Visual Feedback (Timer):**
  * Scaled down the 125MHz main clock to create a timer logic that keeps the LEDs turned on for 0.5 seconds when a coin is accepted (Accept) and when a product is dispensed (Paid) for clear visual feedback.
 
## Module Structure
* 'top.v': The top-level module (handles sub-module instantiation and LED timer logic).
* 'debouncer.v': Eliminates bouncing using 2-stage Flip-Flop synchronization and a time-delay counter.
* 'edge_detector.v': Detects the rising edge of the input signal to create a single-cycle pulse.
* 'FSM.v': Controls the state transitions (Next State Logic) and outputs (Output Logic) of the vending machine.

## State Diagram
