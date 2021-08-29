library ieee;
use ieee.std_logic_1164.all;

entity mux4_to_1 is 
   port(input0,input1,input2,input3: in std_logic_vector(15 downto 0);
        sel:  in std_logic_vector(1 downto 0);
        out_put: out std_logic_vector(15 downto 0));
end mux4_to_1;

architecture behavioral of mux4_to_1 is 
  begin 
    mux: process(sel, input0,input1,input2,input3)
         begin 
            case sel is
                when "00" => out_put<= input0;
                when "01" => out_put<= input1;
                when "10" => out_put<= input2;
                when "11" => out_put<= input3;
            end case;
    end process;
end behavioral;


