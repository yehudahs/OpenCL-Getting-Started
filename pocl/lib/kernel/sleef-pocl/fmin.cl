#include "sleef_cl.h"

_CL_OVERLOADABLE
float
_cl_fmin (float x, float y)
{
  return Sleef_fminf (x, y);
}

_CL_OVERLOADABLE
float2
_cl_fmin (float2 x, float2 y)
{

  float lo = _cl_fmin (x.lo, y.lo);
  float hi = _cl_fmin (x.hi, y.hi);
  return (float2) (lo, hi);
}

_CL_OVERLOADABLE
float4 _cl_fmin (float4, float4);

_CL_OVERLOADABLE
float3
_cl_fmin (float3 x, float3 y)
{

  float4 x_3to4 = (float4) (x, (float)0);
  float4 y_3to4 = (float4) (y, (float)0);

  float4 r = _cl_fmin (x_3to4, y_3to4);
  return r.xyz;
}

_CL_OVERLOADABLE
float4
_cl_fmin (float4 x, float4 y)
{

#if defined(SLEEF_VEC_128_AVAILABLE)
  return Sleef_fminf4 (x, y);
#else

  float2 lo = _cl_fmin (x.lo, y.lo);
  float2 hi = _cl_fmin (x.hi, y.hi);
  return (float4) (lo, hi);

#endif
}

_CL_OVERLOADABLE
float8
_cl_fmin (float8 x, float8 y)
{

#if defined(SLEEF_VEC_256_AVAILABLE)
  return Sleef_fminf8 (x, y);
#else

  float4 lo = _cl_fmin (x.lo, y.lo);
  float4 hi = _cl_fmin (x.hi, y.hi);
  return (float8) (lo, hi);

#endif
}

_CL_OVERLOADABLE
float16
_cl_fmin (float16 x, float16 y)
{

#if defined(SLEEF_VEC_512_AVAILABLE)
  return Sleef_fminf16 (x, y);
#else

  float8 lo = _cl_fmin (x.lo, y.lo);
  float8 hi = _cl_fmin (x.hi, y.hi);
  return (float16) (lo, hi);

#endif
}

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double
_cl_fmin (double x, double y)
{
  return Sleef_fmin (x, y);
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double2
_cl_fmin (double2 x, double2 y)
{

#if defined(SLEEF_VEC_128_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)
  return Sleef_fmind2 (x, y);
#else

  double lo = _cl_fmin (x.lo, y.lo);
  double hi = _cl_fmin (x.hi, y.hi);
  return (double2) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double4 _cl_fmin (double4, double4);

_CL_OVERLOADABLE
double3
_cl_fmin (double3 x, double3 y)
{

  double4 x_3to4 = (double4) (x, (double)0);
  double4 y_3to4 = (double4) (y, (double)0);

  double4 r = _cl_fmin (x_3to4, y_3to4);
  return r.xyz;
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double4
_cl_fmin (double4 x, double4 y)
{

#if defined(SLEEF_VEC_256_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)
  return Sleef_fmind4 (x, y);
#else

  double2 lo = _cl_fmin (x.lo, y.lo);
  double2 hi = _cl_fmin (x.hi, y.hi);
  return (double4) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double8
_cl_fmin (double8 x, double8 y)
{

#if defined(SLEEF_VEC_512_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)
  return Sleef_fmind8 (x, y);
#else

  double4 lo = _cl_fmin (x.lo, y.lo);
  double4 hi = _cl_fmin (x.hi, y.hi);
  return (double8) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double16
_cl_fmin (double16 x, double16 y)
{

  double8 lo = _cl_fmin (x.lo, y.lo);
  double8 hi = _cl_fmin (x.hi, y.hi);
  return (double16) (lo, hi);
}

#endif /* cl_khr_fp64 */
