# 🌡️ Digital Thermometer Project

**Ever wondered how a thermometer works behind the scenes?** In this project, I built a **DIGITAL THERMOMETER** using an **LM35 sensor**, an **ADC MCP3201**, and an **FPGA**, all programmed in **VHDL**.

## 🚀 Features:
- **Analog to Digital Conversion**: The LM35 sensor reads temperature and sends the data to the ADC.
- **SPI Communication**: VHDL code ensures seamless communication between the ADC and the FPGA.
- **Clock Divider**: Reduces the 50MHz clock to 1kHz, providing stable timing for the system.
- **Data Processing**: Converts the analog sensor data into temperature values.
- **7-Segment Display**: Shows the temperature on a 7-segment display using a BCD conversion module.

## 🛠️ How It Works:
1. **Sensor**: The LM35 captures the analog temperature signal.
2. **Conversion**: The signal is converted to a digital value by the MCP3201 ADC.
3. **FPGA**: The FPGA, programmed with VHDL, processes the digital signal and converts it into a readable temperature value.
4. **Display**: The temperature is shown on a 7-segment display in real-time.

## 📂 Project Structure:

├── src/

│   ├── [ADC_to_TEMP.vhd](./src/ADC_to_TEMP.vhd)        # ADC data conversion to temperature

│   ├── [freq_div.vhd](./src/freq_div.vhd)               # Divides 50MHz clock to 1kHz

│   ├── [aut_control.vhd](./src/aut_control.vhd)        # Receiver control state machine

│   ├── [TEMP_to_BCD.vhd](./src/TEMP_to_BCD.vhd)        # Converts binary data to BCD for display

│   ├── Visualization/                                 # Contains the visual part

   │       ├── [decodBCDa7s.vhd](./src/Visualization/decodBCDa7s.vhd)  # BCD to 7-segment decoder

   │       ├── [MUX4x4.vhd](./src/Visualization/MUX4x4.vhd)         # 4-input 4-bit multiplexer

   │       ├── [Refresh.vhd](./src/Visualization/Refresh.vhd)        # Refresh the displays periodically

   │       ├── [Register.vhd](./src/Visualization/Register.vhd)      # Stores the data 

   │       └── [Visualization.vhd](./src/Visualization/Visualization.vhd) # Controls the 7-segment display output

│   ├── [Thermometer.vhd](./src/Thermometer.vhd)         # Interconnect all the previous modules

│   └── [conexions.ucf](./src/conexions.ucf)            # Connects the digital hardware with the FPGA components

│
├── [README.md](./README.md)

