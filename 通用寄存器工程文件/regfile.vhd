library ieee;
use ieee.std_logic_1164.all;

entity regfile is
  port(DR: in std_logic_vector(1 downto 0);
       SR: in std_logic_vector(1 downto 0);
       reset:   in std_logic;
       DRWr:    in std_logic;
       clk:     in std_logic;
       d_input: in std_logic_vector(15 downto 0);
       DR_data: out std_logic_vector(15 downto 0);
       SR_data: out std_logic_vector(15 downto 0)
      );
end regfile;

architecture struct of regfile is 
   component register_16
      port(reset,clk,write,sel: in std_logic;
           d_input: in std_logic_vector(15 downto 0);
           q_output: out std_logic_vector(15 downto 0)
           );
   end component;

   component decoder2_to_4
      port(sel: in std_logic_vector(1 downto 0);
           sel00,sel01,sel02,sel03: out std_logic
           );
   end component;

    component mux4_to_1
      port(input0,input1,input2,input3: in std_logic_vector(15 downto 0);
           sel:     in std_logic_vector(1 downto 0);
           out_put: out std_logic_vector(15 downto 0)
           );
   end component;

       signal reg00,reg01,reg02,reg03: std_logic_vector(15 downto 0);
       signal sel00,sel01,sel02,sel03: std_logic;

   begin
     Areg00:register_16 port map(
             reset   => reset,
             d_input => d_input,
             clk     => clk,
             write   => DRWr,
             sel     => sel00,
             q_output=> reg00
            );
     Areg01:register_16 port map(
             reset   => reset,
             d_input => d_input,
             clk     => clk,
             write   => DRWr,
             sel     => sel01,
             q_output=> reg01
            );
      Areg02:register_16 port map(
             reset   => reset,
             d_input => d_input,
             clk     => clk,
             write   => DRWr,
             sel     => sel02,
             q_output=> reg02
            );
      Areg03:register_16 port map(
             reset   => reset,
             d_input => d_input,
             clk     => clk,
             write   => DRWr,
             sel     => sel03,
             q_output=> reg03
            );
       decoder: decoder2_to_4 port map(
             sel     => DR,
             sel00   => sel00,
             sel01   => sel01,
             sel02   => sel02,
             sel03   => sel03
           );
       mux1:  mux4_to_1 port map(
             input0 => reg00,
             input1 => reg01,
             input2 => reg02,
             input3 => reg03,
             sel    => DR,
             out_put =>DR_data
           );
        mux2:  mux4_to_1 port map(
             input0 => reg00,
             input1 => reg01,
             input2 => reg02,
             input3 => reg03,
             sel    => SR,
             out_put =>SR_data
           );
end struct;



