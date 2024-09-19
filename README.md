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
```bash
├── src/
│   ├── ADC_A_TEMP.vhd             # ADC data conversion to temperature
│   ├── div_frec.vhd               # Divides 50MHz clock to 1kHz
│   ├── aut_control.vhd            # Receiver control state machine
│   ├── TEMP_a_BCD.vhd             # Converts binary data to BCD for display
│   ├── Visualizacion.vhd/         # Controls the 7-segment display output
│       └── decodBCDa7s.vhd        # BCD to 7-segment decoder
│       └── MUX4x4.vhd             # 4-input 4-bit multiplexer
│       └── Refresco.vhd           # Refresh the displays periodically
│       └── Registro.vhd           # Stores the data of TENS, UNITS, and DECIMALS each time ENABLE is activated
│   ├── Termometro.vhd             # Interconnect all the previous modules      
│   └── asociaciones.ucf           # Connects the digital hardware with the FPGA components
│
├── README.md
└── 


