
// ...

#define MODULE hudDispatchSM

#define Q(x) #x

#define MPARAM(arg) KPLIB_param_##MODULE##arg
#define QMPARAM(arg) Q(MPARAM(arg))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(var) KPLIB_fnc_##MODULE##var
#define QMFUNC(var) Q(MFUNC(var))
