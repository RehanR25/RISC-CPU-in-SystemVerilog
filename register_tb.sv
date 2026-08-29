#! /usr/bin/vvp
:ivl_version "12.0 (stable)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/system.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/vhdl_sys.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/vhdl_textio.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/v2005_math.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/va_math.vpi";
S_0x5646e8fd02e0 .scope module, "register" "register" 2 1;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "clock";
    .port_info 1 /INPUT 1 "reset";
    .port_info 2 /INPUT 4 "data";
    .port_info 3 /OUTPUT 4 "stored_val";
o0x770bfb523018 .functor BUFZ 1, C4<z>; HiZ drive
v0x5646e8fd0500_0 .net "clock", 0 0, o0x770bfb523018;  0 drivers
o0x770bfb523048 .functor BUFZ 4, C4<zzzz>; HiZ drive
v0x5646e8ff1c40_0 .net "data", 3 0, o0x770bfb523048;  0 drivers
o0x770bfb523078 .functor BUFZ 1, C4<z>; HiZ drive
v0x5646e8ff1d20_0 .net "reset", 0 0, o0x770bfb523078;  0 drivers
v0x5646e8ff1df0_0 .var "stored_val", 3 0;
E_0x5646e8fe32a0 .event posedge, v0x5646e8fd0500_0;
    .scope S_0x5646e8fd02e0;
T_0 ;
    %wait E_0x5646e8fe32a0;
    %load/vec4 v0x5646e8ff1d20_0;
    %pad/u 32;
    %cmpi/e 1, 0, 32;
    %jmp/0xz  T_0.0, 4;
    %pushi/vec4 0, 0, 4;
    %assign/vec4 v0x5646e8ff1df0_0, 0;
    %jmp T_0.1;
T_0.0 ;
    %load/vec4 v0x5646e8ff1c40_0;
    %assign/vec4 v0x5646e8ff1df0_0, 0;
T_0.1 ;
    %jmp T_0;
    .thread T_0;
# The file index is used to find the file name in the following table.
:file_names 3;
    "N/A";
    "<interactive>";
    "RTL/register.sv";
