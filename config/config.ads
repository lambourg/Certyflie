------------------------------------------------------------------------------
--                              Certyflie                                   --
--                                                                          --
--                     Copyright (C) 2015-2016, AdaCore                     --
--                                                                          --
--  This library is free software;  you can redistribute it and/or modify   --
--  it under terms of the  GNU General Public License  as published by the  --
--  Free Software  Foundation;  either version 3,  or (at your  option) any --
--  later version. This library is distributed in the hope that it will be  --
--  useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                    --
--                                                                          --
--  As a special exception under Section 7 of GPL version 3, you are        --
--  granted additional permissions described in the GCC Runtime Library     --
--  Exception, version 3.1, as published by the Free Software Foundation.   --
--                                                                          --
--  You should have received a copy of the GNU General Public License and   --
--  a copy of the GCC Runtime Library Exception along with this program;    --
--  see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see   --
--  <http://www.gnu.org/licenses/>.                                         --
--                                                                          --
--  As a special exception, if other files instantiate generics from this   --
--  unit, or you link this unit with other files to produce an executable,  --
--  this  unit  does not  by itself cause  the resulting executable to be   --
--  covered by the GNU General Public License. This exception does not      --
--  however invalidate any other reasons why the executable file  might be  --
--  covered by the  GNU Public License.                                     --
------------------------------------------------------------------------------

with Ada.Real_Time; use Ada.Real_Time;
with System;

with Types;         use Types;
with MPU9250;       use MPU9250;

package Config is

   --  Constants used to configure the drone firmware

   --  Crazyflie 2.0 has an SMTM32F4 board
   STM32F4XX : constant Boolean := True;
   QUAD_FORMATION_X : constant Boolean := True;
   CPU_CLOCK_HZ : constant T_Uint32 := 168000000;
   TICK_RATE_HZ : constant T_Uint16 := 1000;
   TICK_RATE_MS : constant T_Uint16 := 1000 / TICK_RATE_HZ;

   --  Task priorities
   MAIN_TASK_PRIORITY      : constant System.Priority := 4;
   CRTP_RXTX_TASK_PRIORITY : constant System.Priority := 2;
   SYSLINK_TASK_PRIORITY   : constant System.Priority := 3;
   LOG_TASK_PRIORITY       : constant System.Priority := 1;
   PM_TASK_PRIORITY        : constant System.Priority := 0;

   --  Link layers implemented to communicate via the CRTP protocol
   type Link_Layer is (RADIO_LINK, USB_LINK, ESKY_LINK);
   LINK_LAYER_TYPE : constant Link_Layer := RADIO_LINK;

   PORT_MAX_DELAY : constant T_Uint16 := T_Uint16'Last;

   PORT_MAX_DELAY_TIME_MS : constant Time_Span
     := Milliseconds (Integer (PORT_MAX_DELAY / TICK_RATE_MS));

   --  Radio configuration
   RADIO_CHANNEL       : constant := 80;
   RADIO_DATARATE      : constant := 0;

   --  IMU configuration
   IMU_GYRO_FS_CONFIG  : constant MPU9250_FS_Gyro_Range :=
                           MPU9250_Gyro_FS_1000;
   IMU_ACCEL_FS_CONFIG : constant MPU9250_FS_Accel_Range :=
                           MPU9250_Accel_FS_4;

   --  Sensor Fusion Configuration

   --  madwick quaternion imu
   MADWICK_BETA : constant := 0.01;

   --  Mahony quaternion imu
   MAHONY_TWO_KP : constant := 2.0 * 0.4;
   MAHONY_TWO_KI : constant := 2.0 * 0.001;

   --  PID
--     PID_KP_ROLL_PITCH_RATE      : constant := 70.0;
--     PID_KI_ROLL_PITCH_RATE      : constant := 0.0;
--     PID_KD_ROLL_PITCH_RATE      : constant := 0.0;
--     PID_I_LIMIT_ROLL_PITCH_RATE : constant := 33.3;

   PID_KP_ROLL_PITCH_RATE      : constant := 250.0;
   PID_KI_ROLL_PITCH_RATE      : constant := 500.0;
   PID_KD_ROLL_PITCH_RATE      : constant := 2.5;
   PID_I_LIMIT_ROLL_PITCH_RATE : constant := 33.3;

   PID_KP_YAW_RATE             : constant := 70.0;
   PID_KI_YAW_RATE             : constant := 16.7;
   PID_KD_YAW_RATE             : constant := 0.0;
   PID_I_LIMIT_YAW_RATE        : constant := 166.7;

   PID_KP_ROLL_PITCH           : constant := 3.5;
   PID_KI_ROLL_PITCH           : constant := 2.0;
   PID_KD_ROLL_PITCH           : constant := 0.0;
   PID_I_LIMIT_ROLL_PITCH      : constant := 20.0;

   PID_KP_YAW                  : constant := 10.0;
   PID_KI_YAW                  : constant := 1.0;
   PID_KD_YAW                  : constant := 0.35;
   PID_I_LIMIT_YAW             : constant := 360.0;

end Config;
