library ieee;
use ieee.std_logic_1164.all;

entity test is
    generic (
        G_A : natural
    );
    port (
        a : std_logic_vector(G_A - 1 downto 0)
    );
end entity;
