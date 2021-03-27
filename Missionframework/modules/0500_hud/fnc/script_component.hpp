
// ...

#define MODULE hud

#define Q(x) #x

#define MPARAM(arg) KPLIB_param_##MODULE##arg
#define QMPARAM(arg) Q(MPARAM(arg))

#define MVAR(var) KPLIB_##MODULE##var
#define QMVAR(var) Q(MVAR(var))

#define MFUNC(var) KPLIB_fnc_##MODULE##var
#define QMFUNC(var) Q(MFUNC(var))

#define MSTATUS(var) KPLIB_##MODULE##_status##var
#define QMSTATUS(var) Q(MSTATUS(var))

#define MFOB(rep) KPLIB_##MODULE##_fob##rep
#define QMFOB(rep) Q(MFOB(rep))

#define MSECTOR(rep) KPLIB_##MODULE##_sector##rep
#define QMSECTOR(rep) Q(MSECTOR(rep))

#define MOVERLAY(x) KPLIB_##MODULE##x
#define QMOVERLAY(x) Q(MOVERLAY(x))
