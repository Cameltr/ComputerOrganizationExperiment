library ieee;
use ieee.std_logic_1164.all;

entity decoder2_to_4 is 
  port(sel: in std_logic_vector(1 downto 0);
       sel00: out std_logic;
       sel01: out std_logic;
       sel02: out std_logic;
       sel03: out std_logic
      );
end decoder2_to_4;

architecture behavioral of decoder2_to_4 is 
   begin 
     sel00<=(not sel(1)) and (not sel(0));
     sel01<=(not sel(1)) and sel(0);
     sel02<= sel(1) and (not sel(0));
     sel03<= sel(1) and sel(0);
   end behavioral;

