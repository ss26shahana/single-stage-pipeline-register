# Single-Stage Pipeline Register (SystemVerilog)

This repository contains a synthesizable SystemVerilog implementation of a
single-stage pipeline register using a standard valid/ready handshake.

## Description
The module sits between an input (producer) and output (consumer) interface.
It accepts data when `in_valid` and `in_ready` are asserted, stores one data
item internally, and presents it on the output with `out_valid`. The design
handles backpressure correctly without data loss or duplication and resets
to a clean empty state.

## Features
- Single-entry pipeline register (1-stage buffer)
- Standard valid/ready handshake
- Proper backpressure handling
- No data loss or duplication
- Active-high reset to empty state
- Fully synthesizable RTL

## Interface
- Input: `in_valid`, `in_ready`, `in_data [7:0]`
- Output: `out_valid`, `out_ready`, `out_data [7:0]`
- Clocked design with active-high reset


## Verification
The design was verified using waveform simulation in EDA Playground (EPWave),
observing correct valid/ready handshake behavior and data flow.

## How to Use
Instantiate `pipeline_reg_1stage` between a producer and consumer that follow
the valid/ready handshake protocol.


## File Structure
src/pipeline_reg_1stage.sv
