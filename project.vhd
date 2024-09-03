library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity room_occupancy is
    port (
        clk, reset : in std_logic;
        X, Y : in std_logic;
        max_occupancy : in unsigned(6 downto 0);
        number_occupants : out unsigned(6 downto 0);
        Z : out std_logic
    );
end room_occupancy;

architecture occupancy_arch of room_occupancy is
    signal count : unsigned(6 downto 0) := (others => '0');
    signal room_state : std_logic := '0';
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                count <= (others => '0');
                room_state <= '0'; -- Room not full, light off
            elsif (X = '1' and Y = '0') then
                if count < max_occupancy then
                    count <= count + 1;
                end if;
                if count = max_occupancy - 1 then
                    room_state <= '1'; -- Room full, light on
                end if;
            elsif (Y = '1' and X = '0' and count > 0) then
                count <= count - 1;
                room_state <= '0'; -- Room not full, light off
            end if;
        end if;
    end process;
            Z <= room_state;
            number_occupants <= count;
end occupancy_arch;

	

