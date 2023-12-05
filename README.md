# Ford-GT-Wing

Pro-bono project made for Axis' Ford GT mod.

## Wing behavior breakdown:
The Ford GT 2020 features an active rear wing that adjusts its behavior based on the vehicle's speed and braking status. Here's a breakdown of the wing behavior:

https://github.com/plus-and-other-arithmetic-operations/Ford-GT-Wing/assets/88043761/e18523c8-f90d-4310-80f4-2d38e2456710

### Speed-Dependent Adjustment:

> **When the vehicle speed exceeds 114 km/h**, the rear wing automatically raises to an elevated position.
> 
> This elevated position contributes to increased aerodynamic downforce for enhanced stability at high speeds.

### Inactive Airbrake at Low Speeds:

> **When the vehicle speed drops below 114 km/h**, the rear wing returns to its default, lowered position.
> 
> At these lower speeds, the airbrake function is inactive, allowing for improved fuel efficiency and a sleeker profile.


### Braking-Activated Airbrake:

> **If the vehicle is traveling at speeds above 114 km/h**, and the driver engages the brakes, the airbrake function is activated.
> 
> The rear wing raises to its airbrake position, contributing to increased downforce and aiding in deceleration.


### Wing Stays Active During Braking:

> **As long as the driver maintains the braking input at speeds over 114 km/h**, the rear wing remains in the airbrake position.
> 
> This ensures continuous aerodynamic assistance during braking for optimal performance and safety.


### Automatic Deactivation Post-Braking:

> **Once the driver releases the brakes, the airbrake function remains active until the vehicle speed drops below 114 km/h.**
> 
> At speeds below the threshold, the rear wing smoothly returns to its default, lowered position.

This adaptive wing behavior helps optimize the aerodynamics of the Ford GT 2020, providing a balance between high-speed stability, braking performance, and efficiency at lower speeds.


## Setup

Add the entry into the car's ext_config (car requires 2 animations for it to work: `wing.ksanim`, `wing_Brake.ksanim`):

```ini
[SCRIPT_...]
SCRIPT = wing.lua
```
