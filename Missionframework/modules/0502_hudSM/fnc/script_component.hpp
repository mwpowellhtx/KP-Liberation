
// ...

#define MODULE hudSM

#define Q(x) #x

// HUD related bits
#define MPARAM(arg) KPLIB_param_##MODULE##arg
#define QMPARAM(arg) Q(MPARAM(arg))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(var) KPLIB_fnc_##MODULE##var
#define QMFUNC(var) Q(MFUNC(var))

#define MSTATUS(var) KPLIB_##MODULE##_status##var
#define QMSTATUS(var) Q(MSTATUS(var))

#define MLAYER(x) KPLIB_##MODULE##_layer##x
#define QMLAYER(x) Q(MLAYER(x))
