with Types; use Types;
with Syslink_Pack; use Syslink_Pack;
with LEDS_Pack; use LEDS_Pack;

package Power_Management_Pack is

   --  Types

   --  Type reperesenting the current power state
   type Power_State is (Battery, Charging, Charged, Low_Power, Shut_Down);

   --  Type representing the current charge state
   type Power_Charge_State is (Charge_100_MA, Charge_500_MA, Charge_MAX);

   --  Types used for Syslink packet translation
   type Power_Syslink_Info_Repr is (Normal, Flags_Detailed);

   type T_Uint6 is mod 2 ** 6;
   for T_Uint6'Size use 6;


   type Power_Syslink_Info (Repr : Power_Syslink_Info_Repr := Normal) is record
      case Repr is
         when Normal =>
            Flags            : T_Uint8;
            V_Bat_1          : Float;
            Current_Charge_1 : Float;
         when Flags_Detailed =>
            Pgood            : Boolean;
            Charging         : Boolean;
            Unused           : T_Uint6;
            V_Bat_2          : Float;
            Current_Charge_2 : Float;
      end case;
   end record;

   pragma Unchecked_Union (Power_Syslink_Info);
   for Power_Syslink_Info'Size use 72;
   pragma Pack (Power_Syslink_Info);

   --  Procedures and functions

   --  Initialize the power management module
   procedure Power_Management_Init;

   --  Update the power state information
   procedure Power_Management_Syslink_Update (Sl_Packet : Syslink_Packet);

   --  Get the current power state
   function Power_Management_Get_State return Power_State;

   --  Return True is the Crazyflie is discharging, False when it's charging
   function Power_Management_Is_Discharging return Boolean;

private

   --  Global variables and constants

   --  Current power information received from NFR51
   Current_Power_Info : Power_Syslink_Info;

   --  LEDs to switch on according power state
   Charging_LED : constant Crazyflie_LED := LED_RED_L;
   Charged_LED  : constant Crazyflie_LED := LED_Green_L;

   --  Prcoedures and functions

   --  Switch on/off the power related leds according to power state
   procedure Set_Power_LEDs (State : Power_State);

end Power_Management_Pack;
