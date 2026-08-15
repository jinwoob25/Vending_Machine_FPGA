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
