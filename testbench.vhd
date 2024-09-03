library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity room_occupancy_tb is
end;

architecture bench of room_occupancy_tb is

  component room_occupancy
      port (
          clk, reset : in std_logic;
          X, Y : in std_logic;
          max_occupancy : in unsigned(6 downto 0);
          number_occupants : out unsigned(6 downto 0);
          Z : out std_logic
      );
  end component;

  signal clk, reset, X, Y: std_logic;
  signal max_occupancy: unsigned(6 downto 0);
  signal number_occupants: unsigned(6 downto 0);
  signal Z: std_logic;

begin

  uut: room_occupancy port map ( clk => clk,
                                 reset => reset,
                                 X => X,
                                 Y => Y,
                                 max_occupancy => max_occupancy,
                                 number_occupants => number_occupants,
                                 Z => Z );

  -- Clock generation
  clk_process: process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
  end process;

  stimulus: process
  begin
    -- Reset the system
    reset <= '1';
    wait for 20 ns;
    reset <= '0';

    -- Set max_occupancy
    max_occupancy <= to_unsigned(63, max_occupancy'length);

    -- Add occupants using a loop
    for i in 1 to 65 loop
      X <= '1'; Y <= '0';
      wait for 20 ns; -- Ensure sufficient time for clock edge
      X <= '0';
      wait for 20 ns; -- Ensure sufficient time for clock edge
    end loop;

    -- Remove occupants using a loop
    for i in 1 to 40 loop
      X <= '0'; Y <= '1';
      wait for 20 ns; -- Ensure sufficient time for clock edge
      Y <= '0';
      wait for 20 ns; -- Ensure sufficient time for clock edge
    end loop;
    for i in 1 to 10 loop
      X <= '1'; Y <= '1';
      wait for 20 ns; -- Ensure sufficient time for clock edge
    end loop;

    wait;
  end process;

end;

