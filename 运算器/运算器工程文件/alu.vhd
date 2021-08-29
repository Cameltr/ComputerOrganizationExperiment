library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu is
port(cin:in std_logic;
     alu_a,alu_b:in std_logic_vector(15 downto 0);
     alu_func:in std_logic_vector(2 downto 0);
     alu_out:out std_logic_vector(15 downto 0);
     c,z,v,s:out std_logic);
end alu;

architecture behave of alu is
begin
	process(alu_a,alu_b,cin,alu_func)
	variable temp1,temp2,temp3 : std_logic_vector(15 downto 0) ;
	begin
		temp1 := "000000000000000"&cin;
		case alu_func is
			when "000"=>
			temp2 := alu_b+alu_a+temp1;
			when "001"=>
			temp2 := alu_b-alu_a-temp1;
			when "010"=>
			temp2 := alu_a and alu_b;
			when "011"=>
			temp2 := alu_a or alu_b;
			when "100"=>
			temp2 := alu_a xor alu_b;
			when "101"=>
			temp2(0) := '0';
			for I in 15 downto 1 loop
			temp2(I) := alu_b(I-1);
			end loop;
			when "110"=>
			temp2(15) := '0';
			for I in 14 downto 0 loop
			temp2(I) := alu_b(I+1);
			end loop;
			when others=>
			temp2 := "0000000000000000";
		end case;
		alu_out <= temp2;
		if temp2 = "0000000000000000" then z<='1';
		else z<='0';
		end if;
		if temp2(15) = '1' then s<='1';
		else s<='0';
		end if;
		case alu_func is
			when "000" | "001"=>
			if (alu_a(15)= '1' and alu_b(15)= '1' and temp2(15) = '0') or
			   (alu_a(15)= '0' and alu_b(15)= '0' and temp2(15) = '1') then
			v<='1';
			else v<='0';
			end if;
			when others=>
			v<='0';
		end case;
		case alu_func is
			when "000"=>
			temp3 := "1111111111111111"-alu_b-temp1;
			if temp3<alu_a then
			c<='1';
			else c<='0';
			end if;
			when "001"=>
			if alu_b<alu_a then
			c<='1';
			else c<='0';
			end if;
			when "101"=>
			c <= alu_b(15);
			when "110"=>
			c <= alu_b(0);
			when others=>
			c<='0';
		end case;
	end process;
end behave;
