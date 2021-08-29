library ieee;
use ieee.std_logic_1164.all;

entity register_16 is port
   (reset:   in std_logic;
    d_input: in std_logic_vector(15 downto 0);
    clk:     in std_logic;
    write:   in std_logic;
    sel:     in std_logic;
    q_output: out std_logic_vector(15 downto 0)
   );
end register_16;

architecture a of register_16 is 
   begin 
      process(reset,clk)
         begin      
           if reset='0' then 
              q_output<=x"0000";
            elsif(clk'event and clk='1') then
               if sel='1' and write='1' then 
                  q_output<=d_input;
         end if;
      end if;
   end process;
end a;
