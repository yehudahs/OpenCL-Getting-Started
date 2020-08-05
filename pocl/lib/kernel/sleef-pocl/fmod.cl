#include "sleef_cl.h"

_CL_OVERLOADABLE
float
_cl_fmod (float x, float y)
{
  return Sleef_fmodf (x, y);
}

_CL_OVERLOADABLE
float2
_cl_fmod (float2 x, float2 y)
{

  float lo = _cl_fmod (x.lo, y.lo);
  float hi = _cl_fmod (x.hi, y.hi);
  return (float2) (lo, hi);
}

_CL_OVERLOADABLE
float4 _cl_fmod (float4, float4);

_CL_OVERLOADABLE
float3
_cl_fmod (float3 x, float3 y)
{

  float4 x_3to4 = (float4) (x, (float)0);
  float4 y_3to4 = (float4) (y, (float)0);

  float4 r = _cl_fmod (x_3to4, y_3to4);
  return r.xyz;
}

_CL_OVERLOADABLE
float4
_cl_fmod (float4 x, float4 y)
{

#if defined(SLEEF_VEC_128_AVAILABLE)
  return Sleef_fmodf4 (x, y);
#else

  float2 lo = _cl_fmod (x.lo, y.lo);
  float2 hi = _cl_fmod (x.hi, y.hi);
  return (float4) (lo, hi);

#endif
}

_CL_OVERLOADABLE
float8
_cl_fmod (float8 x, float8 y)
{

#if defined(SLEEF_VEC_256_AVAILABLE)
  return Sleef_fmodf8 (x, y);
#else

  float4 lo = _cl_fmod (x.lo, y.lo);
  float4 hi = _cl_fmod (x.hi, y.hi);
  return (float8) (lo, hi);

#endif
}

_CL_OVERLOADABLE
float16
_cl_fmod (float16 x, float16 y)
{

#if defined(SLEEF_VEC_512_AVAILABLE)
  return Sleef_fmodf16 (x, y);
#else

  float8 lo = _cl_fmod (x.lo, y.lo);
  float8 hi = _cl_fmod (x.hi, y.hi);
  return (float16) (lo, hi);

#endif
}

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double
_cl_fmod (double x, double y)
{
  return Sleef_fmod (x, y);
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double2
_cl_fmod (double2 x, double2 y)
{

#if defined(SLEEF_VEC_128_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)
  return Sleef_fmodd2 (x, y);
#else

  double lo = _cl_fmod (x.lo, y.lo);
  double hi = _cl_fmod (x.hi, y.hi);
  return (double2) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double4 _cl_fmod (double4, double4);

_CL_OVERLOADABLE
double3
_cl_fmod (double3 x, double3 y)
{

  double4 x_3to4 = (double4) (x, (double)0);
  double4 y_3to4 = (double4) (y, (double)0);

  double4 r = _cl_fmod (x_3to4, y_3to4);
  return r.xyz;
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double4
_cl_fmod (double4 x, double4 y)
{

#if defined(SLEEF_VEC_256_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)
  return Sleef_fmodd4 (x, y);
#else

  double2 lo = _cl_fmod (x.lo, y.lo);
  double2 hi = _cl_fmod (x.hi, y.hi);
  return (double4) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double8
_cl_fmod (double8 x, double8 y)
{

#if defined(SLEEF_VEC_512_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)
  return Sleef_fmodd8 (x, y);
#else

  double4 lo = _cl_fmod (x.lo, y.lo);
  double4 hi = _cl_fmod (x.hi, y.hi);
  return (double8) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double16
_cl_fmod (double16 x, double16 y)
{

  double8 lo = _cl_fmod (x.lo, y.lo);
  double8 hi = _cl_fmod (x.hi, y.hi);
  return (double16) (lo, hi);
}

#endif /* cl_khr_fp64 */
