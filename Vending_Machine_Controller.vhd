library IEEE ;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Vending_Machine_Controller is
port(
clk :  in std_logic;
rst  : in std_logic;
coin_in : in integer;
coin_out  :  out integer;
proceed :  in std_logic ;
sanitizer , tissue_paper  , paper_soap   : in integer ;
total :out integer;
delivered : out std_logic);
end Vending_machine_Controller ;

architecture Behavioural of Vending_Machine_Controller is 

type state is (idle ,review, select_item , payment_status, refund );
signal p_s : state ;


begin

process(clk,rst,p_s, coin_in)
variable temp : integer;
begin
if (rst ='1') then
p_s <=  idle ;
elsif (clk'event and clk ='1')  then 

case p_s is 

when idle => 
p_s  <= select_item ;

when select_item => 
temp  := (10 *sanitizer + 5  *tissue_paper + 1 *paper_soap );
total <= temp ;
p_s <= review ;
when review  =>
if (proceed ='1')  then 
p_s <=  payment_status;
elsif(proceed = '0' )  then
p_s <= select_item ;
end if ;

when payment_status =>
if (temp <= coin_in) then 
delivered <= '1' ;
p_s  <= refund ;
elsif(temp > coin_in ) then 
delivered <= '0' ;
coin_out <= coin_in ;
p_s <= payment_status;

end if ;
when refund =>

coin_out <= coin_in-temp;

end case;
end if;
end process;
end Behavioural;





