#include "sleef_cl.h"

_CL_OVERLOADABLE
float
_cl_ceil (float x)
{
  return Sleef_ceilf (x);
}

_CL_OVERLOADABLE
float2
_cl_ceil (float2 x)
{

  float lo = _cl_ceil (x.lo);
  float hi = _cl_ceil (x.hi);
  return (float2) (lo, hi);
}

_CL_OVERLOADABLE
float4 _cl_ceil (float4);

_CL_OVERLOADABLE
float3
_cl_ceil (float3 x)
{

  float4 x_3to4 = (float4) (x, (float)0);

  float4 r = _cl_ceil (x_3to4);
  return r.xyz;
}

_CL_OVERLOADABLE
float4
_cl_ceil (float4 x)
{

#if defined(SLEEF_VEC_128_AVAILABLE)
  return Sleef_ceilf4 (x);
#else

  float2 lo = _cl_ceil (x.lo);
  float2 hi = _cl_ceil (x.hi);
  return (float4) (lo, hi);

#endif
}

_CL_OVERLOADABLE
float8
_cl_ceil (float8 x)
{

#if defined(SLEEF_VEC_256_AVAILABLE)
  return Sleef_ceilf8 (x);
#else

  float4 lo = _cl_ceil (x.lo);
  float4 hi = _cl_ceil (x.hi);
  return (float8) (lo, hi);

#endif
}

_CL_OVERLOADABLE
float16
_cl_ceil (float16 x)
{

#if defined(SLEEF_VEC_512_AVAILABLE)
  return Sleef_ceilf16 (x);
#else

  float8 lo = _cl_ceil (x.lo);
  float8 hi = _cl_ceil (x.hi);
  return (float16) (lo, hi);

#endif
}

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double
_cl_ceil (double x)
{
  return Sleef_ceil (x);
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double2
_cl_ceil (double2 x)
{

#if defined(SLEEF_VEC_128_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)
  return Sleef_ceild2 (x);
#else

  double lo = _cl_ceil (x.lo);
  double hi = _cl_ceil (x.hi);
  return (double2) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double4 _cl_ceil (double4);

_CL_OVERLOADABLE
double3
_cl_ceil (double3 x)
{

  double4 x_3to4 = (double4) (x, (double)0);

  double4 r = _cl_ceil (x_3to4);
  return r.xyz;
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double4
_cl_ceil (double4 x)
{

#if defined(SLEEF_VEC_256_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)
  return Sleef_ceild4 (x);
#else

  double2 lo = _cl_ceil (x.lo);
  double2 hi = _cl_ceil (x.hi);
  return (double4) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double8
_cl_ceil (double8 x)
{

#if defined(SLEEF_VEC_512_AVAILABLE) && defined(SLEEF_DOUBLE_VEC_AVAILABLE)
  return Sleef_ceild8 (x);
#else

  double4 lo = _cl_ceil (x.lo);
  double4 hi = _cl_ceil (x.hi);
  return (double8) (lo, hi);

#endif
}

#endif /* cl_khr_fp64 */

#ifdef cl_khr_fp64

_CL_OVERLOADABLE
double16
_cl_ceil (double16 x)
{

  double8 lo = _cl_ceil (x.lo);
  double8 hi = _cl_ceil (x.hi);
  return (double16) (lo, hi);
}

#endif /* cl_khr_fp64 */
